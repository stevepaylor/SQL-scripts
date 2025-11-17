SELECT 
  A.Instance
, B.Instance
, A.[Login]
, A.Pswd
, A.[Sid]
, A.DefalutDB

FROM LoginSync..CMKTDB13Apr_Logins A
LEFT OUTER JOIN LoginSync..CMKTDB13Bpr_Logins B 
ON A.[Login] = B.[Login]

WHERE B.[Login] IS NULL