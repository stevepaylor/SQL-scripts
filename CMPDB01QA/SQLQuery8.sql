--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
:Connect SDSDB01QA

USE [master]
GO
ALTER AVAILABILITY GROUP [SDSDBAAG01QA]
MODIFY REPLICA ON N'SDSDB02QA' WITH (SEEDING_MODE = MANUAL)
GO

USE [master]
GO
ALTER AVAILABILITY GROUP [SDSDBAAG01QA]
ADD DATABASE [testlnw];
GO

:Connect SDSDB01QA

BACKUP DATABASE [testlnw] TO  DISK = N'\\SDSDB02QA\SQLBackup\testlnw.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO

:Connect SDSDB02QA

RESTORE DATABASE [testlnw] FROM  DISK = N'\\SDSDB02QA\SQLBackup\testlnw.bak' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
GO

:Connect SDSDB01QA

BACKUP LOG [testlnw] TO  DISK = N'\\SDSDB02QA\SQLBackup\testlnw.trn' WITH NOFORMAT, INIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5
GO

:Connect SDSDB02QA

RESTORE LOG [testlnw] FROM  DISK = N'\\SDSDB02QA\SQLBackup\testlnw.trn' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5
GO

:Connect SDSDB02QA

-- Wait for the replica to start communicating
begin try
declare @conn bit
declare @count int
declare @replica_id uniqueidentifier 
declare @group_id uniqueidentifier
set @conn = 0
set @count = 30 -- wait for 5 minutes 

if (serverproperty('IsHadrEnabled') = 1)
	and (isnull((select member_state from master.sys.dm_hadr_cluster_members where upper(member_name COLLATE Latin1_General_CI_AS) = upper(cast(serverproperty('ComputerNamePhysicalNetBIOS') as nvarchar(256)) COLLATE Latin1_General_CI_AS)), 0) <> 0)
	and (isnull((select state from master.sys.database_mirroring_endpoints), 1) = 0)
begin
    select @group_id = ags.group_id from master.sys.availability_groups as ags where name = N'SDSDBAAG01QA'
	select @replica_id = replicas.replica_id from master.sys.availability_replicas as replicas where upper(replicas.replica_server_name COLLATE Latin1_General_CI_AS) = upper(@@SERVERNAME COLLATE Latin1_General_CI_AS) and group_id = @group_id
	while @conn <> 1 and @count > 0
	begin
		set @conn = isnull((select connected_state from master.sys.dm_hadr_availability_replica_states as states where states.replica_id = @replica_id), 1)
		if @conn = 1
		begin
			-- exit loop when the replica is connected, or if the query cannot find the replica status
			break
		end
		waitfor delay '00:00:10'
		set @count = @count - 1
	end
end
end try
begin catch
	-- If the wait loop fails, do not stop execution of the alter database statement
end catch

:Connect SDSDB02QA

ALTER DATABASE [testlnw] SET HADR AVAILABILITY GROUP = [SDSDBAAG01QA];
GO

:Connect SDSDB01QA
SELECT
    dc.database_name,
    d.synchronization_health_desc,
    d.synchronization_state_desc,
    d.database_state_desc
FROM
    sys.dm_hadr_database_replica_states d
    JOIN sys.availability_databases_cluster dc ON d.group_database_id = dc.group_database_id
    AND d.is_local = 1

:Connect SDSDB02QA -U DBAdmin -P $QLisg00d4U
SELECT
    dc.database_name,
    d.synchronization_health_desc,
    d.synchronization_state_desc,
    d.database_state_desc
FROM
    sys.dm_hadr_database_replica_states d
    JOIN sys.availability_databases_cluster dc ON d.group_database_id = dc.group_database_id
    AND d.is_local = 1