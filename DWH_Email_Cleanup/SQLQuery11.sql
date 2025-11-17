---------------------------------------------------------------------
-- Save a copy of the deleted rows with the hardbounce data appended

-- Join the tPlayerEmail and DBM Email_HardBounce (on DWHDB02pr) tables
-- and write those records to an history table named tPlayerEmail_HardBounce_Deletes
---------------------------------------------------------------------

INSERT INTO CMP13_PLAYER_EMAIL_DEV.dbo.tPlayerEmail_HardBounce_Deletes
SELECT 
  a.PlayerId
, a.ContactTypeId
, a.EmailAddress
, a.IsEmailSend
, a.IsInactive
, a.CreatedDtm
, a.CreatedBy
, a.ModifiedDtm
, a.ModifiedBy
, a.DataRowVersion
, b.email_bounce_dttm
, b.recipient_domain_nm
, b.reason_txt

FROM CMP13_PLAYER_EMAIL_DEV.dbo.tPlayerEmail a
JOIN DWHDB02PR.DBM.dbo.Email_HardBounce_ALL b  -- Limits rows to only those found in the HardBounce table
ON a.PlayerId = b.Playerid

WHERE a.PlayerID NOT IN (SELECT PlayerID FROM CMP13_PLAYER_EMAIL_DEV.dbo.tPlayerEmail_HardBounce_Deletes)  -- Eliminates rows that have already be deleted and written to history

-----------------------------------------------------------------------------
-- Delete the rows that were saved above from the tPlayerEmail table

-- Join the tPlayerEmail and DBM Email_HardBounce (on DWHDB02pr) tables again
-- and delete the rows that were written (above) to the history table
------------------------------------------------------------------------------

DELETE a
FROM CMP13_PLAYER_EMAIL_DEV.dbo.tPlayerEmail a
JOIN DWHDB02PR.DBM.dbo.Email_HardBounce_ALL b
ON a.PlayerId = b.Playerid