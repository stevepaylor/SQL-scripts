INSERT INTO LoginSync..CMKTDB13Apr_Logins
SELECT 
  B.Instance
, B.[Login]
, B.Pswd
, B.[Sid]
, B.DefalutDB

FROM LoginSync..CMKTDB13Bpr_Logins B 

WHERE B.[Login] = 'VIEJAS\kerazo'