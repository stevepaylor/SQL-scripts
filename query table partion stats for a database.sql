SELECT *
FROM sys.dm_db_partition_stats
WHERE object_id = OBJECT_ID('CMP13');