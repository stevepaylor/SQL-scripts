SELECT DISTINCT
  tpp.PlayerId
, tpp.ContactTypeId
, tpp.PhoneNumber
, tpp.Extension
, tpp.IsCall
, tpp.IsSendTextMessage
, tpp.IsInactive
, tpp.CreatedDtm
, tpp.CreatedBy
, tpp.ModifiedDtm
, tpp.ModifiedBy
, tpp.DataRowVersion
, tpp.DeletedFromCMP13_TS
, tmp.mod_TM_Number AS temp_TM_Number 
, tpp.mod_TM_Number
, tmp.mod_TM_FirstName AS temp_FirstName
, tpp.mod_TM_FirstName
, tmp.mod_TM_LastName AS temp_LastName
, tpp.mod_TM_LastName
, tmp.mod_TM_DeptNo AS temp_DeptNo
, tpp.mod_TM_DeptNo
, tmp.mod_TM_Position AS temp_Postion
, tpp.mod_TM_Position
, tmp.mod_TM_JobTitle AS temp_JobTitle
, tpp.mod_TM_JobTitle

FROM Viejas_Custom_Processes.dbo.tPlayerPhone_Cleanup_Deletes tpp
LEFT OUTER JOIN Viejas_Custom_Processes.dbo.tPlayerPhone_Cleanup_Deletes_TEMP tmp
ON tpp.PlayerId = tmp.PlayerId
AND tpp.ContactTypeId = tmp.ContactTypeId
AND tpp.DeletedFromCMP13_TS = tmp.DeletedFromCMP13_TS

--WHERE tpp.mod_TM_Number <>  tmp.mod_TM_Number
--WHERE tpp.mod_TM_FirstName <> tmp.mod_TM_FirstName
--WHERE tpp.mod_TM_LastName <> tmp.mod_TM_LastName
--WHERE tpp.mod_TM_DeptNo <> tmp.mod_TM_DeptNo
--WHERE tpp.mod_TM_Position <> tmp.mod_TM_Position
WHERE tpp.mod_TM_JobTitle <> tmp.mod_TM_JobTitle

	--(24783 rows affected)

JOIN CMPAPI.dbo.v_TM mod 
on tpp.ModifiedBy = mod.EmpId

SELECT *
FROM CMPAPI.dbo.v_TM



MERGE INTO Viejas_Custom_Processes.dbo.tPlayerPhone_Cleanup_Deletes AS target
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
