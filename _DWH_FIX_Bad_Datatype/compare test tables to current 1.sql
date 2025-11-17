USE [iQ-Gaming]
GO

SELECT
  'IQC_Player_Ratings_TEST' as TableName
, COUNT(*)
, MIN(GamingDate) AS Min_GamingDate
, MAX(GamingDate) AS Max_GamingDate

FROM Steve.IQC_Player_Ratings_TEST (nolock)

union  -------------------------------------------------------------------

SELECT
  'IQC_Player_Ratings' as TableName
, COUNT(*)
, MIN(GamingDate) AS Min_GamingDate
, MAX(GamingDate) AS Max_GamingDate

FROM dbo.IQC_Player_Ratings  (nolock)

WHERE GamingDate >= '2018-01-01'

--WHERE ModifiedDate >= '2018-01-01'
--   OR GamingDate >= '2018-01-01'

union  -------------------------------------------------------------------

SELECT
  'IQC_Player_Daily_Totals_AcctDay_TEST' as TableName
, COUNT(*)
, MIN(CA.CalendarDate) AS Min_AccountingDate
, MAX(CA.CalendarDate) AS Max_AccountingDate

FROM Steve.IQC_Player_Daily_Totals_AcctDay_TEST TA  (nolock)

LEFT JOIN [dbo].[IQ_Calendar] CA  (nolock)
ON TA.AccountingDateID = CA.DateID

WHERE CA.CalendarDate >= '2018-01-01'

union  -------------------------------------------------------------------

SELECT
  'IQC_Player_Daily_Totals_AcctDay' as TableName
, COUNT(*)
, MIN(CA.CalendarDate) AS Min_AccountingDate
, MAX(CA.CalendarDate) AS Max_AccountingDate

FROM dbo.IQC_Player_Daily_Totals_AcctDay TA  (nolock)

LEFT JOIN [dbo].[IQ_Calendar] CA  (nolock)
ON TA.AccountingDateID = CA.DateID

WHERE CA.CalendarDate >= '2018-01-01'

union  -------------------------------------------------------------------

SELECT 
  'IQC_Player_Daily_Totals_GameDay_TEST' as TableName
, COUNT(*)
, MIN(CA.CalendarDate) AS Min_GamingDate
, MAX(CA.CalendarDate) AS Max_GamingDate

FROM Steve.IQC_Player_Daily_Totals_GameDay_TEST TG  (nolock)

LEFT JOIN [dbo].[IQ_Calendar] CA  (nolock)
ON TG.GamingDateID = CA.DateID

WHERE CA.CalendarDate >= '2018-01-01'

union  -------------------------------------------------------------------

SELECT 
  'IQC_Player_Daily_Totals_GameDay' as TableName
, COUNT(*)
, MIN(CA.CalendarDate) AS Min_GamingDate
, MAX(CA.CalendarDate) AS Max_GamingDate

FROM dbo.IQC_Player_Daily_Totals_GameDay TG  (nolock)

LEFT JOIN [dbo].[IQ_Calendar] CA (nolock)
ON TG.GamingDateID = CA.DateID 

WHERE CA.CalendarDate >= '2018-01-01'

ORDER BY TableName

--18100366
--8549561
--17875820
--3753
--68584817
--68592085