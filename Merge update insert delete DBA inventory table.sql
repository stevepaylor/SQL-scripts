MERGE INTO DBA.dbo.Inventory AS I -- Target Table
USING DBA.dbo.Inventory_Temp AS W -- Source Table  
ON  I.Instance = W.Instance
AND I.Object_type = W.Object_type
AND I.[ID] = W.[ID]
AND I.[name] = W.[name]
AND I.date_created = W.date_created
AND I.sid = W.sid

-- WHEN MATCHED THEN IGNORE \ DO NOTHING

WHEN NOT MATCHED THEN INSERT 
  (
  Instance
, Object_type
, [ID]
, [name]
, date_created
, date_modified
, sid
, Date_Added
  ) 
  VALUES 
  (
  W.Instance
, W.Object_type
, W.[ID]
, W.[name]
, W.date_created
, W.date_modified
, W.sid
, CURRENT_TIMESTAMP
  )

  WHEN MATCHED THEN UPDATE 
  SET date_modified = W.date_modified
    , Date_Updated = CURRENT_TIMESTAMP

  WHEN NOT MATCHED BY SOURCE THEN UPDATE
  SET Date_Deleted = CURRENT_TIMESTAMP;