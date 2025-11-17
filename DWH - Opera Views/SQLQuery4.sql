SELECT TOP 10
  new.RESV_NAME_ID as new_RESV_NAME_ID
, old.RESV_NAME_ID as old_RESV_NAME_ID
, new.Acct as new_Acct
, new.PlayerId as new_PlayerId
, new.NIGHTS as new_NIGHTS
--, old.NIGHTS as old_NIGHTS
, new.RESV_DATE as new_RESV_DATE 
, old.RESV_DATE as old_RESV_DATE 
, new.RESV_INDX as new_RESV_INDX
, old.RESV_INDX as old_RESV_INDX

FROM [iQ-Gaming].Opera_5_0.RESERVATIONS_NIGHTS new

FULL OUTER jOIN MSBIDB01DV.OperaDm.dbo.RESERVATIONS old
ON new.RESV_NAME_ID = old.RESV_NAME_ID
AND new.RESV_DATE = old.RESV_DATE

--WHERE new.RESV_NAME_ID IS NULL
--   OR old.RESV_NAME_ID IS NULL 


WHERE new.RESV_DATE IS NOT NULL
  AND old.RESV_DATE IS NOT NULL
  AND new.RESV_DATE < '2023-12-18'
  AND old.RESV_DATE < '2023-12-18'
  AND new.Acct IS NOT NULL

order by new.RESV_DATE desc
