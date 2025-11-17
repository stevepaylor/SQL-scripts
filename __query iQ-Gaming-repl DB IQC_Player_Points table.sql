/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [playerid]
      ,[GamingDate]
      ,[GamePts]
      ,[BasePts]
      ,[GameBasePts]
      ,[BonusPts]
      ,[EarnedPts]
      ,[RedeemPts]
      ,[ExpirePts]
      ,[AdjPtsDr]
      ,[AdjPtsCr]
      ,[NetPts]
      ,[Loaddttm]
      ,[SourceSystem]
  FROM [iQ-Gaming-repl].[dbo].[IQC_Player_Points]

  ORDER BY [Loaddttm] DESC