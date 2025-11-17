USE [DriverJobDB]
GO

/****** Object:  StoredProcedure [dbo].[USP_GetReplicaStatus]    Script Date: 8/18/2015 9:09:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_GetReplicaStatus] 
@AG2CONFIRM VARCHAR(255) 
AS

IF (SELECT
    ars.role_desc
    FROM sys.dm_hadr_availability_replica_states ars
    INNER JOIN sys.availability_groups ag
    ON ars.group_id = ag.group_id
    WHERE ag.name = @AG2CONFIRM
    AND ars.is_local = 1) = 'PRIMARY'
BEGIN
	PRINT 'For AG: ' + @AG2CONFIRM + ' ' + @@SERVERNAME + ' is the primary replica.';
	RETURN(1);
END
ELSE
BEGIN
	PRINT 'For AG: ' + @AG2CONFIRM + ' ' + @@SERVERNAME + ' is a secondary replica.';
	RETURN(2);
END



GO

