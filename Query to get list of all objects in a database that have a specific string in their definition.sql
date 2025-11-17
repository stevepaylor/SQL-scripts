SELECT OBJECT_NAME(object_id)
    FROM sys.sql_modules
    --WHERE OBJECTPROPERTY(object_id, 'IsView') = 1
WHERE definition LIKE '%iQ-Gaming-repl%'

ORDER BY OBJECT_NAME(object_id)


SELECT TOP 1000 * FROM dbo.vw_IQC_Offers_live
SELECT TOP 1000 * FROM dbo.vw_IQC_Player_Balances
SELECT TOP 1000 * FROM dbo.vw_IQC_Player_Balances_PN
SELECT TOP 1000 * FROM dbo.vw_IQC_Player_Balances_new
SELECT TOP 1000 * FROM dbo.vw_IQC_Player_Balances_20221018
SELECT TOP 1000 * FROM dbo.vw_IQC_Player_Balances_20220728
SELECT TOP 1000 * FROM dbo.vw_iQC_tPlayer_ClubState