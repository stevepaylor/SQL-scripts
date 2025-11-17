SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_04_Patron_Ratings_By_Dept]
	--WHERE PlayerID = 66

SELECT COUNT(*)
  FROM [RequalDB].[dbo].[R_temp_04_Patron_Ratings_By_Dept]
	----WHERE PlayerID = 66

SELECT SUM(BasePts)
  FROM [RequalDB].[dbo].[R_04_Patron_Ratings_By_Dept]
	--WHERE PlayerID = 66

SELECT SUM(BasePts)
  FROM [RequalDB].[dbo].[R_temp_04_Patron_Ratings_By_Dept]
	--WHERE PlayerID = 66

SELECT TOP (1000) [PlayerID]
      ,[IsVoid]
      ,[GamingDt]
      ,[DeptID4]
      ,[BasePts]
  FROM [RequalDB].[dbo].[R_04_Patron_Ratings_By_Dept]
--WHERE PlayerID = 66

	SELECT TOP (1000) [PlayerID]
      ,[GamingDt]
      ,[DeptID4]
      ,[BasePts]
  FROM [RequalDB].[dbo].[R_temp_04_Patron_Ratings_By_Dept]
	--WHERE PlayerID = 66