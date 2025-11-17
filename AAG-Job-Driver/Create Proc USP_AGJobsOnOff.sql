USE [DriverJobDB]
GO

/****** Object:  StoredProcedure [dbo].[USP_AGJobsOnOff]    Script Date: 8/18/2015 9:07:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE .[dbo].[USP_AGJobsOnOff] 
AS

--	write message to AGJobsOnOffJobActionLog to record the job starting

INSERT INTO [DriverJobDB]..[AGJobsOnOffJobActionLog]
    ([Instance]
	,[JobName]
    ,[Status]
	,[TimeStamp]
    ,[Message])
 VALUES
	(@@SERVERNAME
	,'AGJobsOnOff'
	,'Information'
	,GETDATE()
    ,'AGJobsOnOff Job started.');

DECLARE @TV_Jobs2EnableDisable TABLE
(
 TV_Number INT IDENTITY(1,1) --Auto incrementing Identity column
,TV_Job2EnableDisable VARCHAR(255) 
,TV_AG VARCHAR(255)
,TV_DisabledFlag BIT
);

DECLARE @N INT; -- to remember the position in the loop 
DECLARE @Count INT; -- to remember the number of rows in the table var used in the loop

-- Vars to hold the currently selected values from the table used in the loop
DECLARE @Job2EnableDisable VARCHAR(255); 
DECLARE @AG VARCHAR(255);
DECLARE @DisabledFlag BIT;

DECLARE @ReplicaStatus INT;  -- to remember the AG primary\not-primary replica status for the AG database associated 
									-- with the job when calling USP_ConfrimAGdatabaseIsPrimary

DECLARE @DisabledJobName VARCHAR(255); -- used to rename job when it is disabled

DECLARE @TempJobName VARCHAR(255); -- used to process job when it has been renamed previously by the this job

DECLARE @TempJobDescription VARCHAR(255); -- used to construct job description for updating the job

--Populate the TABLE variable 
INSERT INTO @TV_Jobs2EnableDisable 
SELECT
[Job2Drive]
,[AG]
,[DisabledFlag]
FROM [DriverJobDB]..[DriverJobTable];

--Initialize the looper variable
SET @N = 1;

--Determine the number of rows in the Table
SELECT @Count=MAX(TV_Number) FROM  @TV_Jobs2EnableDisable;


--Loop through until all row processing is done
WHILE @N <= @Count
BEGIN
    --Load current values from the Table in corresponding variables
    SELECT @Job2EnableDisable = TV_Job2EnableDisable FROM @TV_Jobs2EnableDisable WHERE TV_Number = @N;
	SELECT @AG = TV_AG FROM @TV_Jobs2EnableDisable WHERE TV_Number = @N;
	SELECT @DisabledFlag = TV_DisabledFlag FROM @TV_Jobs2EnableDisable WHERE TV_Number = @N;

	-- Process the current values

	--PRINT @N;
	--PRINT @Job2EnableDisable;
	--PRINT @AG;
	--PRINT @DisabledFlag;


	SET @TempJobName = @Job2EnableDisable;
	SET @DisabledJobName = 'DISABLED_4_AG__' + @Job2EnableDisable;

	IF @Job2EnableDisable NOT IN (SELECT[name] FROM msdb.dbo.sysjobs)
	BEGIN 
		IF @DisabledJobName IN (SELECT[name] FROM msdb.dbo.sysjobs)
		BEGIN
			SET @TempJobName = @DisabledJobName;
		END
		ELSE
		BEGIN
			--	write message to AGJobsOnOffJobActionLog
			INSERT INTO [DriverJobDB]..[AGJobsOnOffJobActionLog]
			([Instance]
			,[JobName]
			,[Status]
			,[TimeStamp]
			,[Message])
			VALUES
           (@@SERVERNAME
		   ,@Job2EnableDisable
           ,'Error'
		   ,GETDATE()
           ,'ERROR ERROR ERROR Job: ' + @Job2EnableDisable + ' does not exits.');

		   -- exit the loop
		   GOTO STOP_PROCESSING_CURRENT_JOB; 
		END
	END


	-- If the job is flagged as disabled, then set it to disabled and exit the loop
	IF @DisabledFlag = 1
	BEGIN
		-- only add a log entry if the job is currently enabled
		IF (SELECT [enabled] FROM msdb.dbo.sysjobs WHERE [name] = @TempJobName) = 1
		BEGIN
			--	write message to AGJobsOnOffJobActionLog
			INSERT INTO [DriverJobDB]..[AGJobsOnOffJobActionLog]
				([Instance]
				,[JobName]
				,[Status]
				,[TimeStamp]
				,[Message])
			VALUES
				(@@SERVERNAME
				,@Job2EnableDisable
				,'Set Disabled'
				,GETDATE()
				,'Job is flagged as disabled in the DriverJobTable to override enabling. Disabling the job.');
		END
		
		-- Disable and rename the job

		EXEC msdb.dbo.sp_update_job
		@job_name = @TempJobName,
		@new_name = @DisabledJobName ,
		@description = N'Disabled - Disabled flag set in the DriverJobTable to over-ride enabling the job.',
		@enabled = 0 ;


		-- exit the loop
		GOTO STOP_PROCESSING_CURRENT_JOB; 
	END

		
	-- if this is an AG dependant job and the replica is not primary on this instance, then exit the loop
	IF @AG IS NOT NULL
	BEGIN
		EXEC @ReplicaStatus = [DriverJobDB]..[USP_GetReplicaStatus] @AG ;

		IF @ReplicaStatus = 1
		BEGIN
			-- only add a log entry if the job is currently disabled
			IF (SELECT [enabled] FROM msdb.dbo.sysjobs WHERE [name] = @TempJobName) = 0
			BEGIN
				--	write message to AGJobsOnOffJobActionLog
				INSERT INTO [DriverJobDB]..[AGJobsOnOffJobActionLog]
					([Instance]
					,[JobName]
					,[Status]
					,[TimeStamp]
					,[Message])
				VALUES
					(@@SERVERNAME
					,@Job2EnableDisable
				,'Set Enabled'
				,GETDATE()
				,'This is primary replica for AG: ' + @AG + ' Enabled the job.');
			END		

			-- Enable and rename the job

			SET @TempJobDescription = 'Enabled - This instance is currently the primary replica for AG: ' + @AG ;

			EXEC msdb.dbo.sp_update_job
			@job_name = @TempJobName,
			@new_name = @Job2EnableDisable ,
			@description = @TempJobDescription,
			@enabled = 1 ;

		   -- exit the loop
		   GOTO STOP_PROCESSING_CURRENT_JOB; 
		END
		ELSE
		BEGIN
			-- only add a log entry if the job is currently enabled
			IF (SELECT [enabled] FROM msdb.dbo.sysjobs WHERE [name] = @TempJobName) = 1
			BEGIN
				--	write message to AGJobsOnOffJobActionLog
				INSERT INTO [DriverJobDB]..[AGJobsOnOffJobActionLog]
					([Instance]
					,[JobName]
					,[Status]
					,[TimeStamp]
					,[Message])
				VALUES
					(@@SERVERNAME
					,@Job2EnableDisable
					,'Set Disabled'
					,GETDATE()
					,'This is not the primary replica for AG: ' + @AG + ' Disabled the job');
			END		

			-- Disable and rename the job

			SET @TempJobDescription = 'Disabled - This instance is currently a secondary replica for AG: ' + @AG ;

			EXEC msdb.dbo.sp_update_job
			@job_name = @TempJobName,
			@new_name = @DisabledJobName ,
			@description = @TempJobDescription,
			@enabled = 0 ;

		   -- exit the loop
		   GOTO STOP_PROCESSING_CURRENT_JOB; 
		END
	END

STOP_PROCESSING_CURRENT_JOB:

	--Increment loop counter 
	SET @N = @N + 1;

-- go back to top of loop to process the next job found in the DriverJobTable
END

-- all jobs found in the DriverJobTable have been processed

-- update log with ending timestamp

INSERT INTO [DriverJobDB]..[AGJobsOnOffJobActionLog]
    ([Instance]
	,[JobName]
    ,[Status]
	,[TimeStamp]
    ,[Message])
 VALUES
	(@@SERVERNAME
	,'AGJobsOnOff'
	,'Information'
	,GETDATE()
    ,'AGJobsOnOff Job completed.');
	

GO

