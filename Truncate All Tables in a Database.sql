USE <dbname>
EXEC sp_MSForEachTable 'TRUNCATE TABLE ?'

-- disable all constraints
USE <dbname>
EXEC sp_MSForEachTable "ALTER TABLE ? NOCHECK CONSTRAINT all"

-- delete data in all tables
USE <dbname>
EXEC sp_MSForEachTable "DELETE FROM ?"

-- enable all constraints
USE <dbname>
exec sp_MSForEachTable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"