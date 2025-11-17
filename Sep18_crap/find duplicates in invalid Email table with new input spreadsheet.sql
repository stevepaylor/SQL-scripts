SELECT 
  existing.[Email] existing
, new.[Email] new
FROM [CMP13].[dbo].[ViejasInvalidEmails_2025_09_18] new
LEFT OUTER JOIN [CMP13].[dbo].[ViejasInvalidEmails] existing
ON existing.Email = new.Email

WHERE existing.[Email] IS NOT NULL