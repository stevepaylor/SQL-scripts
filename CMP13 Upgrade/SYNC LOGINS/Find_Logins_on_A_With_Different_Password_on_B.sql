SELECT 
  A.Instance AS Instance_A
, B.Instance AS Instance_B
, A.[Login]
, A.Pswd as Pswd_A
, B.Pswd as Pswd_B
, A.[Sid]
, A.DefalutDB

FROM LoginSync..CMKTDB13Apr_Logins A
JOIN LoginSync..CMKTDB13Bpr_Logins B 
ON A.[Login] = B.[Login]

WHERE A.Pswd <> B.Pswd