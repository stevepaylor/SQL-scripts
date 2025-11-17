set nocount on
CREATE TABLE #ServicesStatus
( 
myid int identity(1,1),
serverName nvarchar(100) default @@serverName,
serviceName varchar(100),
Status varchar(50),
checkdatetime datetime default (getdate())
)
INSERT #ServicesStatus (Status)
EXEC xp_servicecontrol N'QUERYSTATE',N'MSSQLServer'
update #ServicesStatus set serviceName = 'MSSQLServer' where myid = @@identity
INSERT #ServicesStatus (Status)
EXEC xp_servicecontrol N'QUERYSTATE',N'SQLServerAGENT'
update #ServicesStatus set serviceName = 'SQLServerAGENT' where myid = @@identity
INSERT #ServicesStatus (Status)
EXEC xp_servicecontrol N'QUERYSTATE',N'msdtc';
update #ServicesStatus set serviceName = 'msdtc' where myid = @@identity;
INSERT #ServicesStatus (Status)
EXEC xp_servicecontrol N'QUERYSTATE',N'sqlbrowser'
update #ServicesStatus set serviceName = 'sqlbrowser' where myid = @@identity
select * from #ServicesStatus 
--select char(13)
--select char(13)

----GRANT EXECUTE ON xp_servicecontrol TO [VIEJAS\spaylor] ;

-- if the Agent service is running, stop it otherwise skip over to start it
IF (SELECT [status] FROM #ServicesStatus WHERE [serviceName] = 'SQLServerAGENT') = 'Running.'
BEGIN
	PRINT 'SQLServerAGENT service is Running. Stopping the service to restart it.' ;
	EXEC xp_servicecontrol N'STOP',N'SQLServerAGENT' ;
END

-- Unconditionally start the Agent service
PRINT 'Starting or Re-Starting SQLServerAGENT service.' ;

EXEC xp_servicecontrol N'START',N'SQLServerAGENT' ;

drop table #ServicesStatus


EXEC xp_servicecontrol N'QUERYSTATE',N'MSSQLServer'

---- To allow advanced options to be changed.
--EXEC sp_configure 'show advanced options', 1
--RECONFIGURE
--GO

---- Enable the xp_cmdshell procedure
--EXEC sp_configure 'xp_cmdshell', 1
--RECONFIGURE
--GO

--GRANT EXECUTE ON xp_cmdshell TO [VIEJAS\spaylor] ;
--GRANT EXECUTE ON xp_cmdshell TO [VIEJAS\SQLService1] ;

--EXEC xp_cmdshell 'whoami.exe' ;
----xp_cmdshell 'whoami.exe'