MERGE DASI..HostInstanceJoin AS H
USING DASI..SQL_InventoryHost_Instance_Join AS S 
ON H.HostName = S.HOST
AND H.Instance = S.Instance

WHEN MATCHED THEN UPDATE 
  SET
  HostName = S.HOST
, Instance = S.Instance

WHEN NOT MATCHED THEN INSERT 
  (
  HostName
, Instance
  ) 
  VALUES 
  (
  Host
, Instance
  );