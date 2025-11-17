--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
:Connect GPPSDB01APR

USE [master]

GO

ALTER AVAILABILITY GROUP [GPPS01AG01PR]
MODIFY REPLICA ON N'GPPSDB01BPR' WITH (SEEDING_MODE = MANUAL)

GO

USE [master]

GO

ALTER AVAILABILITY GROUP [GPPS01AG01PR]
ADD DATABASE [BackOffice];

GO

USE [master]

GO

ALTER AVAILABILITY GROUP [GPPS01AG01PR]
ADD DATABASE [GP.AccessControl];

GO

USE [master]

GO

ALTER AVAILABILITY GROUP [GPPS01AG01PR]
ADD DATABASE [GP.Client];

GO

USE [master]

GO

ALTER AVAILABILITY GROUP [GPPS01AG01PR]
ADD DATABASE [GP.Logs];

GO

USE [master]

GO

ALTER AVAILABILITY GROUP [GPPS01AG01PR]
ADD DATABASE [GP.Reporting];

GO

USE [master]

GO

ALTER AVAILABILITY GROUP [GPPS01AG01PR]
ADD DATABASE [gp_kiosk_server];

GO

:Connect GPPSDB01APR

BACKUP DATABASE [BackOffice] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\BackOffice.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE DATABASE [BackOffice] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\BackOffice.bak' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01APR

BACKUP LOG [BackOffice] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\BackOffice.trn' WITH NOFORMAT, INIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE LOG [BackOffice] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\BackOffice.trn' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01BPR


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
    select @group_id = ags.group_id from master.sys.availability_groups as ags where name = N'GPPS01AG01PR'
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
ALTER DATABASE [BackOffice] SET HADR AVAILABILITY GROUP = [GPPS01AG01PR];

GO

:Connect GPPSDB01APR

BACKUP DATABASE [GP.AccessControl] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.AccessControl.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE DATABASE [GP.AccessControl] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.AccessControl.bak' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01APR

BACKUP LOG [GP.AccessControl] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.AccessControl.trn' WITH NOFORMAT, INIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE LOG [GP.AccessControl] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.AccessControl.trn' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01BPR


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
    select @group_id = ags.group_id from master.sys.availability_groups as ags where name = N'GPPS01AG01PR'
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
ALTER DATABASE [GP.AccessControl] SET HADR AVAILABILITY GROUP = [GPPS01AG01PR];

GO

:Connect GPPSDB01APR

BACKUP DATABASE [GP.Client] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Client.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE DATABASE [GP.Client] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Client.bak' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01APR

BACKUP LOG [GP.Client] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Client.trn' WITH NOFORMAT, INIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE LOG [GP.Client] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Client.trn' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01BPR


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
    select @group_id = ags.group_id from master.sys.availability_groups as ags where name = N'GPPS01AG01PR'
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
ALTER DATABASE [GP.Client] SET HADR AVAILABILITY GROUP = [GPPS01AG01PR];

GO

:Connect GPPSDB01APR

BACKUP DATABASE [GP.Logs] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Logs.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE DATABASE [GP.Logs] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Logs.bak' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01APR

BACKUP LOG [GP.Logs] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Logs.trn' WITH NOFORMAT, INIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE LOG [GP.Logs] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Logs.trn' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01BPR


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
    select @group_id = ags.group_id from master.sys.availability_groups as ags where name = N'GPPS01AG01PR'
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
ALTER DATABASE [GP.Logs] SET HADR AVAILABILITY GROUP = [GPPS01AG01PR];

GO

:Connect GPPSDB01APR

BACKUP DATABASE [GP.Reporting] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Reporting.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE DATABASE [GP.Reporting] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Reporting.bak' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01APR

BACKUP LOG [GP.Reporting] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Reporting.trn' WITH NOFORMAT, INIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE LOG [GP.Reporting] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\GP.Reporting.trn' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01BPR


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
    select @group_id = ags.group_id from master.sys.availability_groups as ags where name = N'GPPS01AG01PR'
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
ALTER DATABASE [GP.Reporting] SET HADR AVAILABILITY GROUP = [GPPS01AG01PR];

GO

:Connect GPPSDB01APR

BACKUP DATABASE [gp_kiosk_server] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\gp_kiosk_server.bak' WITH  COPY_ONLY, FORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE DATABASE [gp_kiosk_server] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\gp_kiosk_server.bak' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01APR

BACKUP LOG [gp_kiosk_server] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\gp_kiosk_server.trn' WITH NOFORMAT, INIT, NOSKIP, REWIND, NOUNLOAD, COMPRESSION,  STATS = 5

GO

:Connect GPPSDB01BPR

RESTORE LOG [gp_kiosk_server] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\gp_kiosk_server.trn' WITH  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

:Connect GPPSDB01BPR


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
    select @group_id = ags.group_id from master.sys.availability_groups as ags where name = N'GPPS01AG01PR'
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
ALTER DATABASE [gp_kiosk_server] SET HADR AVAILABILITY GROUP = [GPPS01AG01PR];

GO


GO


