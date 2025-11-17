USE [DBA]
GO

/****** Object:  StoredProcedure [dbo].[FixOrphanedDbusersAllDatabases]    Script Date: 6/21/2016 5:32:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FixOrphanedDbusersAllDatabases]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	exec sp_foreachDB 
	  @Command1 = 'PRINT ''?''' 
    , @Command2 = 'EXEC DBA..FixOrphanedDBusers ?' 
    , @Command3 = 'PRINT '' ''' 
END

GO


