DECLARE @WhereClause varchar(1000) = 'WHERE GamingDT = ''2018-01-01''' ;
PRINT @WhereClause ;

PRINT QUOTENAME(@WhereClause, '''') ;