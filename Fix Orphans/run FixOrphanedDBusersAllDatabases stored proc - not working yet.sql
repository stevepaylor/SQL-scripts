exec sp_foreachDB 
  @Command1 = 'PRINT ''?''' 
, @Command2 = 'USE ?' 
, @Command3 = 'EXEC DBA..FixOrphanedDBusers ?' 
--, @PreCommand = 'PRINT ''Starting App''' 
--, @PostCommand = 'PRINT ''Finished App''' 