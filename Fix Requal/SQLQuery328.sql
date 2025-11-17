SELECT * 
FROM [RequalDB].[dbo].[MV_Requal_Meter_Data_Export_TEMP]
WHERE PlayerID IN ('78186','10506311','1037053')
ORDER BY PlayerID

SELECT * 
FROM [RequalDB].[dbo].[MV_Requal_Meter_Data_Export]
WHERE PlayerID IN ('78186','10506311','1037053')
ORDER BY PlayerID

SELECT COUNT(*) 
FROM [RequalDB].[dbo].[MV_Requal_Meter_Data_Export_TEMP]

SELECT COUNT(*) 
FROM [RequalDB].[dbo].[MV_Requal_Meter_Data_Export]

SELECT COUNT(*) 
FROM [RequalDB].[dbo].[Requal_15d_Data_Export]

SELECT COUNT(*) 
FROM [RequalDB].[dbo].[R_15d_Data_Export]