--***********************************************************************************************
-- Use MERGE command to update the iIQC_Player_Phone_OptIn table from the table on PLAYERPORTALRDS
--***********************************************************************************************

MERGE INTO  vDW4.dbo.IQC_Player_Phone_OptIn AS target
USING (SELECT * FROM PLAYERPORTALRDS.app.dbo.IQC_Player_Phone_OptIn WHERE status = 2) AS source
ON target.IdNo = source.IdNo

WHEN NOT MATCHED THEN INSERT 
(
  MessageId
, To_Number
, From_Number
, Text
, Keyword
, ReceivedAt
, IdNo
, Status
, Updated_At
, Birthdate
)
VALUES 
(
  source.MessageId
, source.To_Number
, source.From_Number
, source.Text
, source.Keyword
, source.ReceivedAt
, source.IdNo
, source.Status
, source.Updated_At
, source.Birthdate
)

-----------------------------------------------------------------------
-- 2) WHEN MATCHED THEN DO NOTHING
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- 3) Delete rows that have been removed from source table
-----------------------------------------------------------------------

WHEN NOT MATCHED BY source THEN DELETE;

GO
