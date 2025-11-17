SELECT 
  target.[PlayerId]
, target.[ContactTypeId]
, target.[EmailAddress]
, target.[DeletedFromCMP13_TS]
, target.mod_TM_Number
, source.TEAM_MEMBER_NUM

FROM [Viejas_Custom_Processes].[dbo].[tPlayerEmail_Other_Cleanup_Deletes] target with (nolock)

INNER JOIN CMPAPI.dbo.v_TM AS source with (nolock)
ON target.ModifiedBy = source.EmpId

WHERE target.mod_TM_Number <> source.TEAM_MEMBER_NUM


UPDATE target
SET 
  target.mod_TM_Number = source.TEAM_MEMBER_NUM
, target.mod_TM_FirstName = source.TEAM_MEMBER_FIRST_NM
, target.mod_TM_LastName = source.TEAM_MEMBER_LAST_NM
, target.mod_TM_DeptNo = source.DEPT_NM
, target.mod_TM_Position = source.Position
, target.mod_TM_JobTitle = source.JOB_TITLE_NM 

FROM [Viejas_Custom_Processes].[dbo].[tPlayerEmail_Other_Cleanup_Deletes] target

INNER JOIN CMPAPI.dbo.v_TM AS source
ON target.ModifiedBy = source.EmpId