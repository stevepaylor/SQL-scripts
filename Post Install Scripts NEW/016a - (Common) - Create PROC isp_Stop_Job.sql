----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 45 $
----------------------------------------------------------------------------------------------------

USE [DBA]
GO
-- Create required table
IF OBJECT_ID('StopJobHistory') IS NULL
	CREATE TABLE StopJobHistory
	(
           JobName           VARCHAR (300)   NOT NULL,
           JobStartDate      DATETIME        NOT NULL,
           JobStopDate       DATETIME        NOT NULL,
           MinutesToRun      INT             NOT NULL,
           MinutesRan        INT             NOT NULL
           CONSTRAINT PK_StopJobHistory PRIMARY KEY CLUSTERED 
           (
              JobName,
              JobStartDate
           )
        )
GO






USE [DBA]
GO
/****** Object:  StoredProcedure [dbo].[isp_Stop_Job]    Script Date: 04/21/2010 17:57:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[isp_Stop_Job]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[isp_Stop_Job]



USE [DBA]
GO
/****** Object:  StoredProcedure [dbo].[isp_Stop_Job]    Script Date: 04/21/2010 17:57:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------------------------------------------------------
-- OBJECT NAME        : isp_Stop_Job
--
-- AUTHOR             : Ban Keriakos
--
-- INPUTS             : @JobName - The name of the job
--                      @MinutesToRun - The number of minutes to run the job before it is stopped
--
-- OUTPUTS            : None
--
-- DEPENDENCIES       : StopJobHistory, msdb.dbo.sysjobs, master.dbo.xp_sqlagent_enum_jobs
--
-- DESCRIPTION        : isp_Stop_Job
--
--                      EXEC isp_Stop_Job
--                           @JobName = 'DBA - Defragment Indexes', 
--                           @MinutesToRun = 1800
--
-- HISTORY            : Apr 1, 2010 - Initial version.
--
------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[isp_Stop_Job]
(
   @JobName             VARCHAR(300),
   @MinutesToRun        INT
)

AS

SET NOCOUNT ON

BEGIN

   DECLARE @JobID              UNIQUEIDENTIFIER
   DECLARE @JobStartDate       DATETIME
   DECLARE @JobStopDate        DATETIME
   DECLARE @RunningStatus      TINYINT
   DECLARE @MinutesRan         INT

   -- Get the job id
   SELECT  @JobID = job_id
   FROM    msdb.dbo.sysjobs
   WHERE   name = @JobName

   DECLARE @XP_Results TABLE (JobId                 UNIQUEIDENTIFIER   NOT NULL,
                              LastRunDate           INT                NOT NULL,
                              LastRunTime           INT                NOT NULL,
                              NextRunDate           INT                NOT NULL,
                              NextRunTime           INT                NOT NULL,
                              NextRunScheduleId     INT                NOT NULL,
                              RequestedToRun        INT                NOT NULL,
                              RequestSource         INT                NOT NULL,
                              RequestSourceId       SYSNAME            NULL,
                              Running               INT                NOT NULL,
                              CurrentStep           INT                NOT NULL,
                              CurrentRetryAttempt   INT                NOT NULL,
                              JobState              INT                NOT NULL)

   -- Get the job run time params
   INSERT    INTO @XP_Results
   EXECUTE   master.dbo.xp_sqlagent_enum_jobs 1, suser_sname

   -- Check if the job is currently running
   SELECT    @RunningStatus = Running 
   FROM      @XP_Results 
   WHERE     JobId = @JobID

   SELECT    @JobStartDate = start_execution_date
   FROM      msdb.dbo.sysjobactivity
   WHERE     job_id = @JobID

   SELECT    @JobStopDate = GETDATE()

   IF @RunningStatus = 1

   BEGIN

      SELECT   @MinutesRan = DATEDIFF (minute, @JobStartDate, GETDATE()) 

      PRINT    'Job has been running for: ' + CAST (@MinutesRan AS VARCHAR)

      IF @MinutesRan >= @MinutesToRun

      BEGIN

         EXEC  msdb.dbo.sp_stop_job @job_id = @JobID

         PRINT 'Job stopped'

        -- Log some information into a history table
        INSERT INTO StopJobHistory (JobName, JobStartDate, JobStopDate, MinutesToRun, MinutesRan)
        VALUES (@JobName, @JobStartDate, @JobStopDate, @MinutesToRun, @MinutesRan)

        -- Send an E-Mail

				DECLARE @subject_text VARCHAR(300) ;
				SET @subject_text = 'Alert!!! DBA - Stop Job -- ' + @@SERVERNAME ;

        DECLARE @body_text   VARCHAR (300)
        SELECT  @body_text = 'The following job(s) have been stopped on ' + @@SERVERNAME + ':' + CHAR(13) + CHAR (10)

        EXEC msdb.dbo.sp_send_dbmail
           @recipients = 'spaylor@viejas.com',
           @copy_recipients = '',
           @subject = @subject_text,
           @body = @body_text,
           @query = 'SELECT   SUBSTRING (JobName, 1, 36) AS JobName, JobStartDate, JobStopDate, MinutesToRun, MinutesRan
                     FROM     DBA.dbo.StopJobHistory
                     WHERE    JobStopDate > GETDATE() - 1
                     ORDER BY JobStopDate DESC'

      END

   END

END