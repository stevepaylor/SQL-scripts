SELECT TOP (1000) [id]
      ,[tenant_id]
      ,[property_id]
      ,[owner_id]
      ,[name]
      ,[iso_code]
      ,[Local_ETL_Inserted_TS]
      ,[Local_ETL_Updated_TS]
  FROM [StayDWH].[dbo].[countries]

--pg_dump -U viejas_paylors -h stay-datawarehouse.onagilysys.com -p 5432 stay_prod > stay_prod_backup.sql


--stay-datawarehouse.onagilysys.com:stay_prod:viejas_paylors:6N7f6$d5JYsX!TJx