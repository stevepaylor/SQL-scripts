/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [PlayerID]
      ,[IsVoid]
      ,[GamingDt]
      ,[DeptID4]
      ,[BasePts]
  --FROM [RequalDB].[dbo].[CMP_tblRatings]
    FROM [RequalDB].[dbo].[tblRatings_2]

  where PlayerID = '1426933'
  --and GamingDt>'07-01-2020'

  order by 
 [GamingDt] desc