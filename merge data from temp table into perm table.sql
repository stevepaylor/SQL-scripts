MERGE DASI..Hosts AS H
USING DASI..ping_results_to_load2 AS P 
ON H.HostName = LTRIM(RTRIM(P.F1))

WHEN MATCHED THEN UPDATE 
  SET
  H.HostName = LTRIM(RTRIM(P.F1))
, H.IP_From_Ping = LTRIM(RTRIM(P.F2))
, H.Ping_Status = LTRIM(RTRIM(P.F3))

WHEN NOT MATCHED THEN INSERT 
  (
  HostName
, IP_From_Ping 
, Ping_Status

  ) 
  VALUES 
  (
  LTRIM(RTRIM(P.F1))
, LTRIM(RTRIM(P.F2))
, LTRIM(RTRIM(P.F3))
  );