MERGE DASI..Instances AS I
USING DASI..Active_Instances_With_SA AS II 
ON I.Instance = II.Instance

WHEN MATCHED THEN UPDATE 
  SET
  Instance = II.Instance
, Env2 = II.Env
, Active4 = II.Active

WHEN NOT MATCHED THEN INSERT 
  (
  Instance
, Env2
, Active4
  ) 
  VALUES 
  (
  Instance
, Env
, Active
  );

