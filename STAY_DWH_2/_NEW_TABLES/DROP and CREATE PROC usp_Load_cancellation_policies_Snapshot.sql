USE StayDWH
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_booked_reservation_details_Snapshot]
AS

TRUNCATE TABLE dbo.booked_reservation_details ;

INSERT INTO dbo.booked_reservation_details
SELECT 
  [id] --PK

, [tenant_id]  
, [property_id]
, [date]
, [room_type_id]
, [rate_plan_id]
, [reservation_id]
, [offer_applied]
, [admin_offer]
, [rate]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT
  id --uuid

, CAST(tenant_id as varchar(10)) as tenant_id --text
, CAST(property_id as varchar(10)) as property_id --text
, date --date
, CAST(room_type_id as varchar(200)) as room_type_id --text
, CAST(rate_plan_id as varchar(200)) as rate_plan_id --text
, CAST(reservation_id as varchar(200)) as reservation_id --text
, CAST(offer_applied as int) as offer_applied --boolean
, CAST(admin_offer as int) as admin_offer --boolean
, rate --numeric(19,2)

FROM public.booked_reservation_details
'
) ;