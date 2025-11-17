--**************************************************************************************
--
-- Created on 10/17/2022
-- Author spaylor
-- 
-- This job deletes invalid Email records from CMP based on logic probide by Nate W.
-- in Marketing.
------------------------------------------------------------------------------------
-- Using logic provided by Nate in Marketing,  write records that will be deleted
-- to an history table named tPlayerEmail_Other_Cleanup_Deletes to be used for 
-- recovering data if necessary
-------------------------------------------------------------------------------------
--
-- Updated on 10/31/2022
--
-- Add Team Member information to the table that saves rows that are being deleted
--**************************************************************************************

-- Save a copy of the deleted rows with timestamp and TM info appended

INSERT INTO Viejas_Custom_Processes.dbo.tPlayerEmail_Other_Cleanup_Deletes

SELECT 
  tpe.*
, CURRENT_TIMESTAMP
, e.TEAM_MEMBER_NUM
, e.TEAM_MEMBER_FIRST_NM
, e.TEAM_MEMBER_LAST_NM      
, e.DEPT_NM
, e.Position
, e.JOB_TITLE_NM

FROM CMP13.dbo.tPlayerEmail tpe

LEFT JOIN CMP13.dbo.viewPlayersViejas vpv 
  ON tpe.playerid = vpv.playerid

LEFT JOIN CMPAPI.dbo.v_TM e 
on tpe.CreatedBy = e.EmpId

WHERE (vpv.acct NOT LIKE '99999%' 
  AND vpv.firstname NOT LIKE '%Viejas%' 
  AND vpv.lastname NOT LIKE '%giftcard%'
  AND tpe.EmailAddress IS NOT NULL 
  AND tpe.EmailAddress NOT LIKE '%@%.%')
   OR tpe.EmailAddress IN (SELECT Email FROM CMP13.dbo.ViejasInvalidEmails);  -- added in to replace old email clean up job


-- Using the same criteria of the above query, delete from the tPlayerEmail table

DELETE tpe
FROM CMP13.dbo.tPlayerEmail tpe
LEFT JOIN CMP13.dbo.viewPlayersViejas vpv 
  ON tpe.playerid = vpv.playerid

WHERE (vpv.acct NOT LIKE '99999%' 
  AND vpv.firstname NOT LIKE '%Viejas%' 
  AND vpv.lastname NOT LIKE '%giftcard%'
  AND tpe.EmailAddress IS NOT NULL 
  AND tpe.EmailAddress NOT LIKE '%@%.%')
   OR tpe.EmailAddress IN (SELECT Email FROM CMP13.dbo.ViejasInvalidEmails);  -- added in to replace old email clean up job