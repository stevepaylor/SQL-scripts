SELECT 'FINANCIAL_TRANSACTIONS' as [Table],'PROD' as System, COUNT(*) as ROWS
FROM [iQ-Gaming].[Opera_5_0].[FINANCIAL_TRANSACTIONS]

UNION 

SELECT 'FINANCIAL_TRANSACTIONS' as [Table],'QA' as System, COUNT(*) as ROWS
FROM DWHDB01QA.[iQ-Gaming].[Opera_5_0].[FINANCIAL_TRANSACTIONS]

UNION 

SELECT 'FINANCIAL_TRANSACTIONS' as [Table],'OLD-DWH' as System, COUNT(*) as ROWS
FROM MSBIDB01DV.OperaDM.dbo.[FINANCIAL_TRANSACTIONS]

--------------------------------------------------------------------------------------

UNION

SELECT 'NAME_RESERVATION' as [Table], 'PROD' as System, COUNT(*) as ROWS
FROM [iQ-Gaming].[Opera_5_0].[NAME_RESERVATION]

UNION

SELECT 'NAME_RESERVATION' as [Table], 'QA' as System, COUNT(*) as ROWS
FROM DWHDB01QA.[iQ-Gaming].[Opera_5_0].[NAME_RESERVATION]

UNION 

SELECT 'NAME_RESERVATION' as [Table],'OLD-DWH' as System, COUNT(*) as ROWS
FROM MSBIDB01DV.OperaDM.dbo.[NAME_RESERVATION]

--------------------------------------------------------------------------------------

UNION

SELECT 'OBI_RESERVATION_STAT_DAILY' as [Table], 'PROD' as System, COUNT(*) as ROWS
FROM [iQ-Gaming].[Opera_5_0].[OBI_RESERVATION_STAT_DAILY]

UNION

SELECT 'OBI_RESERVATION_STAT_DAILY' as [Table], 'QA' as System, COUNT(*) as ROWS
FROM DWHDB01QA.[iQ-Gaming].[Opera_5_0].[OBI_RESERVATION_STAT_DAILY]

UNION 

SELECT 'OBI_RESERVATION_STAT_DAILY' as [Table],'OLD-DWH' as System, COUNT(*) as ROWS
FROM MSBIDB01DV.OperaDM.dbo.[OBI_RESERVATION_STAT_DAILY]

--------------------------------------------------------------------------------------

UNION

SELECT 'RESERVATIONS' as [Table], 'PROD' as System, COUNT(*) as ROWS
FROM [iQ-Gaming].[Opera_5_0].[RESERVATIONS]

UNION

SELECT 'RESERVATIONS' as [Table], 'QA' as System, COUNT(*) as ROWS
FROM DWHDB01QA.[iQ-Gaming].[Opera_5_0].[RESERVATIONS]

UNION

SELECT 'RESERVATIONS' as [Table],'OLD-DWH' as System, COUNT(*) as ROWS
FROM MSBIDB01DV.OperaDM.dbo.[RESERVATIONS]

--------------------------------------------------------------------------------------

UNION

SELECT 'RESERVATIONS_NIGHTS' as [Table], 'PROD' as System, COUNT(*) as ROWS
FROM [iQ-Gaming].[Opera_5_0].[RESERVATIONS_NIGHTS]

UNION

SELECT 'RESERVATIONS_NIGHTS' as [Table], 'QA' as System, COUNT(*) as ROWS
FROM DWHDB01QA.[iQ-Gaming].[Opera_5_0].[RESERVATIONS_NIGHTS]

ORDER BY 
1, 2, 3