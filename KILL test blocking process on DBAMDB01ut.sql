-- Get the blocking SPID ONLY when it is from FRX01, the Crystal Enterpise Server (172.30.1.81) and it is running against the "Prod" database
DECLARE @BLOCKING_SPID AS INT;
SET @BLOCKING_SPID =
(
SELECT
MIN(wt.blocking_session_id) -- MIN insures we only get one value returned - if there are others, they will be killed the next time the alert happens - which will be immediately 

FROM sys.dm_tran_locks AS tl
INNER JOIN sys.databases db 
ON db.database_id = tl.resource_database_id

INNER JOIN sys.dm_os_waiting_tasks AS wt 
ON tl.lock_owner_address =wt.resource_address

INNER JOIN sys.dm_exec_connections ec2 
ON ec2.session_id =wt.blocking_session_id

WHERE wt.blocking_session_id IS NOT NULL
  AND db.name = 'DASI'
  --AND ec2.client_net_address = '<local machine>'
  AND ec2.client_net_address = '172.30.1.81'
  AND wt.session_id <> wt.blocking_session_id -- don't kill it if is just a CXPACKET wait on itself
);
--PRINT @BLOCKING_SPID;

DECLARE @SQL VARCHAR(MAX);
SET @SQL = '';
SELECT @SQL = @SQL + 'Kill ' + Convert(varchar, @BLOCKING_SPID) + ';'

--Kill the Processes
EXEC(@SQL);