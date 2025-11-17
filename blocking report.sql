USE DBA
GO

IF EXISTS (
SELECT  * FROM dbo.sysobjects
WHERE xtype = ('U')  
  AND id = OBJECT_ID(N'dbo.BlockingAnalysisTemp1')
)
DROP TABLE BlockingAnalysisTemp1;
GO

SELECT DISTINCT 
  ProcessId AS 'BlockingId' 
, 0 AS 'BlockedId'
, CAST('Head Blocker' AS VARCHAR(50)) AS 'BlockedById'
, CollectionTime 
, WaitTime / 1000 AS 'WaitTimeSeconds'
, LastWaitType
, SqlString
, HostName 
, UserName
, DatabaseName

INTO BlockingAnalysisTemp1

FROM DBA.dbo.WhoIsBlocking

WHERE BlockedById LIKE 'Blocker%'

ORDER BY 
  ProcessId
, CollectionTime
, WaitTime / 1000 
, LastWaitType
, SqlString
, HostName 
, UserName
, DatabaseName

SELECT DISTINCT 
  a.ProcessId AS 'BlockedId'
, a.BlockedById
, a.CollectionTime 
, a.WaitTime / 1000 AS 'WaitTimeSeconds'
, a.LastWaitType
, a.SqlString AS 'Blocked SQL String' 
, b.SqlString AS 'Blocking SQL String' 
, a.HostName 
, a.UserName
, a.DatabaseName

FROM DBA.dbo.WhoIsBlocking a
JOIN DBA.dbo.BlockingAnalysisTemp1 b
ON CAST(a.BlockedById AS INT) = b.BlockingId  

WHERE a.BlockedById NOT LIKE 'Blocker%'
  AND a.BlockedById NOT LIKE 'Running trans%'
  --AND a.CollectionTime BETWEEN '12-16-2019 13:20' and '12-16-2019 13:30' -- Time Window of Issue
  --AND a.HostName NOT LIKE 'CMKTDB13%'

ORDER BY 
  a.CollectionTime   
, a.ProcessId 
, a.BlockedById
, a.WaitTime / 1000 
, a.LastWaitType
, a.SqlString
, b.SqlString
, a.HostName 
, a.UserName
, a.DatabaseName

GO