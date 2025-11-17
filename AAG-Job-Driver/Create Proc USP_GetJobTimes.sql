USE [DriverJobDB]
GO

/****** Object:  StoredProcedure [dbo].[USP_GetJobTimes]    Script Date: 8/18/2015 9:09:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_GetJobTimes] 
@JobName VARCHAR(100),
@LastStartTime DATETIME OUTPUT,
@NextStartTime DATETIME OUTPUT 
AS

DECLARE @job_id BINARY(16);
SELECT @job_id = job_id FROM msdb.dbo.sysjobs WHERE (name = @JobName);

SET @LastStartTime = (
SELECT 
MAX(act.start_execution_date) AS LastStartTime
FROM msdb.dbo.sysjobs AS job
LEFT OUTER JOIN
[MSDB]..[sysjobactivity] AS act
ON act.job_id = job.job_id
WHERE job.name = @JobName
GROUP BY job.name, job.description, job.enabled) ;


SET @NextStartTime = (
SELECT 
MAX(act.next_scheduled_run_date) AS NextStartTime
FROM msdb.dbo.sysjobs AS job
LEFT OUTER JOIN
[MSDB]..[sysjobactivity] AS act
ON act.job_id = job.job_id
WHERE job.name = @JobName
GROUP BY job.name, job.description, job.enabled)


GO

