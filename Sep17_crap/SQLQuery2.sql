--INSERT INTO [CMP13].[dbo].[ViejasInvalidEmails_2025_09_18]
--SELECT DISTINCT [EmailAddress]
--FROM [CMP13].[dbo].[ViejasInvalidEmails_2025_09_18x]

INSERT INTO [CMP13].[dbo].[ViejasInvalidEmails]
SELECT DISTINCT new.[Email]
FROM [CMP13].[dbo].[ViejasInvalidEmails_2025_09_18] new
LEFT OUTER JOIN [CMP13].[dbo].[ViejasInvalidEmails] existing
ON new.[Email] = existing.[Email]
WHERE existing.[Email] IS NULL

--(100252 rows affected)