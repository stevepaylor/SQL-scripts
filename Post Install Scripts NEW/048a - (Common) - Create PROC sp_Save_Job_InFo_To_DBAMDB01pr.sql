
--USE [DBA]
--GO

--/****** Object:  Table [dbo].[Disabled_Job_Allowed_Control]    Script Date: 2/15/2024 1:50:37 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--ALTER TABLE [dbo].[Disabled_Job_Allowed_Control]
--ADD [Notes] [varchar](200) NULL


USE [DBA]
GO

-- Only drop the table if it needs to be started over from scratch

--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Disabled_Job_Allowed_Control]') AND type in (N'U'))
--DROP TABLE [dbo].[Disabled_Job_Allowed_Control]
--GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_Save_Job_InFo_To_DBAMDB01pr') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_Save_Job_InFo_To_DBAMDB01pr
GO

CREATE PROCEDURE dbo.sp_Save_Job_InFo_To_DBAMDB01pr
AS
BEGIN
	SET NOCOUNT ON ;
	--=============================================================================
	-- Author:		Steve Paylor
	-- Create date: 01/03/24
	-- Description:	
	-- This proc runs via a job on a regular hourly schedule on all SQL server instances.  It updates a remote,
	-- centalized table on the DBAMDB01PR server.  That table is, in turn, used to send out alerts on jobs on 
	-- all instances that are disabled.
	--==============================================================================

	--------------------------------------------------------------------------------------
	-- Each instance will have the DBA.[dbo].[Disabled_Job_Allowed_Control] table.  Its 
	-- purpose to to provide a control mechanism for setting any jobs to disabled.  This 
	-- table is initially populated with just the job names found on the instance.  Then,
	-- whenever a new job is created, it will be added to the table.  The first time a job 
	-- is loaded, later, down stream, if it found to already be disabled, then it will be
	-- assumed that the job allowed to be disabled and the appropriate values will be set.
	---------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------
	-- The first time this job is run on the instance, if the table does not already exist, 
	-- it will be created.
	----------------------------------------------------------------------------------------
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Disabled_Job_Allowed_Control]') AND type in (N'U'))
	BEGIN
		SET ANSI_NULLS ON
		SET QUOTED_IDENTIFIER ON

		CREATE TABLE DBA.[dbo].[Disabled_Job_Allowed_Control](
		[JobName] [varchar](100) NOT NULL,
		[AllowJobToBeDisabled] [char](1) NULL,
		[WhoSetAllowed] [varchar](100) NULL,
		[SetAllowedDTM] [datetime] NULL,
		[Notes] [varchar](200) NULL,
		CONSTRAINT [PK_Disabled_Job_Allowed_Control] PRIMARY KEY CLUSTERED 
		(
		[JobName] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY] ;
	END

	-----------------------------------------------------------------------------------------------------------
	-- Find any new jobs on the instance and add them to the local control table with default initial values
	-----------------------------------------------------------------------------------------------------------
	INSERT INTO DBA.dbo.Disabled_Job_Allowed_Control
	SELECT 
	  sysjobs.[name] as JobName
	-- Assume on initial load that if a job is disabled, it is allowed to be disabled 
	-- audit will veryify with centralized table on DBAMDB01PR
	, CASE
		WHEN sysjobs.[enabled] = 0 THEN 'Y' ELSE 'N' 
	  END										 
	  as AllowJobToBeDisabled

	, CASE
		WHEN sysjobs.[enabled] = 0 THEN 'Unknown' ELSE NULL
	  END										 
	  as WhoSetAllowed

	, CASE
		WHEN sysjobs.[enabled] = 0 THEN CURRENT_TIMESTAMP ELSE NULL
	  END	 
	  as SetAllowed_DTTM

	, CASE
		WHEN sysjobs.[enabled] = 0 THEN 'Found disabled on initial load' ELSE NULL
	  END 
	  as Notes

	FROM msdb.dbo.sysjobs sysjobs

	-- limits selection to new jobs only
	WHERE sysjobs.[name] NOT IN (SELECT JobName FROM DBA.dbo.Disabled_Job_Allowed_Control) ;

	-----------------------------------------------------------------------------------------------------------
	-- If Allow to be disabled flag was manually set in the control table and a datetime was left out, set it
	-- to the current datetime
	-----------------------------------------------------------------------------------------------------------
	UPDATE DBA.dbo.Disabled_Job_Allowed_Control
	SET SetAllowedDTM = CURRENT_TIMESTAMP 
	WHERE SetAllowedDTM IS NULL
	  AND ISNULL(AllowJobToBeDisabled,'N') = 'Y'
	  --AND WhoSetAllowed IS NOT NULL

	-----------------------------------------------------------------------------------------------------------
	-- If Allow to be disabled flag is no, clear the who set value and the date set value
	-----------------------------------------------------------------------------------------------------------
	UPDATE DBA.dbo.Disabled_Job_Allowed_Control
	SET 
	  WhoSetAllowed = NULL
	, SetAllowedDTM = NULL
	, Notes = NULL

	WHERE ISNULL(AllowJobToBeDisabled,'N') = 'N'

	-----------------------------------------------------------------------------------------------------------
	-- If Allow to be disabled flag was manually set on in the control table and a who set was left out, set it
	-- to NULL
	-----------------------------------------------------------------------------------------------------------
	UPDATE DBA.dbo.Disabled_Job_Allowed_Control
	SET WhoSetAllowed = 'Unknown'
	WHERE (WhoSetAllowed IN ('Initial Load') OR WhoSetAllowed IS NULL)
	  AND ISNULL(AllowJobToBeDisabled,'N') = 'Y'

	UPDATE DBA.dbo.Disabled_Job_Allowed_Control
	SET SetAllowedDTM = CURRENT_TIMESTAMP
	WHERE ISNULL(AllowJobToBeDisabled,'N') = 'Y'
	  AND SetAllowedDTM IS NULL


	-----------------------------------------------------------------------------------------------------------
	-- Find any new jobs on the instance and add them to the centralized table.
	-----------------------------------------------------------------------------------------------------------

	INSERT INTO DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized
	SELECT 
	  @@SERVERNAME as InstanceName
	, sysjobs.[name] as JobName
	, sysjobs.job_id as JobID
	, sysjobs.[enabled] as [Enabled]
	, CURRENT_TIMESTAMP as LastChangedDTM
	, CURRENT_TIMESTAMP as LastCheckedDTM
	, 'N' as AllowDisabled
	, NULL as AllowDisabledSetDTM
	, NULL as AllowDisabledSetBy
	, NULL as [DisabledNotes]

	FROM msdb.dbo.sysjobs sysjobs

	-- limits selection to new jobs only
	WHERE LTRIM(@@SERVERNAME) + ' : ' +   LTRIM(sysjobs.[NAME]) NOT IN 
	(SELECT LTRIM(InstanceName) + ' : ' + LTRIM(JobName) FROM DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized) ;

	-----------------------------------------------------------------------------------------------------------
	-- Delete any jobs in the centralized table that no longer exist on the instance
	-----------------------------------------------------------------------------------------------------------
	DELETE central
	FROM DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized central
	LEFT OUTER JOIN msdb.dbo.sysjobs sysjobs
	ON central.JobName = sysjobs.[name]
	WHERE central.InstanceName = @@SERVERNAME
	AND sysjobs.[name] IS NULL ;

	-----------------------------------------------------------------------------------------------------------
	-- Update any jobs in the centralized from sysjobs
	-----------------------------------------------------------------------------------------------------------

	UPDATE central
	SET 
	  central.JobID = sysjobs.job_id  
	, central.[Enabled] = sysjobs.[enabled]
	, central.LastChangedDTM = CURRENT_TIMESTAMP
	
	FROM DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized central
	
	JOIN msdb.dbo.sysjobs sysjobs
	ON central.JobName = sysjobs.[name]
	AND central.InstanceName = @@SERVERNAME

	WHERE central.JobID <> sysjobs.job_id
	   OR central.[Enabled] <> sysjobs.[enabled] 
	   OR central.LastChangedDTM < CURRENT_TIMESTAMP
	   OR central.LastChangedDTM IS NULL
	
	-----------------------------------------------------------------------------------------------------------
	-- Update any jobs in the centralized from the local control table
	-----------------------------------------------------------------------------------------------------------

	UPDATE central
	SET 
	  central.LastChangedDTM = CURRENT_TIMESTAMP
	-- central.LastCheckedDTM -- updated below in next step
	, central.AllowDisabled = control.AllowJobToBeDisabled
	, central.AllowDisabledSetDTM = control.SetAllowedDTM
	, central.AllowDisabledSetBy = control.WhoSetAllowed
	, central.DisabledNotes = control.Notes
	
	FROM DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized central
	
	JOIN DBA.dbo.Disabled_Job_Allowed_Control control
	ON central.InstanceName = @@SERVERNAME
	AND central.JobName = control.JobName

	WHERE central.AllowDisabledSetDTM IS NULL 
	   OR central.AllowDisabledSetDTM < control.SetAllowedDTM
	   OR central.LastChangedDTM IS NULL 
	   OR central.LastCheckedDTM IS NULL
	   OR ISNULL(central.AllowDisabledSetBy, ' ') <> ISNULL(control.WhoSetAllowed, ' ') -- value manually set in the control table over-rides
	   Or ISNULL(central.DisabledNotes, ' ') <> ISNULL(control.Notes, ' ')
	
	-----------------------------------------------------------------------------------------------------------
	-- Clear Allow fields when AllowDisabled is No
	-----------------------------------------------------------------------------------------------------------

	UPDATE central
	SET
	  central.[AllowDisabled] = 'N'
	, central.[AllowDisabledSetDTM] = NULL
	, central.[AllowDisabledSetBy] = NULL
	, central.[DisabledNotes] = NULLIF(control.Notes, ' ')

	FROM DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized central
	
	JOIN DBA.dbo.Disabled_Job_Allowed_Control control
	ON central.InstanceName = @@SERVERNAME
	AND central.JobName = control.JobName

	WHERE central.[AllowDisabled] = 'N'
	   OR central.[AllowDisabled] IS NULL
	-----------------------------------------------------------------------------------------------------------
	-- Update LastCheckedDTM timestamp for all rows regardless of any changes or not
	-----------------------------------------------------------------------------------------------------------

	UPDATE central
	SET 
	  central.LastCheckedDTM = CURRENT_TIMESTAMP
	
	FROM DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized central
	
	JOIN DBA.dbo.Disabled_Job_Allowed_Control control
	ON central.InstanceName = @@SERVERNAME
	AND central.JobName = control.JobName

	-----------------------------------------------------------------------------------------------------------
	-- Add to output of job to help confirmation
	-----------------------------------------------------------------------------------------------------------
	SELECT 
	  @@SERVERNAME as InstanceName
	, sysjobs.[name] as JobName
	FROM msdb.dbo.sysjobs ;

	SELECT
	  InstanceName
	, JobName
	, JobID
	, [Enabled]
	, LastChangedDTM
	, LastCheckedDTM
	, AllowDisabled
	, AllowDisabledSetDTM
	, AllowDisabledSetBy

	FROM DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized
	WHERE InstanceName = @@SERVERNAME ;

	-----------------------------------------------------------------------------------------------------------
	-- Add to output of job to help confirmation
	-----------------------------------------------------------------------------------------------------------
	SELECT 
	  [JobName]
    , [AllowJobToBeDisabled]
    , [WhoSetAllowed]
    , [SetAllowedDTM]

   FROM [DBA].[dbo].[Disabled_Job_Allowed_Control] ;

END

--C:\Users\spaylor\Documents\SQL Server Management Studio\Post Install Scripts NEW\53a (Common) - Create PROC sp_Save_Job_InFo_To_DBAMDB01pr.sql
