UPDATE hbd
SET
  hbd.cre_TM_Number =  cre.TEAM_MEMBER_NUM
, hbd.cre_TM_FirstName =  cre.TEAM_MEMBER_FIRST_NM
, hbd.cre_TM_LastName = cre.TEAM_MEMBER_LAST_NM   
, hbd.cre_TM_DeptNo = cre.DEPT_NM
, hbd.cre_TM_Position = cre.Position
, hbd.cre_TM_JobTitle = cre.JOB_TITLE_NM 

, hbd.mod_TM_Number =  mod.TEAM_MEMBER_NUM
, hbd.mod_TM_FirstName =  mod.TEAM_MEMBER_FIRST_NM
, hbd.mod_TM_LastName = mod.TEAM_MEMBER_LAST_NM   
, hbd.mod_TM_DeptNo = mod.DEPT_NM
, hbd.mod_TM_Position = mod.Position
, hbd.mod_TM_JobTitle = mod.JOB_TITLE_NM 

FROM [Viejas_Custom_Processes].[dbo].[tPlayerEmail_HardBounce_Deletes] AS hbd

LEFT OUTER JOIN CMPAPI.dbo.v_TM AS cre
  ON hbd.CreatedBy = cre.EmpId

LEFT OUTER JOIN CMPAPI.dbo.v_TM AS mod
  ON hbd.ModifiedBy = mod.EmpId