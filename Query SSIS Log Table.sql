USE [MyViejasSSIS]
GO

SELECT [id]
      ,[event]
      ,[source]
      ,[starttime]
      ,[endtime]
      ,[message]
  FROM [dbo].[sysssislog]
GO

--TRUNCATE TABLE [MyViejasSSIS].[dbo].[sysssislog]
--GO