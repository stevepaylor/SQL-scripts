USE CMS
GO

SELECT DISTINCT
  HostName
, MachineType
, OS
, OS_ArchitectureType
, CPU
, MachineSerialNumber
, NumberOfProcs
, TotalCores
, NumberOfLogicalProcs
, IsClustered
, IP Address
, PhysicalHost
, ClusterID

FROM  DASI..Hosts

