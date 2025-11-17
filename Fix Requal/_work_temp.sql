--select 
--MONTH(GETDATE())
--,DATEADD(MONTH,- (MONTH(GETDATE())),GETDATE())

select 
 CASE Requal_Month
	WHEN 6 
		THEN DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_End_Month)+1,dbo.DateOn1st(GETDATE()))
		ELSE DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_End_Month) + Requal_Month +1,dbo.DateOn1st(GETDATE()))
 END AS Next_Requal_Date

, Qualification_Period_Start_Month 
, Qualification_Period_End_Month
, Requal_Month
, MONTH(GETDATE()) AS Current_Month
, DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_End_Month)+1,dbo.DateOn1st(GETDATE()))
, DATEADD(MONTH,- (10 - (12 +1)),dbo.DateOn1st(GETDATE()))
, DATEADD(MONTH,- -3,dbo.DateOn1st(GETDATE()))
, DATEADD(MONTH,- (4)+1,dbo.DateOn1st(GETDATE()))
, DATEADD(MONTH,- (MONTH(GETDATE()) - Qualification_Period_End_Month) + Requal_Month +1,dbo.DateOn1st(GETDATE()))
, DATEADD(MONTH,- -2,dbo.DateOn1st(GETDATE()))
FROM R_Requal_Dates

--