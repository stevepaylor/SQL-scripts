MERGE DASI..Hosts AS H
USING DASI..Active_SQL_Hosts AS ASH 
ON H.Hostname = ASH.Host	

WHEN MATCHED THEN UPDATE 
  SET
  Hostname = ASH.Host
, Physical_or_VC = ASH.Physical_or_VC
, Ping_Status2 = ASH.Ping
, RDC_able = ASH.RDC
, Host_IP = ASH.Host_IP
, Owning_Cluster = ASH.Owning_Cluster
, Is_Cluster_Node = ASH.Cluster_Node
, Cluster_IP = ASH.Cluster_IP
, Virtual_Server1 = ASH.Virtual_Server1
, VS1_IP = ASH.VS1_IP
, Virtual_Server2 = ASH.Virtual_Server2
, VS2_IP = ASH.VS2_IP
, Notes = ASH.Notes
, Notes2 = ASH.Notes2

WHEN NOT MATCHED THEN INSERT 
  (
  Hostname
, Physical_or_VC
, Ping_Status2
, RDC_able
, Host_IP
, Owning_Cluster
, Is_Cluster_Node
, Cluster_IP
, Virtual_Server1
, VS1_IP
, Virtual_Server2
, VS2_IP
, Notes
, Notes2
  ) 
  VALUES 
  (
  Host
, Physical_or_VC
, Ping
, RDC
, Host_IP
, Owning_Cluster
, Cluster_Node
, Cluster_IP
, Virtual_Server1
, VS1_IP
, Virtual_Server2
, VS2_IP
, Notes
, Notes2
  );