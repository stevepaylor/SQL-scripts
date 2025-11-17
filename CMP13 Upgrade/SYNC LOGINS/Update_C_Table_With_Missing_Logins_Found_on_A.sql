INSERT INTO LoginSync..CMKTDB13Cpr_Logins
SELECT 
  A.Instance
, A.[Login]
, A.Pswd
, A.[Sid]
, A.DefalutDB

FROM LoginSync..CMKTDB13Apr_Logins A 

WHERE A.[Login] = 'VIEJAS\APPSWB21APR$'