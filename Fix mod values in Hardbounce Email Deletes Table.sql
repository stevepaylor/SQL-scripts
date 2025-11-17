SELECT DISTINCT
  thb.PlayerId
, thb.ContactTypeId
, thb.email_bounce_dttm
, thb.DeletedFromCMP13_TS
, tmp.mod_TM_Number AS temp_TM_Number 
, thb.mod_TM_Number
, tmp.mod_TM_FirstName AS temp_FirstName
, thb.mod_TM_FirstName
, tmp.mod_TM_LastName AS temp_LastName
, thb.mod_TM_LastName
, tmp.mod_TM_DeptNo AS temp_DeptNo
, thb.mod_TM_DeptNo
, tmp.mod_TM_Position AS temp_Postion
, thb.mod_TM_Position
, tmp.mod_TM_JobTitle AS temp_JobTitle
, thb.mod_TM_JobTitle

FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes thb
LEFT OUTER JOIN Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes_TEMP tmp
ON thb.PlayerId = tmp.PlayerId
AND thb.ContactTypeId = tmp.ContactTypeId
AND thb.email_bounce_dttm = tmp.email_bounce_dttm
AND thb.DeletedFromCMP13_TS = tmp.DeletedFromCMP13_TS

--WHERE thb.mod_TM_Number <>  tmp.mod_TM_Number
--WHERE thb.mod_TM_FirstName <> tmp.mod_TM_FirstName
--WHERE thb.mod_TM_LastName <> tmp.mod_TM_LastName
--WHERE thb.mod_TM_DeptNo <> tmp.mod_TM_DeptNo
--WHERE thb.mod_TM_Position <> tmp.mod_TM_Position
WHERE thb.mod_TM_JobTitle <> tmp.mod_TM_JobTitle


------SELECT *
------FROM CMPAPI.dbo.v_TM



MERGE INTO Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes AS target
USING (
SELECT DISTINCT
  EmpId
, TEAM_MEMBER_NUM
, TEAM_MEMBER_FIRST_NM
, TEAM_MEMBER_LAST_NM
, DEPT_NM
, Position
, JOB_TITLE_NM 
FROM CMPAPI.dbo.v_TM
--WHERE IsInactive = 0
) AS source
ON target.ModifiedBy = source.EmpId
AND target.mod_TM_Number = source.TEAM_MEMBER_NUM

WHEN MATCHED THEN UPDATE
SET 
  target.mod_TM_FirstName = source.TEAM_MEMBER_FIRST_NM
, target.mod_TM_LastName = source.TEAM_MEMBER_LAST_NM
, target.mod_TM_DeptNo = source.DEPT_NM
, target.mod_TM_Position = source.Position
, target.mod_TM_JobTitle = source.JOB_TITLE_NM ;
