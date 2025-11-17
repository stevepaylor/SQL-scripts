USE [iQ-Gaming]
GO

TRUNCATE TABLE SystemMaintDB.dbo.CMP_Tables_Current_Data_Check
GO

INSERT INTO SystemMaintDB.dbo.CMP_Tables_Current_Data_Check

SELECT  GETDATE() AS AsOf_Date ,'tAccum1DayBet' AS TableName , 'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key

--INTO SystemMaintDB.dbo.CMP_Tables_Current_Data_Check

FROM [iQ-Gaming].[CMP_13-1].tAccum1DayBet

UNION

SELECT  GETDATE() AS AsOf_Date ,'tAccum1DayComp' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tAccum1DayComp

UNION

SELECT  GETDATE() AS AsOf_Date ,'tAccum1DayPromo1' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tAccum1DayPromo1

UNION

SELECT  GETDATE() AS AsOf_Date ,'tAccum1DayPromo2' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tAccum1DayPromo2

UNION

SELECT  GETDATE() AS AsOf_Date ,'tAccum1DayPts' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tAccum1DayPts

UNION

SELECT  GETDATE() AS AsOf_Date ,'tAccum1DayStubs' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tAccum1DayStubs

UNION

SELECT  GETDATE() AS AsOf_Date ,'tAccumKey' AS TableName ,  'LastGamingDt' AS [Column_Checked] , CAST(MAX(LastGamingDt) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tAccumKey

UNION

SELECT  GETDATE() AS AsOf_Date ,'tArea' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tArea

UNION

SELECT  GETDATE() AS AsOf_Date ,'tAwards' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tAwards

UNION

SELECT  GETDATE() AS AsOf_Date ,'tBucketCasino' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tBucketCasino

UNION

SELECT  GETDATE() AS AsOf_Date ,'tBucketGroup' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tBucketGroup

UNION

SELECT  GETDATE() AS AsOf_Date ,'tCasino' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tCasino

UNION

SELECT  GETDATE() AS AsOf_Date ,'tClubLevels' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tClubLevels

UNION

SELECT  GETDATE() AS AsOf_Date ,'tCountry' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tCountry

UNION

SELECT  GETDATE() AS AsOf_Date ,'tDenom' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tDenom
UNION

SELECT  GETDATE() AS AsOf_Date ,'tDept' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tDept

UNION

SELECT  GETDATE() AS AsOf_Date ,'tEmp' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].[tEmp]

UNION

SELECT  GETDATE() AS AsOf_Date ,'tEmpCasinoRole' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tEmpCasinoRole

UNION

SELECT  GETDATE() AS AsOf_Date ,'tGame' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tGame

UNION

SELECT  GETDATE() AS AsOf_Date ,'tGroup' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tGroup

UNION

SELECT  GETDATE() AS AsOf_Date ,'tLocn' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tLocn

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayer' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayer

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerAddress' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerAddress

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerAttributeDtl' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerAttributeDtl

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerCard' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerCard

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerCasino' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerCasino

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerCasinoHost' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerCasinoHost

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerClubStateHistory' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerClubStateHistory

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerComps' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerComps

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerEmail' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerEmail

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerGroup' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerGroup

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerNote' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerNote

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerPhone' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerPhone

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerPointBal' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerPointBal

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerPoints' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerPoints

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerPromo1' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerPromo1

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerPromo1Bal' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerPromo1Bal

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerPromo2' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerPromo2

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerPromo2Bal' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerPromo2Bal

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerStubBal' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerStubBal

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerStubs' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerStubs

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerTag' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerTag

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPlayerType' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPlayerType

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPrize' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPrize

UNION

SELECT  GETDATE() AS AsOf_Date ,'tPrizeEffectiveDtValidDt' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPrizeEffectiveDtValidDt

UNION

SELECT  GETDATE() AS AsOf_Date ,'tRetired' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tRetired

UNION

SELECT  GETDATE() AS AsOf_Date ,'tRole' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tRole

UNION

SELECT  GETDATE() AS AsOf_Date ,'tSlotRating' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tSlotRating

UNION

SELECT  GETDATE() AS AsOf_Date ,'tSportsRating' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tSportsRating

UNION

SELECT  GETDATE() AS AsOf_Date ,'tState' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tState

UNION

SELECT  GETDATE() AS AsOf_Date ,'tTableRating' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tTableRating

UNION

SELECT  GETDATE() AS AsOf_Date ,'tTag' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tTag

UNION

SELECT  GETDATE() AS AsOf_Date ,'tTagCategory' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tTagCategory

UNION

SELECT  GETDATE() AS AsOf_Date ,'tTranCode' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tTranCode

UNION

SELECT  GETDATE() AS AsOf_Date ,'tviewAllRatingsViejasNoAwards' AS TableName ,  'GamingDt' AS [Column_Checked] , CAST(MAX(GamingDt) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tviewAllRatingsViejasNoAwards

UNION

SELECT  GETDATE() AS AsOf_Date ,'tviewEmps' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tviewEmps

UNION

SELECT  GETDATE() AS AsOf_Date ,'tviewPlayersViejas' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tviewPlayersViejas

UNION

SELECT  GETDATE() AS AsOf_Date ,'Website_Tag_List' AS TableName ,  'ModifiedDtm' AS [Column_Checked] , CAST(MAX(ModifiedDtm) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMP_13-1].tPrize

UNION

SELECT  GETDATE() AS AsOf_Date ,'CMPAPI.tviewv_EveriAcct' AS TableName ,  'PatronId' AS [Column_Checked] , CAST(MAX(PatronId) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMPAPI].[tviewv_EveriAcct]

UNION

SELECT  GETDATE() AS AsOf_Date ,'CMPAPI.tviewv_TM' AS TableName ,  'EmpId' AS [Column_Checked] , CAST(MAX(EmpId) AS VARCHAR(22)) AS Max_Date_or_Key
FROM [iQ-Gaming].[CMPAPI].[tviewv_TM]

GO


SELECT TOP (1000) [AsOf_Date]
      ,[TableName]
      ,[Column_Checked]
      ,[Max_Date_or_Key]
  FROM [SystemMaintDB].[dbo].[CMP_Tables_Current_Data_Check]

 ORDER BY Max_Date_or_Key DESC

