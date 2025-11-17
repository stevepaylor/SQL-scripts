SELECT
   DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) AS StartOfYear,
   DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, -1) AS EndOfYear

SELECT
   DATEADD(yy, DATEDIFF(yy, 0, GETDATE())-5, 0) AS [StartOfYear-5]