--  Single use Ad-hoc plans are using 1.8 GB of procedure cache   
declare @showAdvOpts bigint;
select @showAdvOpts = cast(value_in_use as bigint) from sys.configurations where configuration_id = 518; -- show advanced options
if 0 = @showAdvOpts
begin
	exec sp_configure 'show advanced options', 1;
	reconfigure with override;
end;
exec sp_configure 'optimize for ad hoc workloads', 1;
reconfigure with override;
if 0 = @showAdvOpts
begin
	exec sp_configure 'show advanced options', 0;
	reconfigure with override;
end;

	reconfigure with override;


SELECT objtype AS [CacheType],
    COUNT_BIG(*) AS [Total Plans],
    SUM(CAST(size_in_bytes AS DECIMAL(18, 2))) / 1024 / 1024 AS [Total MBs],
    AVG(usecounts) AS [Avg Use Count],
    SUM(CAST((CASE WHEN usecounts = 1 THEN size_in_bytes
        ELSE 0
        END) AS DECIMAL(18, 2))) / 1024 / 1024 AS [Total MBs – USE Count 1],
    SUM(CASE WHEN usecounts = 1 THEN 1
        ELSE 0
        END) AS [Total Plans – USE Count 1]
FROM sys.dm_exec_cached_plans
GROUP BY objtype
ORDER BY [Total MBs – USE Count 1] DESC
GO

