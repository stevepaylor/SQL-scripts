SELECT 
  A.Instance AS Instance_A
, C.Instance AS Instance_C
, A.[Login]
, A.Pswd as Pswd_A
, C.Pswd as Pswd_C
, A.[Sid]
, A.DefalutDB

FROM LoginSync..CMKTDB13Apr_Logins A
JOIN LoginSync..CMKTDB13Cpr_Logins C 
ON A.[Login] = C.[Login]

WHERE A.Pswd <> C.Pswd