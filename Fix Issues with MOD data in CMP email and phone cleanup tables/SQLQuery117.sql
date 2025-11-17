SELECT DISTINCT
  tEMP.empnum
, v_TM.TEAM_MEMBER_NUM

FROM cmp13.dbo.temp AS tEmp
FULL Join CMPAPI.dbo.v_TM AS v_TM
ON cast(tEmp.empnum as varchar) = cast(v_TM.TEAM_MEMBER_NUM as varchar) 

WHERE tEmp.empnum IS NULL
   OR v_TM.TEAM_MEMBER_NUM  IS NULL

 
 UPDATE target
SET 
  target.mod_TM_Number = source.EmpNum --TEAM_MEMBER_NUM
, target.mod_TM_FirstName = source.FirstName --TEAM_MEMBER_FIRST_NM
, target.mod_TM_LastName = source.LastName --TEAM_MEMBER_LAST_NM
--, target.mod_TM_DeptNo = source.DEPT_NM
, target.mod_TM_Position = source.Position
, target.mod_TM_JobTitle = source.Title --JOB_TITLE_NM 

FROM Viejas_Custom_Processes.dbo.tPlayerPhone_Cleanup_Deletes target

INNER JOIN [dbo].[tEmp] AS source
ON target.ModifiedBy = source.EmpId

--WHERE target.mod_TM_Number <> source.TEAM_MEMBER_NUM
WHERE target.playerid = 212
