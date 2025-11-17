MERGE DASI..Instances AS I
USING DASI..Instances_Accessible AS IA 
ON I.Instance = IA.Instance
WHEN MATCHED THEN UPDATE 
  SET
  Instance = IA.Instance
, LoginWithSA = IA.LoginWithSA
, SPAYLOR = IA.SPAYLOR
, BuiltinAdminWithSA = IA.BuiltinAdminWithSA
, ITAppsSQLadmin = IA.ITAppsSQLadmin
, SAPW = IA.SAPW
, ITAppsDBA = IA.ITAppsDBA
, SArenamed = IA.SArenamed
, DBAdmin = IA.DBAdmin

WHEN NOT MATCHED THEN INSERT 
  (
  Instance
, LoginWithSA
, SPAYLOR
, BuiltinAdminWithSA
, ITAppsSQLadmin
, SAPW
, ITAppsDBA
, SArenamed
, DBAdmin
  ) 
  VALUES 
  (
  Instance
, LoginWithSA
, SPAYLOR
, BuiltinAdminWithSA
, ITAppsSQLadmin
, SAPW
, ITAppsDBA
, SArenamed
, DBAdmin
  );