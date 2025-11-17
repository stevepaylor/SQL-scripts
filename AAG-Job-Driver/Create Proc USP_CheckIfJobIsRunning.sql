USE [DriverJobDB]
GO

/****** Object:  StoredProcedure [dbo].[USP_CheckIfJobIsRunning]    Script Date: 8/18/2015 9:08:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_CheckIfJobIsRunning] 
@JobName SYSNAME 
AS

IF NOT EXISTS(	
		select 1
		from msdb.dbo.sysjobs_view job 
		inner join msdb.dbo.sysjobactivity activity on job.job_id = activity.job_id
		where 
			activity.run_Requested_date is not null 
		and activity.stop_execution_date is null 
		and job.name = @JobName
		)
BEGIN
	RETURN(0);
END
ELSE
BEGIN
	PRINT 'Job: ' + @JobName + ' is currently running.';
	RETURN(1);
END
GO

