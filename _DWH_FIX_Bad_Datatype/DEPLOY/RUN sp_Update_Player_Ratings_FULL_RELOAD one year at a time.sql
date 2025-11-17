USE [iQ-Gaming]
GO

TRUNCATE TABLE dbo.IQC_Player_Daily_Totals_AcctDay
GO

TRUNCATE TABLE dbo.IQC_Player_Daily_Totals_AcctDay_EXT
GO

TRUNCATE TABLE dbo.IQC_Player_Daily_Totals_GameDay
GO

TRUNCATE TABLE dbo.IQC_Player_Daily_Totals_GameDay_EXT
GO

EXEC dbo.sp_Update_Player_Ratings_FULL_RELOAD '2018-01-01' 
GO

EXEC dbo.sp_Update_Player_Ratings_FULL_RELOAD '2019-01-01' 
GO

EXEC dbo.sp_Update_Player_Ratings_FULL_RELOAD '2020-01-01' 
GO

EXEC dbo.sp_Update_Player_Ratings_FULL_RELOAD '2021-01-01' 
GO

EXEC dbo.sp_Update_Player_Ratings_FULL_RELOAD '2022-01-01' 
GO

EXEC dbo.sp_Update_Player_Ratings_FULL_RELOAD '2023-01-01' 
GO

