SELECT Drive
    ,   TotalSpaceGB
    ,   FreeSpaceGB
    ,   PctFree
    ,   PctFreeExact
    FROM
    (SELECT DISTINCT
        SUBSTRING(dovs.volume_mount_point, 1, 10) AS Drive
    ,   CONVERT(INT, dovs.total_bytes / 1024.0 / 1024.0 / 1024.0) AS TotalSpaceGB
    ,   CONVERT(INT, dovs.available_bytes / 1048576.0) / 1024 AS FreeSpaceGB
    ,   CAST(ROUND(( CONVERT(FLOAT, dovs.available_bytes / 1048576.0) / CONVERT(FLOAT, dovs.total_bytes / 1024.0 /
                         1024.0) * 100 ), 2) AS NVARCHAR(50)) + '%' AS PctFree
    ,   CONVERT(FLOAT, dovs.available_bytes / 1048576.0) / CONVERT(FLOAT, dovs.total_bytes / 1024.0 / 1024.0) * 100 AS PctFreeExact                
    FROM    sys.master_files AS mf
    CROSS APPLY sys.dm_os_volume_stats(mf.database_id, mf.file_id) AS dovs) AS DE