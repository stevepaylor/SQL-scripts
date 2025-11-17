SELECT
    dc.database_name,
    d.synchronization_health_desc,
    d.synchronization_state_desc,
    d.database_state_desc
FROM
    sys.dm_hadr_database_replica_states d
    JOIN sys.availability_databases_cluster dc ON d.group_database_id = dc.group_database_id
    AND d.is_local = 1