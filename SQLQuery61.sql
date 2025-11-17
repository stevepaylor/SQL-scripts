USE [ReportServer]
GO

DECLARE @RC int;
DECLARE @ReportName nvarchar(850) = 'BingoAction';
DECLARE @ShowExecutionLog bit = 1;

-- TODO: Set parameter values here.

EXECUTE @RC = DBA.[dbo].[sp_HelpSSRSReport] 
   @ReportName
  ,@ShowExecutionLog
GO


