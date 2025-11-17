USE [DBA]
GO

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_name = 'spCustomTable2HTML' AND ROUTINE_TYPE = 'PROCEDURE')
	DROP PROCEDURE [dbo].[spCustomTable2HTML]
GO


USE [DBA]
GO
/****** Object:  StoredProcedure [dbo].[spCustomTable2HTML]    Script Date: 11/16/2023 11:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCustomTable2HTML]
    @TABLENAME nvarchar(500),
    @TBL_STYLE nvarchar(1024) = '' OUTPUT,
    @HDR_STYLE nvarchar(1024) = '' OUTPUT,
    @OUTPUT nvarchar(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    -- Declare variables
    DECLARE @Columns nvarchar(MAX) = '',
            @Data nvarchar(MAX),
            @SQL nvarchar(MAX);

    -- Snapshot columns (to force use of tempdb)
    IF OBJECT_ID('tempdb.dbo.##spCustomTable2HTMLColumns') IS NOT NULL
    BEGIN
        DROP TABLE ##spCustomTable2HTMLColumns;
    END

    SET @SQL = 
   'SELECT TOP 0 *
    INTO ##spCustomTable2HTMLColumns
    FROM ' + @TABLENAME;

    EXEC sp_executesql @SQL;

    -- Build header row
    SET @OUTPUT = (SELECT name AS td
                   FROM tempdb.sys.columns
                   WHERE object_id = OBJECT_ID('tempdb.dbo.##spCustomTable2HTMLColumns')
                   ORDER BY column_id
                   FOR XML RAW(''), ELEMENTS);
    SET @OUTPUT += '</tr>'

    -- Build column list
    SELECT @Columns += '[' + name + '] AS td,'
    FROM tempdb.sys.columns
    WHERE object_id = OBJECT_ID('tempdb.dbo.##spCustomTable2HTMLColumns')
    ORDER BY column_id;

    SET @Columns = LEFT(@Columns, LEN(@Columns) - 1);  -- Strip trailing comma

    -- Delete columns snapshot
    DROP TABLE ##spCustomTable2HTMLColumns;

    -- Build data rows
    SET @SQL =
   'SET @Data = CONVERT(varchar(MAX),
                        (SELECT ' + @Columns +
                       ' FROM ' + @TABLENAME +
                       ' FOR XML RAW (''tr''), ELEMENTS XSINIL))';

    EXEC sp_executesql @SQL, N'@Data NVARCHAR(MAX) OUTPUT', @Data = @Data OUTPUT;

    SET @Data = REPLACE(@Data, ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"', '');  -- Remove XSI namespace
    SET @Data = REPLACE(@Data, ' xsi:nil="true"', '');                                         -- Remove XSI attributes
    SET @OUTPUT += @Data;

    -- Prefix table/row headers
    SET @OUTPUT = REPLACE(@OUTPUT, ' ', '&nbsp;');                           -- Use non-breaking spaces
    SET @OUTPUT = REPLACE(@OUTPUT, '</tr>', '</tr>' + CHAR(13) + CHAR(10));  -- Add new line per row (to improve rendering in Microsoft Outlook)
    SET @OUTPUT = '<table ' + @TBL_STYLE + '>' +
                  '<tr ' + @HDR_STYLE + '>' +
                  @OUTPUT +
                  '</table>';
END
