MERGE DASI..Hosts AS H
USING DASI..ADM_Defunct_Host_Report AS ADM 
ON H.Hostname = ADM.Host	

WHEN MATCHED THEN UPDATE 
  SET
  Hostname = ADM.Host
, FQDN = ADM.FQDN
, Last_Logon_Time = ADM.Last_Logon_Time
, OS2 = ADM.OS
, OU = ADM.OU
, Notes3 = ADM.Notes
, Inactive_per_AD = 'Y';

--WHEN NOT MATCHED THEN RETURN 
--  (
--  Hostname
--, FQDN
--, Last_Logon_Time
--, OS2
--, OU
--, Notes3
--, Inactive_per_AD
--  ) 
--  VALUES 
--  (
--  Host
--, FQDN
--, Last_Logon_Time
--, OS
--, OU
--, Notes
--, 'Y'
--  );