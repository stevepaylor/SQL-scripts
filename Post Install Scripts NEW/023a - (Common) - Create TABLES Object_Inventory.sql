USE [DBA]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select TABLE_NAME From INFORMATION_SCHEMA.TABLES Where TABLE_NAME = 'Inventory')
DROP TABLE [dbo].[Inventory]
GO

BEGIN
  CREATE TABLE [dbo].[Inventory](
	  [Instance] [varchar](100) NOT NULL,
      [Object_type] [varchar](100) NOT NULL,
      [ID] [varchar](100) NOT NULL,
	  [name] [varchar](100) NOT NULL,
	  [date_created] [datetime] NOT NULL,
	  [date_modified] [datetime] NULL,
	  [sid] [varchar](100) NULL,
	  [Date_Added] [datetime] NOT NULL,
	  [Date_Updated] [datetime] NULL,
	  [Date_Deleted] [datetime] NULL,
	  [New_Object_Flag] [char](1) NULL
  ) ON [PRIMARY]

  IF EXISTS (SELECT * FROM sys.indexes WHERE name='ClusteredIndex-20190429-135338' AND object_id = OBJECT_ID('dbo.Inventory'))
  DROP INDEX [ClusteredIndex-20190429-135338] ON [dbo].[Inventory] WITH ( ONLINE = OFF )

  CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20190429-135338] ON [dbo].[Inventory]
  (
	  [Instance] ASC,
	  [Object_type] ASC,
	  [ID] ASC,
	  [name] ASC,
	  [date_created] ASC,
	  [sid] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
GO

If Exists (Select TABLE_NAME From INFORMATION_SCHEMA.TABLES Where TABLE_NAME = 'Inventory_Temp')
DROP TABLE [dbo].[Inventory_Temp]
GO

CREATE TABLE [dbo].[Inventory_Temp](
	[Instance] [varchar](100) NOT NULL,
	[Object_type] [varchar](100) NOT NULL,
	[ID] [varchar](100) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[date_created] [datetime] NOT NULL,
	[date_modified] [datetime] NULL,
	[sid] [varchar](100) NULL
) ON [PRIMARY]
GO




