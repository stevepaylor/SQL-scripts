--Identify which type of tempdb objects are consuming  space
--The following query helps you understand if user objects or version store or internal objects are the ones using the space in tempdb. According to this output, you can focus on the below sections.

SELECT
SUM (user_object_reserved_page_count)*8 as user_obj_kb,
SUM (internal_object_reserved_page_count)*8 as internal_obj_kb,
SUM (version_store_reserved_page_count)*8  as version_store_kb,
SUM (unallocated_extent_page_count)*8 as freespace_kb,
SUM (mixed_extent_page_count)*8 as mixedextent_kb
FROM sys.dm_db_file_space_usage

--If user_obj_kb is the highest consumer, then you that objects are being created by user queries like local or global temp tables or table variables. Also don’t forget to check if there are any permanent 
--tables created in TempDB. Very rare, but I’ve seen this happening.
--If version_store_kb is the highest consumer, then it means that the version store is growing faster than the clean up. Most likely there are long running transactions or open transaction (Sleeping state), 
--which are preventing the cleanup and hence not release tempdb space back.

