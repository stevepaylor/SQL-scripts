USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE usp_Load_properties_Snapshot
AS 

TRUNCATE TABLE dbo.properties ;

INSERT INTO dbo.properties
SELECT DISTINCT
  [id] --PK

, [check_in_time]
, [checkout_time]
, [create_time]
, [is_deleted]
, [tenant_id]
, [time_zone]
, [update_time]
, [production_property]
, [first_room_stay_at]
, [first_reservation_created_at]
, [first_room_charge_at]
, [recent_room_stay_at]
, [recent_room_charge_at]
, [recent_reservation_created_at]
, [tenant_name]
, [property_name]
, [tenant_code]
, [property_code]
, [language]
, [country]
, [currency_code]
, [long_date_format]
, [short_date_format]
, [time_format]
, [clock_type]
, [locale_code]
, [content_date_format]
, [content_time_format]
, [accounting_style_required]
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, check_in_time --time without time zone
, checkout_time --time without time zone
, create_time --timestamp without time zone
----     boolean,
, CAST(is_deleted as int) as is_deleted --boolean
, CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(time_zone as varchar(200)) as time_zone --text
, update_time --timestamp without time zone,
, CAST(production_property as int) as production_property --boolean
, first_room_stay_at --timestamp without time zone
, first_reservation_created_at --timestamp without time zone
, first_room_charge_at --timestamp without time zone
, recent_room_stay_at --timestamp without time zone
, recent_room_charge_at --timestamp without time zone
, recent_reservation_created_at --timestamp without time zone
, CAST(tenant_name as varchar(200)) as tenant_name --text
, CAST(property_name as varchar(200)) as property_name --text
, CAST(tenant_code as varchar(200)) as tenant_code --text
, CAST(property_code as varchar(200)) as property_code --text
, CAST(language as varchar(200)) as language --text
, CAST(country as varchar(200)) as country --text
, CAST(currency_code as varchar(200)) as currency_code --text
, CAST(long_date_format as varchar(200)) as long_date_format --text
, CAST(short_date_format as varchar(200)) as short_date_format --text
, CAST(time_format as varchar(200)) as time_format --text
, CAST(clock_type as varchar(200)) as clock_type --text
, CAST(locale_code  as int) as locale_code --boolean DEFAULT false
, CAST(content_date_format as varchar(200)) as content_date_format --text
, CAST(content_time_format as varchar(200)) as content_time_format --text
, CAST(accounting_style_required as int) as accounting_style_required --boolean

FROM public.properties
'
) ;
GO