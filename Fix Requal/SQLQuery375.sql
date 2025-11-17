/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [PlayerID]
      ,[IsVoid]
      ,[GamingDt]
      ,[DeptID4]
      ,[BasePts]
  FROM [RequalDB].[dbo].[tblRatings]

  WHERE PlayerID IN ('78186','10506311','1037053')

  USE [RequalDB]
GO

INSERT INTO [dbo].[tblRatings]
           ([PlayerID]
           ,[IsVoid]
           ,[GamingDt]
           ,[DeptID4]
           ,[BasePts])
     VALUES
           (78186
           ,0
           ,'2020-07-09'
           ,'SLOT'
           ,400000)
GO

