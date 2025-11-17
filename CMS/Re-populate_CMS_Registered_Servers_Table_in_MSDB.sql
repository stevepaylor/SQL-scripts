USE CMS
GO

--TRUNCATE TABLE CMS_REG_SERVERS_TEST;
TRUNCATE TABLE msdb..sysmanagement_shared_registered_servers_internal;
GO

/***************************************************************************************************
Build a table variable to store a numbered list of the unique DBUsers 
***************************************************************************************************/
DECLARE @TV_Instances TABLE
(
  TV_Instance VARCHAR(255)
, TV_HostName VARCHAR(255) 
, TV_ProductName VARCHAR(255)
, TV_Edition VARCHAR(255) 
, TV_SP_Level CHAR(3)
, TV_Version_Build VARCHAR(255)
, TV_Environment VARCHAR(255)
, TV_HostOS VARCHAR(255)
);

/***************************************************************************************************
Populate the TABLE variable for BY Instance - No Grouping (75) Limited to accessible Instances
***************************************************************************************************/
DELETE FROM @TV_Instances;

INSERT INTO @TV_Instances 
SELECT DISTINCT
  DI.[Instance]
, DH.HostName 
, DI.ProductName
, DI.Edition
, DI.SP_Level
, DI.Version_Build
, DI.Environment
, RTRIM(LTRIM(DH.OS)) AS HostOS
FROM DASI..Instances DI
JOIN DASI..HostInstanceJoin DHJ
ON DI.Instance = DHJ.Instance
JOIN DASI..Hosts DH
ON DHJ.HostName = DH.HostName
WHERE DI.Accessible = 'Y'
  AND DI.Active = 'Y'
ORDER BY DI.[Instance];

--SELECT * FROM @TV_Instances;

MERGE msdb..sysmanagement_shared_registered_servers_internal AS S
USING @TV_Instances AS I 
ON S.[name] = I.TV_Instance
AND SUBSTRING(S.[description],6,LEN(I.TV_Environment))  = I.TV_Environment

WHEN MATCHED THEN UPDATE 
  SET
  S.[name] = I.TV_Instance
, S.server_name = I.TV_Instance
, S.[description] = 
	RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, S.server_group_id = 75
, S.server_type = 0

WHEN NOT MATCHED THEN INSERT 
  (
  [name]
, server_name 
, [description]
, server_group_id
, server_type
  ) 
  VALUES 
  (
  I.TV_Instance
, I.TV_Instance
, RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, 75
, 0
  );


/***************************************************************************************************
Populate the TABLE variable for BY Instance - Not Accessible - No Grouping (76) Limited to accessible Instances
***************************************************************************************************/
DELETE FROM @TV_Instances;

INSERT INTO @TV_Instances 
SELECT DISTINCT
  DI.[Instance]
, DH.HostName 
, DI.ProductName
, DI.Edition
, DI.SP_Level
, DI.Version_Build
, DI.Environment
, RTRIM(LTRIM(DH.OS)) AS HostOS
FROM DASI..Instances DI
JOIN DASI..HostInstanceJoin DHJ
ON DI.Instance = DHJ.Instance
JOIN DASI..Hosts DH
ON DHJ.HostName = DH.HostName
WHERE DI.Accessible = 'N'
  AND DI.Active = 'Y'
ORDER BY DI.[Instance];

--SELECT * FROM @TV_Instances;

MERGE msdb..sysmanagement_shared_registered_servers_internal AS S
USING @TV_Instances AS I 
ON S.[name] = I.TV_Instance
AND SUBSTRING(S.[description],6,LEN(I.TV_Environment))  = I.TV_Environment

WHEN MATCHED THEN UPDATE 
  SET
  S.[name] = I.TV_Instance
, S.server_name = I.TV_Instance
, S.[description] = 
	RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, S.server_group_id = 76
, S.server_type = 0

WHEN NOT MATCHED THEN INSERT 
  (
  [name]
, server_name 
, [description]
, server_group_id
, server_type
  ) 
  VALUES 
  (
  I.TV_Instance
, I.TV_Instance
, RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, 76
, 0
  );

/***************************************************************************************************
Populate the TABLE variable for By Version (60) Limited to accessible Instances
***************************************************************************************************/
DELETE FROM @TV_Instances;

INSERT INTO @TV_Instances 
SELECT DISTINCT
  DI.[Instance]
, DH.HostName 
, DI.ProductName
, DI.Edition
, DI.SP_Level
, DI.Version_Build
, DI.Environment
, RTRIM(LTRIM(DH.OS)) AS HostOS
FROM DASI..Instances DI
JOIN DASI..HostInstanceJoin DHJ
ON DI.Instance = DHJ.Instance
JOIN DASI..Hosts DH
ON DHJ.HostName = DH.HostName
WHERE DI.Accessible = 'Y'
  AND DI.Active = 'Y'
ORDER BY DI.[Instance];

--SELECT * FROM @TV_Instances;
 
MERGE msdb..sysmanagement_shared_registered_servers_internal AS S
USING @TV_Instances AS I 
ON S.[name] = I.TV_Instance
AND S.server_name = I.TV_Environment

WHEN MATCHED THEN UPDATE 
  SET
  S.[name] = I.TV_Instance
, S.server_name = I.TV_Instance
, S.[description] = 
	RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, S.server_group_id =
	CASE 
	  WHEN I.TV_Version_Build LIKE '8%' THEN 62 -- 2000
	  WHEN I.TV_Version_Build LIKE '9%' THEN 63 -- 2005
	  WHEN I.TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(I.TV_SP_Level,4,1) AS INT) < 5 THEN 64 -- 2008
	  WHEN I.TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(I.TV_SP_Level,4,1) AS INT) > 4 THEN 65 -- 2008R2
	  WHEN I.TV_Version_Build LIKE '11%' THEN 66 -- 2012
	  WHEN I.TV_Version_Build LIKE '12%' THEN 67 -- 2014
	  WHEN I.TV_Version_Build LIKE '13%' THEN 68 -- 2016
	  ELSE 69
	END
, S.server_type = 0

WHEN NOT MATCHED THEN INSERT 
  (
  [name]
, server_name 
, [description]
, server_group_id
, server_type
  ) 
  VALUES 
  (
  I.TV_Instance
, I.TV_Instance
, RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, CASE 
	WHEN I.TV_Version_Build LIKE '8%' THEN 62 -- 2000
	WHEN I.TV_Version_Build LIKE '9%' THEN 63 -- 2005
	WHEN I.TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(I.TV_SP_Level,4,1) AS INT) < 5 THEN 64 -- 2008
	WHEN I.TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(I.TV_SP_Level,4,1) AS INT) > 4 THEN 65 -- 2008R2
	WHEN I.TV_Version_Build LIKE '11%' THEN 66 -- 2012
	WHEN I.TV_Version_Build LIKE '12%' THEN 67 -- 2014
	WHEN I.TV_Version_Build LIKE '13%' THEN 68 -- 2016
	ELSE 69
  END
, 0
  );


/***************************************************************************************************
Populate the TABLE variable for By Environment (59), Prod (6) Limited to accessible Instances
***************************************************************************************************/
DELETE FROM @TV_Instances;

INSERT INTO @TV_Instances 
SELECT DISTINCT
  DI.[Instance]
, DH.HostName 
, DI.ProductName
, DI.Edition
, DI.SP_Level
, DI.Version_Build
, DI.Environment
, RTRIM(LTRIM(DH.OS)) AS HostOS
FROM DASI..Instances DI
JOIN DASI..HostInstanceJoin DHJ
ON DI.Instance = DHJ.Instance
JOIN DASI..Hosts DH
ON DHJ.HostName = DH.HostName
WHERE Environment = 'PR'
  AND DI.Accessible = 'Y'
  AND DI.Active = 'Y'
ORDER BY DI.[Instance];

--SELECT * FROM @TV_Instances;
 
MERGE msdb..sysmanagement_shared_registered_servers_internal AS S
USING @TV_Instances AS I 
ON S.[name] = I.TV_Instance
AND S.server_name = I.TV_Environment

WHEN MATCHED THEN UPDATE 
  SET
  S.[name] = I.TV_Instance
, S.server_name = I.TV_Instance
, S.[description] = 
	RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, S.server_group_id =
	CASE 
	  WHEN I.TV_Version_Build LIKE '8%' THEN 14 -- 2000
	  WHEN I.TV_Version_Build LIKE '9%' THEN 10 -- 2005
	  WHEN I.TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(I.TV_SP_Level,4,1) AS INT) < 5 THEN 12 -- 2008
	  WHEN I.TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(I.TV_SP_Level,4,1) AS INT) > 4 THEN 13 -- 2008R2
	  WHEN I.TV_Version_Build LIKE '11%' THEN 11 -- 2012
	  WHEN I.TV_Version_Build LIKE '12%' THEN 15 -- 2014
	  WHEN I.TV_Version_Build LIKE '13%' THEN 16 -- 2016
	  ELSE 17
	END
, S.server_type = 0

WHEN NOT MATCHED THEN INSERT 
  (
  [name]
, server_name 
, [description]
, server_group_id
, server_type
  ) 
  VALUES 
  (
  I.TV_Instance
, I.TV_Instance
, RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, CASE 
	WHEN I.TV_Version_Build LIKE '8%' THEN 14 -- 2000
	WHEN I.TV_Version_Build LIKE '9%' THEN 10 -- 2005
	WHEN I.TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(I.TV_SP_Level,4,1) AS INT) < 5 THEN 12 -- 2008
	WHEN I.TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(I.TV_SP_Level,4,1) AS INT) > 4 THEN 13 -- 2008R2
	WHEN I.TV_Version_Build LIKE '11%' THEN 11 -- 2012
	WHEN I.TV_Version_Build LIKE '12%' THEN 15 -- 2014
	WHEN I.TV_Version_Build LIKE '13%' THEN 16 -- 2016
	ELSE 17
  END
, 0
  );

/***************************************************************************************************
Populate the TABLE variable for By Environment (59), QA (7) Limited to accessible Instances
***************************************************************************************************/
DELETE FROM @TV_Instances;

INSERT INTO @TV_Instances 
SELECT DISTINCT
  DI.[Instance]
, DH.HostName 
, DI.ProductName
, DI.Edition
, DI.SP_Level
, DI.Version_Build
, DI.Environment
, RTRIM(LTRIM(DH.OS)) AS HostOS
FROM DASI..Instances DI
JOIN DASI..HostInstanceJoin DHJ
ON DI.Instance = DHJ.Instance
JOIN DASI..Hosts DH
ON DHJ.HostName = DH.HostName
WHERE Environment = 'QA'
  AND DI.Accessible = 'Y'
  AND DI.Active = 'Y'
ORDER BY DI.[Instance];

--SELECT * FROM @TV_Instances;
 
MERGE msdb..sysmanagement_shared_registered_servers_internal AS S
USING @TV_Instances AS I 
ON S.[name] = I.TV_Instance
AND S.server_name = I.TV_Environment

WHEN MATCHED THEN UPDATE 
  SET
  S.[name] = I.TV_Instance
, S.server_name = I.TV_Instance
, S.[description] = 
	RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, S.server_group_id =
	CASE 
	  WHEN TV_Version_Build LIKE '8%' THEN 18 -- 2000
	  WHEN TV_Version_Build LIKE '9%' THEN 19 -- 2005
	  WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) < 5 THEN 20 -- 2008
	  WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) > 4 THEN 21 -- 2008R2
	  WHEN TV_Version_Build LIKE '11%' THEN 22 -- 2012
	  WHEN TV_Version_Build LIKE '12%' THEN 23 -- 2014
	  WHEN TV_Version_Build LIKE '13%' THEN 24 -- 2016
	  ELSE 39
	END
, S.server_type = 0

WHEN NOT MATCHED THEN INSERT 
  (
  [name]
, server_name 
, [description]
, server_group_id
, server_type
  ) 
  VALUES 
  (
  I.TV_Instance
, I.TV_Instance
, RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, CASE 
	WHEN TV_Version_Build LIKE '8%' THEN 18 -- 2000
	WHEN TV_Version_Build LIKE '9%' THEN 19 -- 2005
	WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) < 5 THEN 20 -- 2008
	WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) > 4 THEN 21 -- 2008R2
	WHEN TV_Version_Build LIKE '11%' THEN 22 -- 2012
	WHEN TV_Version_Build LIKE '12%' THEN 23 -- 2014
	WHEN TV_Version_Build LIKE '13%' THEN 24 -- 2016
	ELSE 39
  END
, 0
  );

/***************************************************************************************************
Populate the TABLE variable for By Environment (59), UT (8)  Limited to accessible Instances
***************************************************************************************************/
DELETE FROM @TV_Instances;

INSERT INTO @TV_Instances 
SELECT DISTINCT
  DI.[Instance]
, DH.HostName 
, DI.ProductName
, DI.Edition
, DI.SP_Level
, DI.Version_Build
, DI.Environment
, RTRIM(LTRIM(DH.OS)) AS HostOS
FROM DASI..Instances DI
JOIN DASI..HostInstanceJoin DHJ
ON DI.Instance = DHJ.Instance
JOIN DASI..Hosts DH
ON DHJ.HostName = DH.HostName
WHERE Environment = 'UT'
  AND DI.Accessible = 'Y'
  AND DI.Active = 'Y'
ORDER BY DI.[Instance];

--SELECT * FROM @TV_Instances;
 
MERGE msdb..sysmanagement_shared_registered_servers_internal AS S
USING @TV_Instances AS I 
ON S.[name] = I.TV_Instance
AND S.server_name = I.TV_Environment

WHEN MATCHED THEN UPDATE 
  SET
  S.[name] = I.TV_Instance
, S.server_name = I.TV_Instance
, S.[description] = 
	RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, S.server_group_id =
	CASE 
	  WHEN TV_Version_Build LIKE '8%' THEN 25 -- 2000
	  WHEN TV_Version_Build LIKE '9%' THEN 26 -- 2005
	  WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) < 5 THEN 27 -- 2008
	  WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) > 4 THEN 28 -- 2008R2
	  WHEN TV_Version_Build LIKE '11%' THEN 74 -- 2012
	  WHEN TV_Version_Build LIKE '12%' THEN 9 -- 2014
	  WHEN TV_Version_Build LIKE '13%' THEN 29 -- 2016
	  ELSE 40
	END
, S.server_type = 0

WHEN NOT MATCHED THEN INSERT 
  (
  [name]
, server_name 
, [description]
, server_group_id
, server_type
  ) 
  VALUES 
  (
  I.TV_Instance
, I.TV_Instance
, RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, CASE 
	WHEN TV_Version_Build LIKE '8%' THEN 25 -- 2000
	WHEN TV_Version_Build LIKE '9%' THEN 26 -- 2005
	WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) < 5 THEN 27 -- 2008
	WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) > 4 THEN 28 -- 2008R2
	WHEN TV_Version_Build LIKE '11%' THEN 74 -- 2012
	WHEN TV_Version_Build LIKE '12%' THEN 9 -- 2014
	WHEN TV_Version_Build LIKE '13%' THEN 29 -- 2016
	ELSE 40
  END
, 0
  );

/***************************************************************************************************
Populate the TABLE variable for By Environment (59), DV (41) Limited to accessible Instances
***************************************************************************************************/
DELETE FROM @TV_Instances;

INSERT INTO @TV_Instances 
SELECT DISTINCT
  DI.[Instance]
, DH.HostName 
, DI.ProductName
, DI.Edition
, DI.SP_Level
, DI.Version_Build
, DI.Environment
, RTRIM(LTRIM(DH.OS)) AS HostOS
FROM DASI..Instances DI
JOIN DASI..HostInstanceJoin DHJ
ON DI.Instance = DHJ.Instance
JOIN DASI..Hosts DH
ON DHJ.HostName = DH.HostName
WHERE Environment = 'DV'
  AND DI.Accessible = 'Y'
  AND DI.Active = 'Y'
ORDER BY DI.[Instance];

--SELECT * FROM @TV_Instances;
 
MERGE msdb..sysmanagement_shared_registered_servers_internal AS S
USING @TV_Instances AS I 
ON S.[name] = I.TV_Instance
AND S.server_name = I.TV_Environment

WHEN MATCHED THEN UPDATE 
  SET
  S.[name] = I.TV_Instance
, S.server_name = I.TV_Instance
, S.[description] = 
	RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, S.server_group_id =
	CASE 
	  WHEN TV_Version_Build LIKE '8%' THEN 42 -- 2000
	  WHEN TV_Version_Build LIKE '9%' THEN 43 -- 2005
	  WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) < 5 THEN 44 -- 2008
	  WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) > 4 THEN 45 -- 2008R2
	  WHEN TV_Version_Build LIKE '11%' THEN 46 -- 2012
	  WHEN TV_Version_Build LIKE '12%' THEN 47 -- 2014
	  WHEN TV_Version_Build LIKE '13%' THEN 48 -- 2016
	  ELSE 49
	END
, S.server_type = 0

WHEN NOT MATCHED THEN INSERT 
  (
  [name]
, server_name 
, [description]
, server_group_id
, server_type
  ) 
  VALUES
  ( 
  I.TV_Instance
, I.TV_Instance
, RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS  
, CASE 
	WHEN TV_Version_Build LIKE '8%' THEN 42 -- 2000
	WHEN TV_Version_Build LIKE '9%' THEN 43 -- 2005
	WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) < 5 THEN 44 -- 2008
	WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) > 4 THEN 45 -- 2008R2
	WHEN TV_Version_Build LIKE '11%' THEN 46 -- 2012
	WHEN TV_Version_Build LIKE '12%' THEN 47 -- 2014
	WHEN TV_Version_Build LIKE '13%' THEN 48 -- 2016
	ELSE 49
  END
, 0
  );


/***************************************************************************************************
Populate the TABLE variable for By Environment (59), Unknown OR NULL Environment (50) Limited to accessible Instances
***************************************************************************************************/
DELETE FROM @TV_Instances;

INSERT INTO @TV_Instances 
SELECT DISTINCT
  DI.[Instance]
, DH.HostName 
, DI.ProductName
, DI.Edition
, DI.SP_Level
, DI.Version_Build
, DI.Environment
, RTRIM(LTRIM(DH.OS)) AS HostOS
FROM DASI..Instances DI
JOIN DASI..HostInstanceJoin DHJ
ON DI.Instance = DHJ.Instance
JOIN DASI..Hosts DH
ON DHJ.HostName = DH.HostName
WHERE Environment = 'UNKNOWN'
  AND DI.Accessible = 'Y'
  AND DI.Active = 'Y'
ORDER BY DI.[Instance];

--SELECT * FROM @TV_Instances;
 
MERGE msdb..sysmanagement_shared_registered_servers_internal AS S
USING @TV_Instances AS I 
ON S.[name] = I.TV_Instance
AND S.server_name = I.TV_Environment

WHEN MATCHED THEN UPDATE 
  SET
  S.[name] = I.TV_Instance
, S.server_name = I.TV_Instance
, S.[description] = 
	RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, S.server_group_id =
	CASE 
	  WHEN TV_Version_Build LIKE '8%' THEN 51 -- 2000
	  WHEN TV_Version_Build LIKE '9%' THEN 52 -- 2005
	  WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) < 5 THEN 53 -- 2008
	  WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) > 4 THEN 54 -- 2008R2
	  WHEN TV_Version_Build LIKE '11%' THEN 55 -- 2012
	  WHEN TV_Version_Build LIKE '12%' THEN 56 -- 2014
	  WHEN TV_Version_Build LIKE '13%' THEN 57 -- 2016
	  ELSE 58
	END
, S.server_type = 0

WHEN NOT MATCHED THEN INSERT 
  (
  [name]
, server_name 
, [description]
, server_group_id
, server_type
  ) 
  VALUES 
  (
  I.TV_Instance
, I.TV_Instance
, RTRIM(UPPER(TV_Environment)) + '  -  '
  + 'SQL: ' + RTRIM(SUBSTRING(TV_ProductName,CHARINDEX(' 20',TV_ProductName),7)) + '-' + LTRIM(TV_SP_Level) + ' ( ' + RTRIM(TV_Version_Build) + ') ' + RTRIM(TV_Edition) 
  + ' -  HOST: ' + RTRIM(UPPER(TV_HostName)) + ' - ' + TV_HostOS 
, CASE 
	WHEN TV_Version_Build LIKE '8%' THEN 51 -- 2000
	WHEN TV_Version_Build LIKE '9%' THEN 52 -- 2005
	WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) < 5 THEN 53 -- 2008
	WHEN TV_Version_Build LIKE '10%' AND CAST(SUBSTRING(TV_SP_Level,4,1) AS INT) > 4 THEN 54 -- 2008R2
	WHEN TV_Version_Build LIKE '11%' THEN 55 -- 2012
	WHEN TV_Version_Build LIKE '12%' THEN 56 -- 2014
	WHEN TV_Version_Build LIKE '13%' THEN 57 -- 2016
	ELSE 58
  END
, 0
  );

--SELECT * FROM msdb..sysmanagement_shared_registered_servers_internal;
--GO