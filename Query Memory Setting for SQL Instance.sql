---- To get the total physical memory installed on SQL Server
SELECT physical_memory_in_bytes / 1024 / 1024 AS [Physical_Memory_In_MB]
--,virtual_memory_in_bytes / 1024 / 1024 AS [Virtual_Memory_In_MB]
FROM [master].[sys].[dm_os_sys_info]

-- To get the total physical memory installed on SQL Server
SELECT [total_physical_memory_kb] / 1024 AS [Total_Physical_Memory_In_MB]
--,[available_page_file_kb] / 1024 AS [Available_Physical_Memory_In_MB]
--,[total_page_file_kb] / 1024 AS [Total_Page_File_In_MB]
--,[available_page_file_kb] / 1024 AS [Available_Page_File_MB]
--,[kernel_paged_pool_kb] / 1024 AS [Kernel_Paged_Pool_MB]
--,[kernel_nonpaged_pool_kb] / 1024 AS [Kernel_Nonpaged_Pool_MB]
--,[system_memory_state_desc] AS [System_Memory_State_Desc]
FROM [master].[sys].[dm_os_sys_memory]