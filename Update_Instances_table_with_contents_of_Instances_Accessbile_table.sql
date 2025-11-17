USE [DASI]
GO

UPDATE T1
SET 
 Accessible = SUBSTRING(LTRIM(T2.Accessible),1,1)
,spaylor = SUBSTRING(LTRIM(T2.spaylor),1,1)
,BuiltinAdmin = SUBSTRING(LTRIM(T2.BuiltinAdmin),1,1)
,ITAppsSQLadmin = T2.[ITAppsSQLadmin]
,SAPW = T2.SAPW

FROM DASI..Instances AS T1
INNER JOIN DASI..Instances_Accessible AS T2
ON T1.[Instance] = T2.[Instance];



