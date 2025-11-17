USE msdb ;
GO

EXEC dbo.sp_update_job
    @job_name = N'DBA - Record DB Connections',
    @new_name = N'DBA - Record DB Connections -- Disabled',
    @description = N'DBA - Record DB Connections disabled during process upgrade.',
    @enabled = 0 ;
GO

USE DBA
GO

SELECT 
  CAST(dbname AS VARCHAR(128)) AS dbname
, CAST(loginname AS VARCHAR(128)) AS loginname
, CAST(hostname AS VARCHAR(128)) AS hostname
, cmd = CASE
  WHEN hostname = 'initialize' THEN CAST('initialize' AS VARCHAR(16)) 
  ELSE CAST('Unknown Command' AS VARCHAR(16))
  END
, logintime
INTO DBActivity_OLD
FROM DBActivity
WHERE dbname IS NOT NULL 
  AND dbname <> ' '
  AND loginname IS NOT NULL 
  AND loginname <> ' '
  AND hostname IS NOT NULL 
  AND hostname <> ' '
GO

--SELECT * 
--FROM DBActivity_OLD
--GO

DROP TABLE DBActivity
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE DBActivity(
	dbname VARCHAR(128) NOT NULL,
	loginname VARCHAR(128) NOT NULL,
	hostname VARCHAR(128) NOT NULL,
	cmd VARCHAR(16),
	logintime DATETIME NOT NULL,
 CONSTRAINT PK_DBActivety PRIMARY KEY CLUSTERED 
(
	dbname ASC,
	loginname ASC,
	hostname ASC,
	cmd ASC,
	logintime ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

USE DBA
GO

INSERT INTO DBActivity
SELECT 
  dbname
, loginname
, hostname
, cmd
, logintime
FROM DBActivity_OLD
GO

USE msdb ;
GO

EXEC dbo.sp_update_job
    @job_name = N'DBA - Record DB Connections -- Disabled',
    @new_name = N'DBA - Record DB Connections',
    @description = N'DBA - Record DB Connections is renabled.',
    @enabled = 1 ;
GO