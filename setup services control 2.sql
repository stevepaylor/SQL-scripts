------DECLARE @RC INT;
DECLARE @AGENTstatus VARCHAR(20);

--------exec myproc @i output
------EXEC @RC = xp_servicecontrol N'querystate',N'SQLServerAGENT', @AGENTstatus output ;
------PRINT  @RC ;
------PRINT  @AGENTstatus ;
------GO


------EXEC @return_status = GetImmediateManager 2, @managerID output;
------if @return_status = 1
------  print N'Immediate manager not found!';
------else 
------  print N'ManagerID is ' + @managerID;
------go

------PRINT  @AGENTstatus ;
------GO

SET @AGENTstatus = EXEC xp_servicecontrol N'querystate',N'SQLServerAGENT';

IF (EXEC xp_servicecontrol N'querystate',N'SQLServerAGENT') = 'Stopped.'
BEGIN

	EXEC xp_servicecontrol N'START',N'SQLServerAGENT';
END ;

EXEC xp_servicecontrol N'querystate',N'SQLServerAGENT' ;

GO

EXEC xp_servicecontrol N'querystate',N'SQLServerAGENT';
Go

EXEC xp_servicecontrol N'START',N'SQLServerAGENT';
GO

EXEC xp_servicecontrol N'querystate',N'SQLServerAGENT';
Go
