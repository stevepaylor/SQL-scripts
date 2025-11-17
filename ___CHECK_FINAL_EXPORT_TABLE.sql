/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
  [Current_Tier]
, [Current_Requal_Tier]
, [Current_Requal_Upgrade_Tier]
, COUNT(*)

FROM [RequalDB].[dbo].[MV_Requal_Meter_Data_Export]

GROUP BY
  [Current_Tier]
, [Current_Requal_Tier]
, [Current_Requal_Upgrade_Tier]

--SELECT 
--  [Current_Requal_Tier]
--, COUNT(*)

--FROM [RequalDB].[dbo].[MV_Requal_Meter_Data_Export]

--GROUP BY
--  [Current_Requal_Tier]