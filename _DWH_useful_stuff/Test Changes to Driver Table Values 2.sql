
-- TEST CHANGES TO DRIVER TABLE

--TRUNCATE TABLE SystemMaintDB.dbo.Repl_ETL_Table_RowCount_Keys_Validation_V2_TEST ;
GO

BEGIN
	SET NOCOUNT ON;

	-------- input params emulation
	------DECLARE @QueryGroupSelect int = 3 ;

	-- processing vars
	DECLARE @SqlStatement varchar(2000) ;
	DECLARE @SelectClause varchar(1000) ; 
	DECLARE @LoopCTR int = 1 ;
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
	DECLARE @WhereClause varchar(1000) ;
	DECLARE @MinMaxField1 varchar(50) ;
	DECLARE @MinMaxField2 varchar(50) ;
	DECLARE @CountDistinctField1 varchar(50) ;
	DECLARE @CountDistinctField2 varchar(50) ;

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
		, WhereClause
		, [Comments]
		, [MinMaxField1]
		, [MinMaxField2]
		, CountDistinctField1
		, CountDistinctField2

		FROM SystemMaintDB.dbo.Repl_ETL_Table_RowCount_Keys_Validation_Driver_V2

		--WHERE InactiveFlag <> 'Y'
		--  --AND QueryGroup = 3

WHERE [Table] LIKE 'Website_Tag_List'

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
	, @WhereClause 
	, @Comments
	, @MinMaxField1
	, @MinMaxField2
	, @CountDistinctField1
	, @CountDistinctField2 ;

	WHILE @@FETCH_STATUS = 0
	BEGIN


		IF @Schema = 'CMP_13-1'
		SET @Schema = '[CMP_13-1]' ;

		IF @Database = 'iQ-Gaming'
		SET @Database = '[iQ-Gaming]' ;

		SET @Comments = ISNULL(@Comments, ' ') ;

		SET @WhereClause = ISNULL(@WhereClause, ' ') ;

		SET @MinMaxField1 = ISNULL(@MinMaxField1, ' ') ;
		SET @MinMaxField2 = ISNULL(@MinMaxField2, ' ') ;
		SET @CountDistinctField1 = ISNULL(@CountDistinctField1, ' ') ;
		SET @CountDistinctField2 = ISNULL(@CountDistinctField2, ' ') ;

		
		PRINT 'Query Number: ' + CAST(@LoopCTR AS varchar(3)) ;
		PRINT 'Table: ' + @Table ;
		PRINT 'Schema: ' + @Schema ;
		PRINT 'Database: ' + @Database ; 
		PRINT 'Server: ' + @Server ; 
		--PRINT 'AsOfDTTM: ' + CAST(@AsOfDTTM AS varchar(30)) ;
		--PRINT '-- [RowCount]'
		--PRINT 'Comments: ' + @Comments ;
		--PRINT 'WhereClause: ' + @WhereClause ;
		--PRINT '-- RunTimeSeconds'
		--PRINT 'QueryGroup: ' + CAST(@QueryGroup AS CHAR(1)) ; 
		--PRINT 'InactiveFlag: ' + @InactiveFlag ; 
		--PRINT 'MinMaxField1: ' + @MinMaxField1 ;
		--PRINT '-- MinMaxField1_Result'
		--PRINT 'MinMaxField2: ' + @MinMaxField2 ;
		--PRINT '-- CountDistinctField2_Result'
		--PRINT 'CountDistinctField1: ' + @CountDistinctField1 ;
		--PRINT '-- CountDistinctField1_Result'
		--PRINT 'CountDistinctField2: ' + @CountDistinctField2 ;
		--PRINT '-- CountDistinctField2_Result'

		PRINT ' ' ;

		-- Build Select Clause According to validation field 1 & 2 settings

		SET @SelectClause = 'SELECT ''' + 
								@Table + ''' AS [Table]  , ''' +
							    @Schema + ''' AS [Schema] , ''' + 
							    @Database  + ''' AS [Database] , ''' +
								@Server + ''' AS [Server] , ''' +
								CAST(@AsOfDTTM AS varchar(30)) + ''' AS AsOfDTTM , COUNT(*) AS [RowCount] , ''' +
								@Comments + ''' AS [Comments] , ' + 
								QUOTENAME(@WhereClause, '''')  + ' AS WhereClause , ' +
								'0' + ' AS RunTimeSeconds , ' +
								CAST(@QueryGroup AS CHAR(1)) + ' AS QueryGroup , ''' +
								@InactiveFlag + ''' AS InactiveFlag ' ;

		--PRINT 'SelectClause: ' + @SelectClause ;
		--PRINT ' ' ;


		IF @MinMaxField1 <> ' '
		BEGIN
			SET @SelectClause =	@SelectClause + 
		', ''' + @MinMaxField1 + ''' AS MinMaxField1 , 
		CAST(MIN(' + @MinMaxField1 +') AS varchar(50)) AS MinField1_Result , 
		CAST(MAX(' + @MinMaxField1 +') AS varchar(50)) AS MaxField1_Result ';
		END ;
		ELSE SET @SelectClause =	@SelectClause + 
		', ''' + @MinMaxField1 + ''' AS MinMaxField1 , NULL AS MinField1_Result , NULL AS MaxField1_Result ' ;

		IF @MinMaxField2 <> ' '
		BEGIN
			SET @SelectClause =	@SelectClause + 
		', ''' + @MinMaxField2 + ''' AS MinMaxField2 , 
		CAST(MIN(' + @MinMaxField2 +') AS varchar(50)) AS MinField2_Result , 
		CAST(MAX(' + @MinMaxField2 +') AS varchar(50)) AS MaxField2_Result';
		END ;
		ELSE SET @SelectClause =	@SelectClause + 
		', ''' + @MinMaxField2 + ''' AS MinMaxField2 , NULL AS MinField2_Result , NULL AS MaxField2_Result ' ;

		IF @CountDistinctField1 <> ' '
		BEGIN
		SET  @SelectClause = @SelectClause + 
		', ''' + @CountDistinctField1 + ''' AS CountDistinctField1 , 
		CAST(COUNT(DISTINCT ' + @CountDistinctField1 +') AS varchar(50)) AS CountDistinctField1_Result ' ;  
		END 
		ELSE SET @SelectClause = @SelectClause + 
		', ''' + @CountDistinctField1 + ''' AS CountDistinctField1 , NULL AS CountDistinctField1_Result '  ;

		IF @CountDistinctField2 <> ' '
		BEGIN
		SET  @SelectClause = @SelectClause + 
		', ''' + @CountDistinctField2 + ''' AS CountDistinctField2 , 
		CAST(COUNT(DISTINCT ' + @CountDistinctField2 +') AS varchar(50)) AS CountDistinctField2_Result ' ;  
		END 
		ELSE SET @SelectClause = @SelectClause + 
		', ''' + @CountDistinctField2 + ''' AS CountDistinctField2 , NULL AS CountDistinctField2_Result '  ;


		--PRINT 'SelectClause: ' + @SelectClause ;
		--PRINT ' ' ;

		SET @SqlStatement =

		'INSERT INTO SystemMaintDB.dbo.Repl_ETL_Table_RowCount_Keys_Validation_V2_TEST ' +
		@SelectClause +
		' FROM ' + @Server + '.' + @Database + '.' + @Schema + '.' + @Table + ' ' +
		@WhereClause

		PRINT 'SqlStatement: ' + @SqlStatement ;
		PRINT ' ' ;
		PRINT '------------------------------------------------------------------' ;
		PRINT ' ' ;
  
		EXEC(@SqlStatement) ;

		FETCH NEXT FROM CSR_DRIVER INTO 
		  @Table
		, @Schema 
		, @Database
		, @Server
		, @QueryGroup
		, @InactiveFlag
		, @WhereClause 
		, @Comments
		, @MinMaxField1
		, @MinMaxField2
		, @CountDistinctField1
		, @CountDistinctField2 ;

		SET @LoopCTR = @LoopCTR + 1 ;

	END ;

	CLOSE CSR_DRIVER ;
	DEALLOCATE CSR_DRIVER ;

END
GO


