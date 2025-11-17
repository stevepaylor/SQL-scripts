--INSERT INTO LoginSync..CMKTDB13Apr_Logins
SELECT 
  B.Instance
, A.Instance
, B.[Login]
, B.Pswd
, B.[Sid]
, B.DefalutDB

FROM LoginSync..CMKTDB13Bpr_Logins B
LEFT OUTER JOIN LoginSync..CMKTDB13Apr_Logins A 
ON B.[Login] = A.[Login]

WHERE A.[Login] IS NULL