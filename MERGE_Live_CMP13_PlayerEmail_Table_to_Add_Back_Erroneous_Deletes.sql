MERGE INTO CMP13.dbo.tPlayerEmail AS target
USING Viejas_Custom_Processes.dbo.tPlayerEmail_Add_Back_Erroroneous_Deletes AS source

ON target.PlayerId = source.PlayerId
AND target.ContactTypeId = source.ContactTypeId

----------------------
-- 1) Capture new rows
----------------------

WHEN NOT MATCHED THEN INSERT
(
  PlayerId
, ContactTypeId
, EmailAddress
, IsEmailSend
, IsInactive
, CreatedDtm
, CreatedBy
, ModifiedDtm
, ModifiedBy
, DataRowVersion
)
VALUES 
(
  source.PlayerId
, source.ContactTypeId
, source.EmailAddress
, source.IsEmailSend
, source.IsInactive
, source.CreatedDtm
, source.CreatedBy
, source.ModifiedDtm
, source.ModifiedBy
, source.DataRowVersion
)

---------------------------------------------------------------------------------------------------------
-- 2) Update changed rows 
---------------------------------------------------------------------------------------------------------

WHEN MATCHED 
THEN UPDATE
SET
  target.PlayerId = source.PlayerId
, target.ContactTypeId = source.ContactTypeId
, target.EmailAddress = source.EmailAddress
, target.IsEmailSend = source.IsEmailSend
, target.IsInactive = source.IsInactive
, target.CreatedDtm = source.CreatedDtm
, target.CreatedBy = source.CreatedBy
, target.ModifiedDtm = source.ModifiedDtm
, target.ModifiedBy = source.ModifiedBy
, target.DataRowVersion = source.DataRowVersion
;
-----------------------------------------------------------------------
-- 3) Delete rows that have been removed from source / refreshed table
-----------------------------------------------------------------------

--WHEN NOT MATCHED BY source THEN DELETE;

--GO

--------------------------------------------------------------------------------------------
-- Bounce the updated tPlayerEmail table against the tPlayerEmail_HardBounce_Deletes table
-- to remove deleted records that were inadvertently re-added in the above processing. 
-- this to emulate what the table will look like when the process is running in production. 
--------------------------------------------------------------------------------------------

--MERGE INTO Viejas_Custom_Processes.dbo.tPlayerEmail AS target
--USING (SELECT * FROM Viejas_Custom_Processes.dbo.tPlayerEmail_HardBounce_Deletes) AS source
--ON target.PlayerId = source.PlayerId
--AND target.ContactTypeId = source.ContactTypeId

---------------------------------------------------------------------------------------------------------
-- 1) When found in hardbounce deletes table, then delete from the updated tPlayerEmail table
---------------------------------------------------------------------------------------------------------

--WHEN MATCHED THEN DELETE;

GO
