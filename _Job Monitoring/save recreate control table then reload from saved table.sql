USE DBA
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Disabled_Job_Allowed_Control_SAVE]') 
AND type in (N'U'))
DROP TABLE [dbo].[Disabled_Job_Allowed_Control_SAVE]
GO

SELECT *
INTO [DBA].[dbo].[Disabled_Job_Allowed_Control_SAVE]
FROM [DBA].[dbo].[Disabled_Job_Allowed_Control]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Disabled_Job_Allowed_Control]') 
AND type in (N'U'))
DROP TABLE [dbo].[Disabled_Job_Allowed_Control]
GO

SET ANSI_NULLS ON ;
SET QUOTED_IDENTIFIER ON ;

CREATE TABLE DBA.[dbo].[Disabled_Job_Allowed_Control](
[JobName] [varchar](100) NOT NULL,
[AllowJobToBeDisabled] [char](1) NULL,
[WhoSetAllowed] [varchar](100) NULL,
[SetAllowedDTM] [datetime] NULL,
CONSTRAINT [PK_Disabled_Job_Allowed_Control] PRIMARY KEY CLUSTERED 
(
[JobName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] ;
GO

INSERT INTO [DBA].[dbo].[Disabled_Job_Allowed_Control]
SELECT *
FROM [DBA].[dbo].[Disabled_Job_Allowed_Control_SAVE]
GO

--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Disabled_Job_Allowed_Control_SAVE]') AND type in (N'U'))
--DROP TABLE [dbo].[Disabled_Job_Allowed_Control_SAVE]
--GO

DBA.dbo.sp_Save_Job_InFo_To_DBAMDB01pr 
GO