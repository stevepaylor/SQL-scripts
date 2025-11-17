USE DASI
GO

SELECT
 I.[Instance]
--,I.Active
--,IA.LoginWithSA
--,COUNT(*) AS Instance_Count

FROM Instances I
JOIN Instances_Accessible IA
ON I.[Instance] = IA.[Instance] 

WHERE I.Active = 'Y'
  AND IA.LoginWithSA = 'Y'

--GROUP BY 
-- I.Active
--,IA.LoginWithSA

ORDER BY 
 I.[Instance]
-- I.Active
--,IA.LoginWithSA