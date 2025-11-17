USE [DriverJobDB]
GO

/****** Object:  StoredProcedure [dbo].[USP_GetAGDatabaseReplicaStatus]    Script Date: 8/18/2015 9:08:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_GetAGDatabaseReplicaStatus] 
@DB2CONFIRM VARCHAR(50) 
AS

IF @DB2CONFIRM NOT IN (
SELECT
dbcs.database_name AS [DatabaseName]
FROM master.sys.availability_groups AS AG
LEFT OUTER JOIN master.sys.dm_hadr_availability_group_states as agstates
   ON AG.group_id = agstates.group_id
INNER JOIN master.sys.availability_replicas AS AR
   ON AG.group_id = AR.group_id
INNER JOIN master.sys.dm_hadr_availability_replica_states AS arstates
   ON AR.replica_id = arstates.replica_id AND arstates.is_local = 1
INNER JOIN master.sys.dm_hadr_database_replica_cluster_states AS dbcs
   ON arstates.replica_id = dbcs.replica_id
)
BEGIN
	--PRINT 'Database: ' + @DB2CONFIRM + ' is not included in an AG.';
	RETURN(3);
END
ELSE
BEGIN
	IF @DB2CONFIRM IN (
	SELECT DISTINCT
	dbcs.database_name AS [DatabaseName]
	FROM master.sys.availability_groups AS AG
	LEFT OUTER JOIN master.sys.dm_hadr_availability_group_states as agstates
		ON AG.group_id = agstates.group_id
	INNER JOIN master.sys.availability_replicas AS AR
		ON AG.group_id = AR.group_id
	INNER JOIN master.sys.dm_hadr_availability_replica_states AS arstates
		ON AR.replica_id = arstates.replica_id AND arstates.is_local = 1
	INNER JOIN master.sys.dm_hadr_database_replica_cluster_states AS dbcs
		ON arstates.replica_id = dbcs.replica_id
	LEFT OUTER JOIN master.sys.dm_hadr_database_replica_states AS dbrs
		ON dbcs.replica_id = dbrs.replica_id AND dbcs.group_database_id = dbrs.group_database_id
	WHERE ISNULL(arstates.role, 3) = 1 AND ISNULL(dbcs.is_database_joined, 0) = 1
	)
	BEGIN
		--PRINT 'This is the primary replica for database ' + @DB2CONFIRM;
		RETURN(1);
	END
	ELSE
	BEGIN
		--PRINT 'This is a secondary replica for database ' + @DB2CONFIRM;
		RETURN(2);
	END
END



GO

