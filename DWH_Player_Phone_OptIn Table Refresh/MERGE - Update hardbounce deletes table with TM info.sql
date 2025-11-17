--***********************************************************************************************
-- Use MERGE command to update the iIQC_Player_Phone_OptIn table from the table on PLAYERPORTALRDS
--***********************************************************************************************

MERGE Viejas_Custom_Processes.dbo.tPlayerEmail_Other_Cleanup_Deletes AS target
USING CMPAPI.dbo.v_TM AS source
ON target.CreatedBy = source.EmpId

WHEN MATCHED THEN UPDATE 
SET
  TEAM_MEMBER_NUM = source.TEAM_MEMBER_NUM 
, TEAM_MEMBER_FIRST_NM = source.TEAM_MEMBER_FIRST_NM 
, TEAM_MEMBER_LAST_NM = source.TEAM_MEMBER_LAST_NM 
, DEPT_NM = source.DEPT_NM  
, Position = source.Position 
, JOB_TITLE_NM = source.JOB_TITLE_NM
;

GO
