DROP TABLE IF EXISTS STAYDWH.dbo.ledger_transactions_staging
GO 

SELECT *
, CURRENT_TIMESTAMP as [Local_ETL_Inserted_TS]
, CURRENT_TIMESTAMP as [Local_ETL_Updated_TS]

INTO dbo.ledger_transactions_staging 

FROM OPENQUERY(Stay_PostgreSQL,
'SELECT * FROM public.ledger_transactions ORDER BY update_time DESC LIMIT 1000 '
) ;
GO

SELECT TOP 1000 *
FROM STAYDWH.dbo.ledger_transactions_staging
GO
