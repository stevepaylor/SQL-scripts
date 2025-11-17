USE SystemMaintDB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Steve Paylor
-- Create date: 07/15/2023
-- Description:	Called by a job, this proc generates and executes a SELECT statement each entry in the driver table.  
--              The output of each query is appended to a table which will later be queried to produce various synchronization 
--              validation reports. 
-- =============================================
CREATE PROCEDURE usp_Repl_ETL_Table_RowCount_Keys_Validation
--Add the parameters for the stored procedure here
------@QueryGroupSelect int = 0

AS
BEGIN
	SET NOCOUNT ON;

	-------- input params emulation
	------DECLARE @QueryGroupSelect int = 3 ;

	-- processing vars
	DECLARE @SqlStatement varchar(1000) ;
	DECLARE @SelectClause varchar(500) ; 
	--DECLARE @QueryStartTime datetime ;  -- future use to calculate runtime of each generated query
	--DECLARE @QueryEndTime datetime ; -- future use to calculate runtime of each generated query

	-- input / output (read and write) - Included in SELECT list
	DECLARE @Table varchar(100) ;
	DECLARE @Schema varchar(100) ;
	DECLARE @Database varchar(100) ;
	DECLARE @Server varchar(100) ;
	DECLARE @QueryGroup int ;
	DECLARE @InactiveFlag char(1) ;
	DECLARE @Comments varchar(200) ;
	DECLARE @WhereClause varchar(200) ;
	DECLARE @ValidationField1 varchar(50) ;
	DECLARE @ValidationField2 varchar(50) ;

	-- output (validation Results) - Computed and then included in SELECT list

	DECLARE @AsOfDTTM varchar(30) = CONVERT(varchar(30),CURRENT_TIMESTAMP,120);
	DECLARE @RowCount int ;
	DECLARE @RunTimeSeconds int = 0 ;


	DECLARE CSR_DRIVER CURSOR 
	FOR SELECT 
		  [Table]
		, [Schema]
		, [Database]
		, [Server]
		, QueryGroup
		, InactiveFlag
		, [Comments]
		, WhereClause
		, ValidationField1
		, ValidationField2

		FROM SystemMaintDB.dbo.Repl_ETL_Table_RowCount_Keys_Validation_Driver

		WHERE InactiveFlag <> 'Y'
		--  AND QueryGroup = @QueryGroupSelect

		ORDER BY 
		   [Table]
		,  [Schema]
		,  [Database]
		,  [Server] ;

	OPEN CSR_DRIVER ;

	FETCH NEXT FROM CSR_DRIVER INTO 
	  @Table
	, @Schema 
	, @Database
	, @Server
	, @QueryGroup
	, @InactiveFlag
	, @Comments
	, @WhereClause 
	, @ValidationField1
	, @ValidationField2;

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @Comments = ISNULL(@Comments, ' ') ;
		SET @WhereClause = ISNULL(@WhereClause, ' ') ;
		SET @ValidationField1 = ISNULL(@ValidationField1, ' ') ;
		SET @ValidationField2 = ISNULL(@ValidationField2, ' ') ;

		PRINT 'Table: ' + @Table ;
		PRINT 'Schema: ' + @Schema ;
		PRINT 'Database: ' + @Database ; 
		PRINT 'Server: ' + @Server ; 
		PRINT 'AsOfDTTM: ' + CAST(@AsOfDTTM AS varchar(30)) ;
		PRINT 'Comments: ' + @Comments ;
		PRINT 'WhereClause: ' + @WhereClause ;
		PRINT 'ValidationField1: ' + @ValidationField1 ;
		PRINT 'ValidationField2: ' + @ValidationField2 ;
		PRINT 'QueryGroup: ' + CAST(@QueryGroup AS CHAR(1)) ; 
		PRINT 'InactiveFlag: ' + @InactiveFlag ; 
		PRINT ' ' ;

		-- Build Select Clause According to validation field 1 & 2 settings

		SET @SelectClause = 'SELECT ''[' + 
								@Table + ']'' AS [Table]  , ''[' +
							    @Schema + ']'' AS [Schema] , ''[' + 
							    @Database  + ']'' AS [Database] , ''' +
								@Server + ''' AS [Server] , ''' +
								CAST(@AsOfDTTM AS varchar(30)) + ''' AS AsOfDTTM , COUNT(*) AS [RowCount] , ''' +
								@Comments + ''' AS [Comments] , ''' + 
							    @WhereClause + ''' AS WhereClause , ' +
								'0' + ' AS RunTimeSeconds , ' +
								CAST(@QueryGroup AS CHAR(1)) + ' AS QueryGroup , ''' +
								@InactiveFlag + ''' AS InactiveFlag ' ;

		IF @ValidationField1 <> ' '
		BEGIN
			SET @SelectClause =	@SelectClause + 
			', ''' + @ValidationField1 + ''' AS ValidationField1 , CAST(MAX(' + @ValidationField1 +') AS varchar(50)) AS ValidationField1_Result ' ;
		END ;
		ELSE SET @SelectClause =	@SelectClause + 
		', ''' + @ValidationField1 + ''' AS ValidationField1 , NULL AS ValidationField1_Result ' ;

		IF @ValidationField2 <> ' '
		BEGIN
			SET @SelectClause =	@SelectClause + 
			', ''' + @ValidationField2 + ''' AS ValidationField2 , CAST(MAX(' + @ValidationField2 +') AS varchar(50)) AS ValidationField2_Result ' ;
		END ;
		ELSE SET @SelectClause =	@SelectClause + 
			', ''' + @ValidationField2 + ''' AS ValidationField2 , NULL AS ValidationField2_Result ' ;
	

		--PRINT 'SelectClause: ' + @SelectClause ;
		--PRINT ' ' ;


		SET @SqlStatement =

		'INSERT INTO SystemMaintDB.dbo.Repl_ETL_RowCounts_Validation +
		--( 
		--  [Table]
		--, [Schema]
		--, [Database]
		--, [Server]
		--, [AsOfDTTM]
		--, [RowCount]
		--, [Comments]
		--, [WhereClause]
		--, [RunTimeSeconds]
		--, [QueryGroup]
		--, [InactiveFlag]
		--, [ValidationField1]
		--, [ValidationField1_Result]
		--, [ValidationField2]
		--, [ValidationField2_Result]
		--) ' +
		@SelectClause +
		'FROM ' + @Server + '.[' + @Database + '].[' + @Schema + '].[' + @Table + '] --(nolock) ' +
		@WhereClause

		PRINT 'SqlStatement: ' + @SqlStatement ;
		PRINT ' ' ;
		PRINT '------------------------------------------------------------------' ;
		PRINT ' ' ;
  
		--EXEC(@SqlStatement) ;

		FETCH NEXT FROM CSR_DRIVER INTO 
		  @Table
		, @Schema 
		, @Database
		, @Server
		, @QueryGroup
		, @InactiveFlag
		, @Comments
		, @WhereClause 
		, @ValidationField1
		, @ValidationField2;

	END ;

	CLOSE CSR_DRIVER ;
	DEALLOCATE CSR_DRIVER ;

END
GO

