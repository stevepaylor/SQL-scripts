ALTER PROCEDURE [dbo].[sp_ForEachDB]

 @Command1 varchar(7900) = NULL, --Use ? to set the DBName, the If clause can be used to limit to only certain DBs.
 @Command2 varchar(7900) = NULL,
 @Command3 varchar(7900) = NULL,
 @ReplaceChar varchar(20) = '?', --Characters to replace with DBName, default to ?
 @PreCommand varchar(8000) = NULL,
 @PostCommand varchar(8000) = NULL
AS
BEGIN

SET NOCOUNT ON;
DECLARE @DBs as Table (DBName varchar(100), DBNumber int) --Temp table for DBs to run against
DECLARE @i int --Counter
DECLARE @DBCount int --Number of DBs to run over
DECLARE @DBName as varchar(100) --DB Name to run for instance within loop , used in a USE statement

DECLARE @SQL as varchar(8000) --Total SQL to run

DECLARE @WorkingSQL1 varchar(7900) = ''
DECLARE @WorkingSQL2 varchar(7900) = ''
DECLARE @WorkingSQL3 varchar(7900) = ''

--Find all the Databases on server and put in temp table to run SQL over each
INSERT INTO @DBs
select name as DBName, ROW_NUMBER() OVER(PARTITION BY 1 ORDER BY name) AS DBNumber
from sys.databases
--where [name] <> 'tempdb'

--Select * from @DBs

Select @DBCount = COUNT(*) from @DBs

Select @SQL = @PreCommand
exec(@SQL)

Set @i = 1
WHILE @i <= @DBCount --Start loop over all DB's
 BEGIN
 Select @DBName = DBname from @DBs where DBNumber = @i
 --Run First Command
 Select @WorkingSQL1 = replace(@Command1, @ReplaceChar, @DBName)
 Select @SQL = 'USE ' + @DBName + ' ' + @WorkingSQL1 
 --PRINT @SQL
 exec(@SQL)
 --Run Second Command
 Select @WorkingSQL2 = replace(@Command2, @ReplaceChar, @DBName)
 Select @SQL = 'USE ' + @DBName + ' ' + @WorkingSQL2 
 --PRINT @SQL
 exec(@SQL)
 --Run Third Command
 Select @WorkingSQL3 = replace(@Command3, @ReplaceChar, @DBName)
 Select @SQL = 'USE ' + @DBName + ' ' + @WorkingSQL3 
 --PRINT @SQL
 exec(@SQL)
 
 Set @i = @i + 1
 END

Select @SQL = @PostCommand
exec(@SQL)
END

GO
