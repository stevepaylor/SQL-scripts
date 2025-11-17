----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 58 $
----------------------------------------------------------------------------------------------------

USE [DBA]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF OBJECT_ID('UpdateStatisticsLog') IS NULL
	CREATE TABLE [dbo].[UpdateStatisticsLog](
		[UpdateStatisticsLogId] [int] IDENTITY(1,1) NOT NULL,
		[DatabaseName] [nvarchar](128) NOT NULL,
		[SchemaName] [nvarchar](128) NOT NULL,
		[TableName] [nvarchar](128) NOT NULL,
		[IndexName] [nvarchar](128) NOT NULL,
		[StartTime] [datetime] NOT NULL,
		[EndTime] [datetime] NULL,
		[RowCountDataLevel] [bigint] NOT NULL,
		[RowsModifiedCount] [int] NOT NULL,
		[RowsSampled] [varchar](20) NOT NULL,
	 CONSTRAINT [PK_UpdateStatisticsLog] PRIMARY KEY CLUSTERED 
	(
		[UpdateStatisticsLogId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[isp_UPDATE_STATISTICS]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[isp_UPDATE_STATISTICS]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Code adapted from Ian Stirk's "SQL Server DMVs in Action" book - Ian_Stirk@yahoo.com
CREATE PROC [dbo].[isp_UPDATE_STATISTICS]
(@DatabaseName nvarchar(128))
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE 
	@SchemaName nvarchar(128), @TableName nvarchar(128), @IndexName nvarchar(128), @RowCount bigint, 
	@RowsModified int, @RowsSampled varchar(20), @IndexesId int, @SQL nvarchar(4000), 
	@UpdateStatisticsLogId int, @rc int 

SET @IndexesId = 1

CREATE TABLE #Indexes 
(
	IndexesId int IDENTITY(1, 1), SchemaName nvarchar(128), TableName nvarchar(128), IndexName nvarchar(128),
	RowCountDataLevel bigint, RowsModifiedCount int
)

SET @SQL = 
'
	SELECT 
		ss.name AS SchemaName, st.name AS TableName, si.name AS IndexName, 
		ssi.rowcnt AS RowCountDataLevel, ssi.rowmodctr AS RowsModifiedCount
	FROM ' + QUOTENAME(@DatabaseName) + '.sys.indexes si
	JOIN ' + QUOTENAME(@DatabaseName) + '.sys.sysindexes ssi ON si.object_id = ssi.id AND si.name = ssi.name
	JOIN ' + QUOTENAME(@DatabaseName) + '.sys.tables st ON st.[object_id] = si.[object_id]
	JOIN ' + QUOTENAME(@DatabaseName) + '.sys.schemas ss ON ss.[schema_id] = st.[schema_id]
	WHERE st.is_ms_shipped = 0
		AND si.index_id != 0
		AND ssi.rowcnt > 100
		AND ssi.rowmodctr > 0
'

INSERT INTO #Indexes (SchemaName, TableName, IndexName,	RowCountDataLevel, RowsModifiedCount)
EXEC sp_executesql @SQL

SELECT @rc = COUNT(*) FROM #Indexes

WHILE @IndexesId <= @rc
BEGIN
	SELECT
		@SchemaName = SchemaName, @TableName = TableName, @IndexName = IndexName,
		@RowCount = RowCountDataLevel, @RowsModified = RowsModifiedCount
	FROM #Indexes
	WHERE IndexesId = @IndexesId

	SET @RowsSampled = 
		CASE
			WHEN @RowCount < 500000     THEN '100 PERCENT'
			WHEN @RowCount < 1000000    THEN '50 PERCENT'
			WHEN @RowCount < 5000000    THEN '25 PERCENT'
			WHEN @RowCount < 10000000   THEN '10 PERCENT'
			WHEN @RowCount < 50000000   THEN '5 PERCENT'
			WHEN @RowCount < 100000000  THEN '2 PERCENT'
			WHEN @RowCount < 1000000000 THEN '1 PERCENT'
			ELSE '20000000 ROWS'
		END


	SET @SQL = 
		'UPDATE STATISTICS ' + QUOTENAME(@DatabaseName) + '.'
		+ QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName)
		+ ' ' + QUOTENAME(@IndexName) + ' WITH SAMPLE ' + @RowsSampled

	INSERT INTO UpdateStatisticsLog 
	(
		DatabaseName, SchemaName, TableName, IndexName, StartTime, 
		RowCountDataLevel, RowsModifiedCount, RowsSampled
	)
	VALUES 
	(
		@DatabaseName, @SchemaName, @TableName, @IndexName, GETDATE(), 
		@RowCount, @RowsModified, @RowsSampled
	)

	SET @UpdateStatisticsLogId = SCOPE_IDENTITY()

	--PRINT @SQL
	EXEC sp_executesql @SQL

	UPDATE UpdateStatisticsLog
	SET EndTime = GETDATE()
	WHERE UpdateStatisticsLogId = @UpdateStatisticsLogId

	SET @IndexesId = @IndexesId + 1
END

DROP TABLE #Indexes

GO
