UPDATE pcd
SET
  pcd.cre_TM_Number =  cre.TEAM_MEMBER_NUM
, pcd.cre_TM_FirstName =  cre.TEAM_MEMBER_FIRST_NM
, pcd.cre_TM_LastName = cre.TEAM_MEMBER_LAST_NM   
, pcd.cre_TM_DeptNo = cre.DEPT_NM
, pcd.cre_TM_Position = cre.Position
, pcd.cre_TM_JobTitle = cre.JOB_TITLE_NM 

, pcd.mod_TM_Number =  mod.TEAM_MEMBER_NUM
, pcd.mod_TM_FirstName =  mod.TEAM_MEMBER_FIRST_NM
, pcd.mod_TM_LastName = mod.TEAM_MEMBER_LAST_NM   
, pcd.mod_TM_DeptNo = mod.DEPT_NM
, pcd.mod_TM_Position = mod.Position
, pcd.mod_TM_JobTitle = mod.JOB_TITLE_NM 

FROM [Viejas_Custom_Processes].[dbo].[tPlayerPhone_Cleanup_Deletes_STEVE] AS pcd

LEFT OUTER JOIN CMPAPI.dbo.v_TM AS cre
  ON pcd.CreatedBy = cre.EmpId

LEFT OUTER JOIN CMPAPI.dbo.v_TM AS mod
  ON pcd.ModifiedBy = mod.EmpId