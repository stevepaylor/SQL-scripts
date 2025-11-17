
SELECT *
FROM [CMP13].[dbo].[tAuditLogin]
where AuditLoginId = '14538864'
GO

SELECT MAX([AuditLoginId])
FROM [CMP13].[dbo].[tAuditLogin]
GO
