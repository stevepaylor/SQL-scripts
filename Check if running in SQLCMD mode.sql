:setvar DatabaseName "MyDatabase"
GO
IF ('$(DatabaseName)' = '$' + '(DatabaseName)')
    RAISERROR ('This script must be run in SQLCMD mode.', 20, 1) WITH LOG
GO
IF @@ERROR != 0
    SET NOEXEC ON -- If we got here, then make sure no further batches are executed
GO

PRINT 'You will not see this unless SQLCMD mode is on'
-- Rest of script goes here

GO
SET NOEXEC OFF
GO

sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d DBA -Q "