USE [DASI]
GO

UPDATE T1
SET 
 Active = 'N'
FROM DASI..Instances AS T1
INNER JOIN DASI..Hosts AS T2
ON T1.HostName = T2.HostName

WHERE T2.Active = 'N';



