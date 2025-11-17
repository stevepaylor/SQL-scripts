USE DBA
GO

-- create UDF to convert SID to text for output

IF EXISTS (select * from Information_schema.Routines where SPECIFIC_SCHEMA='dbo' AND SPECIFIC_NAME = 'fn_SIDToString' AND Routine_Type='FUNCTION')
DROP FUNCTION fn_SIDToString;
GO

CREATE FUNCTION fn_SIDToString
(
  @BinSID AS VARBINARY(100)
)
RETURNS VARCHAR(100)
AS 
BEGIN

  IF LEN(@BinSID) % 4 <> 0 RETURN(NULL)

  DECLARE @StringSID VARCHAR(100)
  DECLARE @i AS INT
  DECLARE @j AS INT

  SELECT @StringSID = 'S-'
     + CONVERT(VARCHAR, CONVERT(INT, CONVERT(VARBINARY, SUBSTRING(@BinSID, 1, 1)))) 
  SELECT @StringSID = @StringSID + '-'
     + CONVERT(VARCHAR, CONVERT(INT, CONVERT(VARBINARY, SUBSTRING(@BinSID, 3, 6))))

  SET @j = 9
  SET @i = LEN(@BinSID)

  WHILE @j < @i
  BEGIN
    DECLARE @val BINARY(4)
    SELECT @val = SUBSTRING(@BinSID, @j, 4)
    SELECT @StringSID = @StringSID + '-'
      + CONVERT(VARCHAR, CONVERT(BIGINT, CONVERT(VARBINARY, REVERSE(CONVERT(VARBINARY, @val))))) 
    SET @j = @j + 4
  END
  RETURN ( @StringSID ) 
END
GO

-- Create the proc

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[isp_ObjectInventory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[isp_ObjectInventory]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Steve Paylor
-- Create date: 2019-04-30
-- Description:	Create Object Inventory Stored Proc
-- =============================================
CREATE PROCEDURE isp_ObjectInventory
AS
BEGIN

  SET NOCOUNT ON;


  -- Empty and reload the Inventory_Temp table with list of all databases, jobs and logins on the server

  TRUNCATE TABLE DBA.dbo.Inventory_Temp

  INSERT INTO DBA.dbo.Inventory_Temp
  SELECT 
    @@SERVERNAME AS Instance
  , 'Job'  AS Object_type
  , job_id AS ID
  , [name] 
  , date_created
  , date_modified
  , NULL AS sid
  FROM msdb.dbo.sysjobs;

  INSERT INTO DBA.dbo.Inventory_Temp
  SELECT 
    @@SERVERNAME AS Instance
  , 'Database' AS Object_type
  , database_id AS ID
  , [name]
  , create_date AS date_created
  , NULL AS date_modified
  , NULL AS sid
  FROM master.sys.databases 
  WHERE database_id > 4 -- Ignore system databases
    AND [name] NOT LIKE 'ReportServer%';  -- Ignore SSRS databases

  INSERT INTO DBA.dbo.Inventory_Temp
  SELECT
    @@SERVERNAME AS Instance
  , 'Login'  AS Object_type
  , principal_id AS ID
  , [name]
  , create_date AS date_created
  , NULL AS date_modified
  , CAST(DBA.dbo.fn_SIDToString(sid) AS varchar(50))
  FROM master.sys.server_principals
  WHERE type_desc IN ('SQL_LOGIN','WINDOWS_LOGIN')  
    AND [name] NOT LIKE 'NT %' -- ignore standard system logins
    AND [name] NOT LIKE '##%' -- ignore standard system logins
	AND [name] NOT IN ('sa','DBAdmin','ITappsDBA','VIEJAS\hmccoy','VIEJAS\hsimpson','VIEJAS\pparker','VIEJAS\iderasvc01','VIEJAS\ITappsSQLadmin','VIEJAS\spaylor','VIEJAS\SQLService1','VIEJAS\bcamelo','VIEJAS\bgriffin','VIEJAS\hsimpson')

--SELECT *
--FROM DBA.dbo.Inventory_Temp

  -- Merge Inventory_Temp table into Inventory table (perm). Does the following:
  -- 1. Adds new records - sets New_Object_Flag so that it will included on report 
  -- 2. Updates existing records with date_updated and date_modified 
  -- 3. Sets deleted_date for records not found in temp table (object has been deleted) 

  MERGE INTO DBA.dbo.Inventory AS I -- Target Table
  USING DBA.dbo.Inventory_Temp AS W -- Source Table  
  ON  I.Instance = W.Instance
  AND I.Object_type = W.Object_type
  AND I.[ID] = W.[ID]
  AND I.[name] = W.[name]

  -- Add new records

  WHEN NOT MATCHED THEN INSERT 
  (
    Instance
  , Object_type
  , [ID]
  , [name]
  , date_created
  , date_modified
  , sid
  , Date_Added
  , New_Object_Flag
  ) 
  VALUES 
  (
    W.Instance
  , W.Object_type
  , W.[ID]
  , W.[name]
  , W.date_created
  , W.date_modified
  , W.sid
  , CURRENT_TIMESTAMP
  , 'Y'
  )

  -- Update existing records

  WHEN MATCHED THEN UPDATE 
  SET date_modified = W.date_modified
    , Date_Updated = CURRENT_TIMESTAMP

  -- Set Date_Deleted for missing records - object was deleted

  WHEN NOT MATCHED BY SOURCE THEN UPDATE
  SET Date_Deleted = CASE WHEN Date_Deleted IS NULL THEN CURRENT_TIMESTAMP ELSE Date_Deleted END;

--SELECT *
--FROM DBA.dbo.Inventory

  -- IF any records have have the New_Object_Flag set to "Y", create and Email a report and reset the flag to "N"

  IF EXISTS (SELECT * FROM DBA.dbo.Inventory WHERE New_Object_Flag = 'Y')
  BEGIN
    DECLARE @subject_value as VARCHAR(80) = 'New SQL Objects Found on ' + @@SERVERNAME

    DECLARE @query_value VARCHAR(1000) =
    N'SELECT 
  ''Instance: '' + CAST(Instance  AS CHAR(25)) +
  ''  Object Type: '' + CAST(Object_type AS CHAR(20)) +
  ''  Object Name: '' + CAST([name] AS CHAR(52)) +
  ''  Date Created: ''+ CONVERT(CHAR(16),date_created,120) +
  '' .....   Date Added to Inventory: '' + CONVERT(CHAR(16),Date_Added,120)
FROM DBA.dbo.Inventory
WHERE New_Object_Flag = ''Y''';

    EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Alerts',
    @recipients = 'spaylor@VIEJAS.com',
    @subject = @subject_value,
	@query_result_header = 0,
    @query = @query_value,
    @attach_query_result_as_file = 0;

    UPDATE DBA.dbo.Inventory 
    SET New_Object_Flag = 'N'
    WHERE New_Object_Flag = 'Y';
  END

END
GO
