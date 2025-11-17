----SELECT 
----  DATEPART(YYYY,INSERT_DATE) AS 'Year Inserted'
----, COUNT(*) AS 'Nunber of Reservation Records'

----FROM [OperaDM].[dbo].[NAME_RESERVATION]

----GROUP BY
----  DATEPART(YYYY,INSERT_DATE)
------, UPDATE_DATE

----ORDER BY
----  DATEPART(YYYY,INSERT_DATE) ASC
----GO

SELECT 
  DATEPART(YYYY,UPDATE_DATE) AS 'Year Inserted'
, COUNT(*) AS 'Nunber of Reservation Records'

FROM [OperaDM].[dbo].[NAME_RESERVATION]

GROUP BY
  DATEPART(YYYY,UPDATE_DATE)
--, UPDATE_DATE

ORDER BY
  DATEPART(YYYY,UPDATE_DATE) ASC
GO

SELECT 
  COUNT(*) AS "Total Nunber of Reservation Records"

FROM [OperaDM].[dbo].[NAME_RESERVATION]
GO
