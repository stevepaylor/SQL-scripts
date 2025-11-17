USE SystemMaintDB
GO 

-- processing vars
DECLARE @SQL varchar(2000) ;
DECLARE @QueryStartTime datetime ;
DECLARE @QueryEndTime datetime ;

-- input (DRIVER table)
DECLARE @Table varchar(100) ;
DECLARE @Schema varchar(100) ;
DECLARE @Database varchar(100) ;
DECLARE @Server varchar(100) ;
DECLARE @QueryGroup int ;
DECLARE @ActiveFlag char(1) ;
DECLARE @ModifiedDTTM datetime ;
DECLARE @ModifiedBy varchar(50) ;

-- input / output (read and write)
DECLARE @Comments varchar(200) ;
DECLARE @WhereClause varchar(200) ;

-- output (validation results)

DECLARE @AsOfDTTM datetime ;
DECLARE @RowCount int ;
DECLARE @RunTimeSeconds int ;


DECLARE CSR_DRIVER CURSOR FAST_FORWARD FOR
SELECT 
  [Table]
, [Schema]
, [Database]
, [Server]
, QueryGroup
, ActiveFlag
, WhereClause
, Comments

FROM dbo.Repl_ETL_RowCounts_Validation_Driver

WHERE ActiveFlag = 'Y'

ORDER BY 
   [Table]
,  [Schema]
,  [Database]
,  [Server] ;
 
OPEN CSR_DRIVER

FETCH NEXT FROM CSR_DRIVER
 
WHILE @@FETCH_STATUS = 0
BEGIN

	--EXEC sp_executesql @SQL

	PRINT @Table
	PRINT @Schema
	PRINT @Database
	PRINT @Server
	PRINT @Comments
	PRINT @WhereClause

	FETCH NEXT FROM CSR_DRIVER

END
CLOSE CSR_DRIVER
DEALLOCATE CSR_DRIVER
GO