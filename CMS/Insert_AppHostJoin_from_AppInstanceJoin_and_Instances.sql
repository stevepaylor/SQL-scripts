USE [DASI]
GO

--INSERT INTO [dbo].[AppHostJoin]
--           ([AppID]
--           ,[HostName])
--     VALUES
--           (<AppID, varchar(10),>
--           ,<HostName, varchar(255),>)
--GO


INSERT INTO DASI..AppHostJoin
SELECT DISTINCT
 AIJ.AppID
--,AIJ.Instance
,I.HostName
FROM DASI..AppInstanceJoin AIJ
JOIN DASI..Instances I
ON AIJ.Instance = I.Instance 

ORDER BY
 AIJ.AppID
,I.HostName

