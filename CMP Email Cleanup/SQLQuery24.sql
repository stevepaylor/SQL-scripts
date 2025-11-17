SELECT 
  tpe.PlayerId
, tpe.ContactTypeId
, tpe.EmailAddress
, tpe.IsEmailSend
, tpe.IsInactive
, tpe.CreatedDtm
, tpe.CreatedBy
, tpe.ModifiedDtm
, tpe.ModifiedBy
, tpe.DataRowVersion
, CURRENT_TIMESTAMP
, cre.TEAM_MEMBER_NUM AS CRE_TM_NUM
, cre.TEAM_MEMBER_FIRST_NM AS CRE_TM_FIRST_NM
, cre.TEAM_MEMBER_LAST_NM AS CRE_TM_LAST_NM    
, cre.DEPT_NM AS CRE_DEPT_NM
, cre.Position AS CRE_Position
, cre.JOB_TITLE_NM AS CRE_JOB_TITLE_NM
, mod.TEAM_MEMBER_NUM AS MOD_TM_NUM
, mod.TEAM_MEMBER_FIRST_NM AS MOD_TM_FIRST_NM
, mod.TEAM_MEMBER_LAST_NM AS MOD_TM_LAST_NM    
, mod.DEPT_NM AS MOD_DEPT_NM
, mod.Position AS MOD_Position
, mod.JOB_TITLE_NM AS MOD_JOB_TITLE_NM

FROM CMP13.dbo.tPlayerEmail tpe

LEFT JOIN CMP13.dbo.viewPlayersViejas vpv 
  ON tpe.playerid = vpv.playerid

LEFT JOIN CMPAPI.dbo.v_TM cre 
on tpe.CreatedBy = cre.EmpId

LEFT JOIN CMPAPI.dbo.v_TM mod 
on tpe.CreatedBy = mod.EmpId

WHERE (vpv.acct NOT LIKE '99999%' 
  AND vpv.firstname NOT LIKE '%Viejas%' 
  AND vpv.lastname NOT LIKE '%giftcard%'
  AND tpe.EmailAddress IS NOT NULL 
  AND tpe.EmailAddress NOT LIKE '%@%.%')
   OR tpe.EmailAddress IN (SELECT Email FROM CMP13.dbo.ViejasInvalidEmails);  -- added in to replace old email clean up job