-- EMAIL DELETES BASED ON HARDBOUNCE NOTIFICATION FROM DWH

--**************************************************************************************
--
-- Created on 10/17/2022
-- Author spaylor
----------------------------------------------------------------------------------------
-- Save a copy of the deleted rows with the hardbounce data appended

-- Join the tPlayerEmail and DBM Email_HardBounce (on DWHDB02pr) tables
-- and write those records to an history table named tPlayerEmail_HardBounce_Deletes
----------------------------------------------------------------------------------------
--
-- Updated on 11/02/2022
-- By spaylor
--
-- Add CreatedBy and ModinfiedBy Team Member information to the table that saves rows that are being deleted
--**********************************************************************************************************

INSERT INTO Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes
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

, cre.TEAM_MEMBER_NUM AS cre_TM_Number
, cre.TEAM_MEMBER_FIRST_NM AS cre_TM_FirstName
, cre.TEAM_MEMBER_LAST_NM AS cre_TM_LastName    
, cre.DEPT_NM AS cre_TM_DeptNo
, cre.Position AS cre_TM_Position
, cre.JOB_TITLE_NM AS cre_TM_JobTitle

, mod.TEAM_MEMBER_NUM AS mod_TM_Number
, mod.TEAM_MEMBER_FIRST_NM AS mod_TM_FirstName
, mod.TEAM_MEMBER_LAST_NM AS mod_TM_LastName    
, mod.DEPT_NM AS mod_TM_DeptNo
, mod.Position AS mod_TM_Position
, mod.JOB_TITLE_NM AS mod_TM_JobTitle

, CURRENT_TIMESTAMP AS DeletedFromCMP13_TS

, dwh.email_bounce_dttm
, dwh.recipient_domain_nm
, dwh.reason_txt

FROM CMP13.dbo.tPlayerEmail tpe
JOIN DWHDB02PR.DBM.dbo.Email_HardBounce dwh  -- Limits rows to only those found in the HardBounce table
ON tpe.PlayerId = dwh.Playerid

LEFT JOIN CMPAPI.dbo.v_TM cre 
on tpe.CreatedBy = cre.EmpId

LEFT JOIN CMPAPI.dbo.v_TM mod 
on tpe.ModifiedBy = mod.EmpId

WHERE dwh.email_bounce_dttm > tpe.ModifiedDtm -- Limits rows to only those that bounced after they were last modified (updated)

-----------------------------------------------------------------------------
-- Delete the rows that were saved above from the tPlayerEmail table
------------------------------------------------------------------------------

DELETE tpe
FROM CMP13.dbo.tPlayerEmail tpe
JOIN DWHDB02PR.DBM.dbo.Email_HardBounce dwh  -- Limits rows to only those found in the HardBounce table
ON tpe.PlayerId = dwh.Playerid

WHERE dwh.email_bounce_dttm > tpe.ModifiedDtm -- Limits rows to only those that bounced after they were last modified (updated)

WHERE dwh.email_bounce_dttm > tpe.ModifiedDtm -- Limits rows to only those that bounced after they were last modified (updated)
SELECT TOP (1000) *
FROM [Viejas_Custom_Processes].[dbo].[tPlayerEmail_HardBounce_Deletes]

-- EMAILS DELETED BASED ON LOGIC FROM MARKETING

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
-- Add CreatedBy Team Member information to the table that saves rows that are being deleted
------------------------------------------------------------------------------------
--
-- Updated on 11/02/2022
--
-- Add ModinfiedBy Team Member information to the table that saves rows that are being deleted
--**************************************************************************************

-- Save a copy of the deleted rows with timestamp and TM info appended

INSERT INTO Viejas_Custom_Processes.dbo.tPlayerEmail_Other_Cleanup_Deletes

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

, CURRENT_TIMESTAMP AS DeletedFromCMP13_TS

, cre.TEAM_MEMBER_NUM AS cre_TM_Number
, cre.TEAM_MEMBER_FIRST_NM AS cre_TM_FirstName
, cre.TEAM_MEMBER_LAST_NM AS cre_TM_LastName    
, cre.DEPT_NM AS cre_TM_DeptNo
, cre.Position AS cre_TM_Position
, cre.JOB_TITLE_NM AS cre_TM_JobTitle

, mod.TEAM_MEMBER_NUM AS mod_TM_Number
, mod.TEAM_MEMBER_FIRST_NM AS mod_TM_FirstName
, mod.TEAM_MEMBER_LAST_NM AS mod_TM_LastName    
, mod.DEPT_NM AS mod_TM_DeptNo
, mod.Position AS mod_TM_Position
, mod.JOB_TITLE_NM AS mod_TM_JobTitle

FROM CMP13.dbo.tPlayerEmail tpe

LEFT JOIN CMP13.dbo.viewPlayersViejas vpv 
  ON tpe.playerid = vpv.playerid

LEFT JOIN CMPAPI.dbo.v_TM cre 
on tpe.CreatedBy = cre.EmpId

LEFT JOIN CMPAPI.dbo.v_TM mod 
on tpe.ModifiedBy = mod.EmpId

WHERE vpv.acct NOT LIKE '99999%' 
  AND vpv.firstname NOT LIKE '%Viejas%' 
  AND vpv.lastname NOT LIKE '%giftcard%'
 
  AND (tpe.IsInactive = 1 
       OR tpe.EmailAddress IN (SELECT Email FROM CMP13.dbo.ViejasInvalidEmails) -- added in to replace old email clean up job
	   OR tpe.EmailAddress NOT LIKE '%@%.%' 
	   OR tpe.EmailAddress IS NULL);

-- Using the same criteria of the above query, delete from the tPlayerEmail table

DELETE tpe
FROM CMP13.dbo.tPlayerEmail tpe
LEFT JOIN CMP13.dbo.viewPlayersViejas vpv 
  ON tpe.playerid = vpv.playerid

WHERE vpv.acct NOT LIKE '99999%' 
  AND vpv.firstname NOT LIKE '%Viejas%' 
  AND vpv.lastname NOT LIKE '%giftcard%'
 
  AND (tpe.IsInactive = 1 
       OR tpe.EmailAddress IN (SELECT Email FROM CMP13.dbo.ViejasInvalidEmails) -- added in to replace old email clean up job
	   OR tpe.EmailAddress NOT LIKE '%@%.%' 
	   OR tpe.EmailAddress IS NULL);

SELECT TOP (1000) *
FROM [Viejas_Custom_Processes].[dbo].[tPlayerEmail_Other_Cleanup_Deletes]


 -- PHONE DELETES BASED ON LOGIC FROM MARKETING

 ---------------------------------------------------------------------
--
-- Created on 10/18/2022
-- Author spaylor
-- 
-- This job deletes invalid Phone records from CMP based on logic probide by Nate W.
-- in Marketing.
------------------------------------------------------------------------------------
-- Using logic provided by Nate in Marketing,  write records that will be deleted
-- to an history table named tPlayerPhone_Cleanup_Deletes to be used for 
-- recovering data if necessary
-------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--
-- Updated on 11/08/2022
--
-- Add ModinfiedBy Team Member information to the table that saves rows that are being deleted
--**************************************************************************************

-- Save a copy of the deleted rows with timestamp appended

INSERT INTO Viejas_Custom_Processes.dbo.tPlayerPhone_Cleanup_Deletes

SELECT 
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

, cre.TEAM_MEMBER_NUM AS cre_TM_Number
, cre.TEAM_MEMBER_FIRST_NM AS cre_TM_FirstName
, cre.TEAM_MEMBER_LAST_NM AS cre_TM_LastName    
, cre.DEPT_NM AS cre_TM_DeptNo
, cre.Position AS cre_TM_Position
, cre.JOB_TITLE_NM AS cre_TM_JobTitle

, mod.TEAM_MEMBER_NUM AS mod_TM_Number
, mod.TEAM_MEMBER_FIRST_NM AS mod_TM_FirstName
, mod.TEAM_MEMBER_LAST_NM AS mod_TM_LastName    
, mod.DEPT_NM AS mod_TM_DeptNo
, mod.Position AS mod_TM_Position
, mod.JOB_TITLE_NM AS mod_TM_JobTitle

, CURRENT_TIMESTAMP AS DeletedFromCMP13_TS


FROM CMP13.dbo.tPlayerPhone tpp
LEFT JOIN CMP13.dbo.viewPlayersViejas vpv 
       ON tpp.playerid = vpv.playerid

LEFT JOIN CMPAPI.dbo.v_TM cre 
on tpp.CreatedBy = cre.EmpId

LEFT JOIN CMPAPI.dbo.v_TM mod 
on tpp.ModifiedBy = mod.EmpId

WHERE tpp.ContactTypeId IN (3,8,10)
  AND vpv.acct NOT LIKE '9999%' 
  AND vpv.firstname NOT LIKE '%Viejas%' 
  AND vpv.lastname NOT LIKE '%giftcard%'
  AND LEN(CAST(tpp.PhoneNumber AS CHAR)) < 10 
  OR tpp.PhoneNumber LIKE '%a-z%' 
  OR tpp.PhoneNumber = '6194455400'
  OR (CAST(PhoneNumber AS VARCHAR(10)) = REPLICATE(LEFT(CAST(PhoneNumber AS VARCHAR(10)),1),LEN(CAST(PhoneNumber AS VARCHAR(10)))))

-- Using the same criteria of the above query, delete from the tPlayerPhone table

DELETE tpp
FROM CMP13.dbo.tPlayerPhone tpp
LEFT JOIN CMP13.dbo.viewPlayersViejas vpv 
       ON tpp.playerid = vpv.playerid

WHERE tpp.ContactTypeId IN (3,8,10)
  AND vpv.acct NOT LIKE '9999%' 
  AND vpv.firstname NOT LIKE '%Viejas%' 
  AND vpv.lastname NOT LIKE '%giftcard%'
  AND LEN(CAST(tpp.PhoneNumber AS CHAR)) < 10 
  OR tpp.PhoneNumber LIKE '%a-z%' 
  OR tpp.PhoneNumber = '6194455400'
  OR (CAST(PhoneNumber AS VARCHAR(10)) = REPLICATE(LEFT(CAST(PhoneNumber AS VARCHAR(10)),1),LEN(CAST(PhoneNumber AS VARCHAR(10)))))




SELECT TOP (1000) *
FROM [Viejas_Custom_Processes].[dbo].[tPlayerPhone_Cleanup_Deletes]


