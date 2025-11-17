MERGE DASI..Instances AS H
USING DASI..SQL_Inventory_Instance_List2 AS SII 
ON H.Instance = SII.Instance	

WHEN MATCHED THEN UPDATE 
  SET
  Instance = SII.Instance
, Hostname = SII.Hostname
, Edition2 = SII.Edition2
, Version_Build2 = SII.Version_Build2

WHEN NOT MATCHED THEN INSERT 
  (
  Instance
, Hostname
, Edition2
, Version_Build2
  ) 
  VALUES 
  (
  Instance
, Hostname
, Edition2
, Version_Build2
  );

