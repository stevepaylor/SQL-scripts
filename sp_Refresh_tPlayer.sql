USE [vOnlineShop]
GO

/****** Object:  StoredProcedure [dbo].[sp_Refresh_tPlayer]    Script Date: 3/26/2021 2:10:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Refresh_tPlayer]

AS
BEGIN
--SELECT 
--  acct
--, firstName
--, LastName
--, ClubStatus
--, CompBal 
--FROM [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejas]
--WHERE ClubStatus in ('PLATINUM', 'GOLD')

/****************************************************************************************
Use MERGE command to update the vOnlineShop tPlayer table which is replicated

Run every 1 minute
*****************************************************************************************/

MERGE INTO [vOnlineShop].[dbo].[tPlayer] AS target
USING (
SELECT 
  acct 
, FirstName 
, LastName 
, ClubStatus 
, CompBal 
FROM [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejas]
--WHERE ClubStatus in ('PLATINUM', 'GOLD')
WHERE acct BETWEEN 99999980 AND 99999999
) 
AS source
ON target.acct = source.acct


-- WHEN NOT MATCHED THEN INSERT

WHEN NOT MATCHED THEN INSERT 
(
  acct 
, FirstName 
, LastName 
, ClubStatus 
, CompBal
, RefreshDTM
, RecordStatus
)
VALUES 
(
  source.acct 
, source.FirstName 
, source.LastName 
, source.ClubStatus 
, source.CompBal
, CURRENT_TIMESTAMP
, 'New'
)

-- WHEN MATCHED THEN UPDATE

WHEN MATCHED THEN UPDATE
SET 
  acct = source.acct
, FirstName = source.FirstName
, LastName = source.LastName
, ClubStatus = source.ClubStatus
, CompBal = source.CompBal
, RefreshDTM = CURRENT_TIMESTAMP
, RecordStatus = 'Updated'

-- WHEN ROW MISSING FROM SOURCE THEN SET RecordStatus to "Deleted"

WHEN NOT MATCHED BY source THEN UPDATE
SET
  RefreshDTM = CURRENT_TIMESTAMP
, RecordStatus = 'Deleted' ;

END
GO


