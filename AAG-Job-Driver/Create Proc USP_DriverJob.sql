USE [DriverJobDB]
GO

/****** Object:  StoredProcedure [dbo].[USP_DriverJob]    Script Date: 8/18/2015 9:08:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE .[dbo].[USP_DriverJob] 
AS
--	write message to DriverJobLog to record the job starting

INSERT INTO [DriverJobDB]..[DriverJobActionLog]
    ([Instance]
	,[JobName]
    ,[Status]
	,[TimeStamp]
    ,[ScheduledStart]
    ,[Message])
 VALUES
	(@@SERVERNAME
	,'DriverJob'
	,'Information'
	,GETDATE()
	,NULL
    ,'Driver Job started.');

DECLARE @TV_Jobs2Drive TABLE
(
 TV_Number INT IDENTITY(1,1) --Auto incrementing Identity column
,TV_Job2Drive VARCHAR(255) 
,TV_AG_Database VARCHAR(255)
,TV_WaitingOnJob VARCHAR(255)
,TV_DisabledFlag BIT
);

DECLARE @N INT; -- to remember the position in the outer loop 
DECLARE @Count INT; -- to remember the number of rows in the table var used in the outer loop

-- Vars to hold the currently selected values from the table used in the outer loop
DECLARE @Job2Drive VARCHAR(255); 
DECLARE @WaitingOnJob VARCHAR(255); 
DECLARE @AG_Database VARCHAR(255);
DECLARE @DisabledFlag BIT;

DECLARE @LastStartTime DATETIME; -- to remember the next start time for a job when calling USP_GetJobTimes

DECLARE @NextStartTime DATETIME; -- to remember the next start time for a job when calling USP_GetJobTimes

DECLARE @JobRunningStatus INT; -- to remember the running status flag for a job when calling USP_CheckIfJobIsRunning

DECLARE @AGPrimaryDBStatus INT;  -- to remember the AG primary\not-primary replica status for the AG database associated 
									-- with the job when calling USP_GetAGDatabaseReplicaStatus

DECLARE @ConflictingJobsCounter INT; -- to remember the number of conflicting jobs found in the DriverConflictingJobs table which drives
									 -- conflicting jobs inner loop 

DECLARE @TV2_ConflictingJobs TABLE -- create a table variable to drive the conflicting jobs inner loop to process the DriverJobConflictingJobs table
(
 TV2_Number INT IDENTITY(1,1) --Auto incrementing Identity column
,TV2_Job2Drive2 VARCHAR(255) 
,TV2_ConflictingJob VARCHAR(255)
);

DECLARE @N2 INT; -- to remember the position in the conflicting jobs inner loop 
DECLARE @Count2 INT; -- to remember the number of rows in the table var used in the conflicting jobs inner loop

-- Vars to hold the currently selected values from the conflicting jobs table var
DECLARE @Job2Drive2 VARCHAR(255); 
DECLARE @ConflictingJob VARCHAR(255);

DECLARE @JobRunningStatus2 INT;  -- to remember the running status flag for a job when calling USP_CheckIfJobIsRunning in the
									-- conflicting jobs inner loop

--Populate the TABLE variable 
INSERT INTO @TV_Jobs2Drive 
SELECT
 [Job2Drive]
,[AG_Database]
,[WaitingOnJob]
,[DisabledFlag]
FROM [DriverJobDB]..[DriverJobTable];

--Initialize the looper variable
SET @N = 1;

--Determine the number of rows in the Table
SELECT @Count=MAX(TV_Number) FROM  @TV_Jobs2Drive;


--Loop through until all row processing is done
WHILE @N <= @Count
BEGIN
    --Load current values from the Table in corresponding variables
    SELECT @Job2Drive = TV_Job2Drive FROM @TV_Jobs2Drive WHERE TV_Number = @N;
    SELECT @WaitingOnJob = TV_WaitingOnJob FROM @TV_Jobs2Drive WHERE TV_Number = @N;
	SELECT @AG_Database = TV_AG_Database FROM @TV_Jobs2Drive WHERE TV_Number = @N;
	SELECT @DisabledFlag = TV_DisabledFlag FROM @TV_Jobs2Drive WHERE TV_Number = @N;

	-- Process the current values

	--PRINT @N;
	--PRINT @Job2Drive;
	--PRINT @AG_Database;
	--PRINT @DisabledFlag;

	-- Get the last and next scheduled start time for the job currently being processed 
	EXEC DriverJobDB..USP_GetJobTimes @Job2Drive, @LastStartTime output, @NextStartTime output ;		

	-- If the job is flagged as disabled, then exit the outer loop
	IF @DisabledFlag = 1
	BEGIN
		--	write message to DriverJobLog
		INSERT INTO [DriverJobDB]..[DriverJobActionLog]
           ([Instance]
		   ,[JobName]
           ,[Status]
		   ,[TimeStamp]
		   ,[ScheduledStart]
           ,[Message])
		VALUES
           (@@SERVERNAME
		   ,@Job2Drive
           ,'Not Started'
		   ,GETDATE()
		   ,CONVERT(NVARCHAR(30), @NextStartTime, 100)
           ,'Job is flagged as disabled');

		   -- exit the loop
		   GOTO STOP_PROCESSING_CURRENT_JOB;
	END

	-- If the job being processed is already running, then exit the outer loop
	EXEC @JobRunningStatus = DriverJobDB..USP_CheckIfJobIsRunning @Job2Drive;

	IF @JobRunningStatus = 1
	BEGIN
		--	write message to DriverJobLog
		INSERT INTO [DriverJobDB]..[DriverJobActionLog]
			([Instance]
			,[JobName]
			,[Status]
			,[TimeStamp]
		   ,[ScheduledStart]
				,[Message])
			VALUES
			(@@SERVERNAME
			,@Job2Drive
			,'Not Started'
			,GETDATE()
			,CONVERT(NVARCHAR(30), @NextStartTime, 100)
			,'Job is currently running');

			-- update WaitingOnJob in table to annotate the job is waiting on itself
			UPDATE [DriverJobDB]..[DriverJobTable]
			SET [WaitingOnJob] = @Job2Drive
			   ,[LastStartTime] = CONVERT(NVARCHAR(30), @LastStartTime, 100) -- updated from system in case job was run outside of the JobDriver job
			WHERE [Job2Drive] = @Job2Drive ;

		   -- exit the loop
		   GOTO STOP_PROCESSING_CURRENT_JOB;
	END
	
	-- if this is an AG dependant job and the replica is not primary on this instance, then exit the outer loop
		IF @AG_Database IS NOT NULL
	BEGIN
		EXEC @AGPrimaryDBStatus = DriverJobDB..USP_GetAGDatabaseReplicaStatus  @AG_Database ;

		IF @AGPrimaryDBStatus = 2
		BEGIN
			--	write message to DriverJobLog
			INSERT INTO [DriverJobDB]..[DriverJobActionLog]
		    ([Instance]
			,[JobName]
		    ,[Status]
			,[TimeStamp]
		    ,[ScheduledStart]
		    ,[Message])
			 VALUES
	         (@@SERVERNAME
			 ,@Job2Drive
	         ,'Not Started'
			 ,GETDATE()
			 ,CONVERT(NVARCHAR(30), @NextStartTime, 100)
             ,'Job not started. This is not the primary replica for database: ' + @AG_Database);

		   -- exit the loop
		   GOTO STOP_PROCESSING_CURRENT_JOB;
		END

		-- Add a message to the log table that the database is not in an AG
		 
		IF @AGPrimaryDBStatus = 3
		BEGIN
			--	write message to DriverJobLog
			INSERT INTO [DriverJobDB]..[DriverJobActionLog]
		    ([Instance]
			,[JobName]
		    ,[Status]
			,[TimeStamp]
	 	    ,[ScheduledStart]
		    ,[Message])
			 VALUES
	         (@@SERVERNAME
			 ,@Job2Drive
	         ,'Warning'
			 ,GETDATE()
			 ,CONVERT(NVARCHAR(30), @NextStartTime, 100)
             ,'Database: ' + @AG_Database + ' is not included in an AG.');

		   -- don't exit, this should not stop processing of other jobs, just fall thru
		END
	END


	-- Process the DriverJobConflictingJobs child table  
	-- If a conflicting job is found to be running, then don't start this job and update the WaitingOnJob column in the DriverJobTable to 
	-- control future processing of the job

	-- get a count of the number of conflicting jobs for this job
	SET @ConflictingJobsCounter = (SELECT COUNT(*) FROM [DriverJobDB]..DriverJobConflictingJobs WHERE Job2Drive = @Job2Drive) ;

	-- if there are conflicting jobs, then create a table var to drive processing of the conflicting jobs - the table var drives
	-- the conflicting jobs inner loop
	If @ConflictingJobsCounter > 0
	BEGIN

		-- initialize the @TV2_ConflictingJobs Table Var
		DELETE FROM @TV2_ConflictingJobs;

		--Populate the TABLE variables 
		INSERT INTO @TV2_ConflictingJobs 
		SELECT
		 [Job2Drive]
		,[ConflictingJob]
		FROM [DriverJobDB]..[DriverJobConflictingJobs] ;

		--Initialize the looper variable
		SET @N2 = 1 ;

		--Determine the number of rows in the Table
		SELECT @Count2=MAX(TV2_Number) FROM @TV2_ConflictingJobs ;

		--Loop through until all row processing is done
		WHILE @N2 <= @Count2
		BEGIN
			--Load current values from the Table in corresponding variables
			SELECT @Job2Drive2 = TV2_Job2Drive2 FROM @TV2_ConflictingJobs WHERE TV2_Number = @N2;
			SELECT @ConflictingJob = TV2_ConflictingJob FROM @TV2_ConflictingJobs WHERE TV2_Number = @N2;

			--Process the current values

			--PRINT @N2;
			--PRINT @Job2Drive2;
			--PRINT  @ConflictingJob;

			-- findout if the currently selected conflicting job is running
			EXEC @JobRunningStatus2 = DriverJobDB..USP_CheckIfJobIsRunning @ConflictingJob ;

			-- if the conflicting job is running, then update the WaitingOnJob column in the DriverJobTable table with the name of the
			-- conflicting job (for future processing) and exit the outer loop (we are done with the current job being processed)
			IF @JobRunningStatus2 = 1
			BEGIN
				--	write message to DriverJobLog
				INSERT INTO [DriverJobDB]..[DriverJobActionLog]
				([Instance]
				,[JobName]
				,[Status]
				,[TimeStamp]
				,[ScheduledStart]
				,[Message])
				VALUES
				(@@SERVERNAME
				,@Job2Drive
				,'Not Started'
				,GETDATE()
				,CONVERT(NVARCHAR(30), @NextStartTime, 100)
				,'Job not started. Conflicting Job: ' + @ConflictingJob + ' is running. Job is postoned.');

				-- update WaitingOnJob in table to annotate the job is waiting on itself
				UPDATE [DriverJobDB]..[DriverJobTable]
				SET [WaitingOnJob] =  @ConflictingJob
				   ,[LastStartTime] = CONVERT(NVARCHAR(30), @LastStartTime, 100) -- updated from system in case job was run outside of the JobDriver job
				WHERE [Job2Drive] = @Job2Drive ;

				-- exit the outer loop
				GOTO STOP_PROCESSING_CURRENT_JOB;

			END

			-- if we got here, the current conflicting job is not running, we'll iterate the inner
			-- loop test the next conflicting job value
			
			--Increment loop counter
			SET @N2 = @N2 + 1;
		END
	END
		-- to get here, we have passed the control edits and had no conflicting jobs

		/**********************************************************************************************

		-- if the job has been waiting on another job, run it regardless of the scheduled time
		-- this is because its previous scheduled time was skipped because the conflicting job was running
		IF @WaitingOnJob IS NOT NULL 
		BEGIN

			EXEC msdb..sp_start_job @Job2Drive;

			-- update table to clear Waiting on Job AND last started
			UPDATE [DriverJobDB]..[DriverJobTable]
			SET [WaitingOnJob] =  NULL
				,[LastStartTime] = CONVERT(NVARCHAR(30), GETDATE(), 100)
			WHERE [Job2Drive] = @Job2Drive; 

			--	write message to DriverJobLog
			INSERT INTO [DriverJobDB]..[DriverJobActionLog]
				([Instance]
				,[JobName]
				,[Status]
				,[TimeStamp]
				,[ScheduledStart]
				,[Message])
			VALUES
				(@@SERVERNAME
				,@Job2Drive
				,'Started'
				,GETDATE()
				,CONVERT(NVARCHAR(30), @NextStartTime, 100)
				,'Job started. It was waiting on job: ' + @WaitingOnJob + ' which had finished.');

			-- exit the outer loop
			GOTO STOP_PROCESSING_CURRENT_JOB;
		END
		
		************************************************************************************************/

		-- if we got here, it is time to run the job if it is at or past its next scheduled run time

		IF  CURRENT_TIMESTAMP >= @NextStartTime
		BEGIN

			EXEC msdb..sp_start_job @Job2Drive;

			-- update DriverJobTable table to clear Waiting on Job flag AND record current time in PreviousStartTime column 
			UPDATE [DriverJobDB]..[DriverJobTable]
			SET [WaitingOnJob] =  NULL
				,[LastStartTime] = CONVERT(NVARCHAR(30), GETDATE(), 100)
			WHERE [Job2Drive] = @Job2Drive; 
			 
			--	write message to DriverJobLog
			INSERT INTO [DriverJobDB]..[DriverJobActionLog]
				([Instance]
				,[JobName]
				,[Status]
				,[TimeStamp]
				,[ScheduledStart]
				,[Message])
			VALUES
				(@@SERVERNAME
				,@Job2Drive
				,'Started'
				,GETDATE()
				,CONVERT(NVARCHAR(30), @NextStartTime, 100)
				,'Job started normally as scheduled.');


			-- exit the outer loop
			GOTO STOP_PROCESSING_CURRENT_JOB;
		END


		-- if we got here, the job passed all the criteria to run but has not yet reached its next scheduled run time and it was not waiting on
		-- a previously conflicting job

		--	write message to DriverJobLog
		INSERT INTO [DriverJobDB]..[DriverJobActionLog]
			([Instance]
			,[JobName]
			,[Status]
			,[TimeStamp]
			,[ScheduledStart]
			,[Message])
		VALUES
			(@@SERVERNAME
			,@Job2Drive
			,'Not Started'
			,GETDATE()
			,CONVERT(NVARCHAR(30), @NextStartTime, 100)
			,'Job was not started. It had not reached its next scheduled run time and was not waiting on a conflicting job.');

STOP_PROCESSING_CURRENT_JOB:

	--Increment loop counter 
	SET @N = @N + 1;

-- go back to top of outer loop to process the next job found in the DriverJobTable
END

-- all jobs found in the DriverJobTable have been processed

-- update log with ending timestamp

INSERT INTO [DriverJobDB]..[DriverJobActionLog]
    ([Instance]
	,[JobName]
    ,[Status]
	,[TimeStamp]
    ,[ScheduledStart]
    ,[Message])
 VALUES
	(@@SERVERNAME
	,'DriverJob'
	,'Information'
	,GETDATE()
	,NULL
    ,'Driver Job completed.');
	

GO

