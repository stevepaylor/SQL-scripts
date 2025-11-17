MERGE DASI..Instances AS I
USING DASI..Active_Instances_With_SA AS IWS 
ON I.Instance = IWS.Instance

WHEN MATCHED THEN UPDATE 
  SET
  Instance = IWS.Instance
, Env = IWS.Env
, Notes1 = IWS.Notes1
, Active3 = IWS.Active

WHEN NOT MATCHED THEN INSERT 
  (
  Instance
, Env
, Notes1
, Active3
  ) 
  VALUES 
  (
  Instance
, Env
, Notes1
, Active
  );

	--[Instance] [nvarchar](255) NULL,
	--[Env] [nvarchar](255) NULL,
	--[Notes1] [nvarchar](255) NULL,
	--[Active] [nvarchar](255) NULL


