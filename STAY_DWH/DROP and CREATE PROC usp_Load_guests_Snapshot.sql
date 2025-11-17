USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE usp_Load_guests_Snapshot
AS 

TRUNCATE TABLE dbo.guests ;

INSERT INTO dbo.guests
SELECT DISTINCT
  *
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT 
  CAST(id as varchar(200)) as id --text
, CAST(tenant_id as varchar(200)) as tenant_id --text
, CAST(anonymized as int) as anonymized --boolean
, CAST(anonymized_message as varchar(200)) as anonymized_message --text
, create_time --timestamp without time zone
, update_time --timestamp without time zone
, CAST(archived as int) as archived --boolean
, CAST(external_profile_id as varchar(200)) as external_profile_id --text
, CAST(first_name as varchar(200)) as first_name --text
, CAST(last_name as varchar(200)) as last_name --text
, anniversary --date
, birth_date --date
, CAST(middle_initial as varchar(200)) as middle_initial --text
, CAST(suffix as varchar(200)) as suffix --text
, CAST(title as varchar(200)) as title --text
, CAST(company_title as varchar(200)) as company_title --text
, CAST(pronunciation as varchar(200)) as pronunciation --text
, CAST(gender as varchar(200)) as gender --text
, CAST(language as varchar(200)) as language --text
, CAST(alias as varchar(200)) as alias --text
, CAST(company_name as varchar(200)) as company_name --text
, CAST(type as varchar(200)) as type --text
, CAST(player_id as varchar(200)) as player_id --text
, CAST(code as varchar(200)) as code --text
, CAST(cms_type as varchar(200)) as cms_type --text
, CAST(card_id_available as int) as card_id_available --boolean
, CAST(gps_id as varchar(200)) as gps_id --text
, CAST(opt_in_for_marketing as int) as opt_in_for_marketing --boolean
, CAST(merge_remnant as int) as merge_remnant --boolean

FROM public.guests
'
)

ORDER BY
  [id]
, [tenant_id]
, [create_time]
, [update_time] ;

GO