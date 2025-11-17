USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_reservation_loyalties_Snapshot]
AS

TRUNCATE TABLE dbo.reservation_loyalties ;

INSERT INTO dbo.reservation_loyalties
SELECT 
  [id] --PK

, [tenant_id]  
, [property_id]
, [reservation_id]
, [default]
, [program_name]
, [member_number]
, [loyalty_id]
, [loyalty_program_name]
, [tier]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  id --uuid

, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text
, CAST(reservation_id as varchar(200)) as reservation_id --text
, CAST("default" as int) as "default" --boolean
, CAST(program_name as varchar(200)) as program_name --text
, CAST(member_number as varchar(200)) as member_number --text
, CAST(loyalty_id as varchar(200)) as loyalty_id --text
, CAST(loyalty_program_name as varchar(200)) as loyalty_program_name --text
, CAST(tier as varchar(200)) as tier --text

FROM public.reservation_loyalties
'
) ;