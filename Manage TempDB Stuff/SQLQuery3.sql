--Tempdb and the Version Store
--The version stored (SQL 2005 onwards) is a collection of objects that are used when Snapshot Isolation or Read-Committed Snapshot 
--Isolation (RCSI) or online index rebuild etc. are used in a database.

--Version store contains the committed rows which is how a SELECT operation does not get blocked when another UPDATE/DELETE is 
--operating on the same row, because the SELECT reads the row from the version store, instead of the actual base table. When you 
--enable this, the row has to be stored somewhere and tempdb happens to be the place. A row is maintained in the version store when 
--there are transactions operating on that row in questions. When the transaction is committed, the row is cleaned up from the 
--version store tables.

--You can check the version store using the DMV sys.dm_tran_version_store

--At times, when there are long running transactions or orphaned transactions, you might notice tempdb growth due to the version 
--store.
--You can use the following query to find the oldest transactions that are active and using row versioning.

SELECT top 5 a.session_id, a.transaction_id, a.transaction_sequence_num, a.elapsed_time_seconds,
b.program_name, b.open_tran, b.status
FROM sys.dm_tran_active_snapshot_database_transactions a
join sys.sysprocesses b
on a.session_id = b.spid
ORDER BY elapsed_time_seconds DESC