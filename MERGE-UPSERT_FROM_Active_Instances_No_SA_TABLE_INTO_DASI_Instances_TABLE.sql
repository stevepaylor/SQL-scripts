MERGE DASI..Instances AS I
USING DASI..Active_Instances_No_SA AS INS 
ON I.Instance = INS.Instance

WHEN MATCHED THEN UPDATE 
  SET
  Instance = INS.Instance
, Connection_Issue = INS.Connection_Issue
, POC = INS.POC
, Active2 = INS.Active

WHEN NOT MATCHED THEN INSERT 
  (
  Instance
, Connection_Issue
, POC
, Active2
  ) 
  VALUES 
  (
  Instance
, Connection_Issue
, POC
, Active
  );

	--[Instance] [varchar](255) NOT NULL,
	--[Connection_Issue] [varchar](255) NULL,
	--[POC] [varchar](255) NULL,
	--[Active] [varchar](255) NULL