USE [iQ-Gaming] 
GO

DROP TABLE IF EXISTS Steve._temp_IQC_Player_Trips_AcctDay_TEST
GO

SELECT *
INTO Steve._temp_IQC_Player_Trips_AcctDay_TEST
FROM dbo.IQC_Player_Trips_AcctDay
GO

-----------------------------------------------------------------------

DROP TABLE IF EXISTS Steve._temp_IQC_Player_Trips_GameDay_TEST
GO

SELECT *
INTO Steve._temp_IQC_Player_Trips_GameDay_TEST
FROM dbo.IQC_Player_Trips_GameDay
GO
