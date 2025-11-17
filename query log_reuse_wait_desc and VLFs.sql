--SELECT
--    name, log_reuse_wait_desc 
--FROM sys.DATABASES


SELECT [name], recovery_model_desc, log_reuse_wait_desc  
 FROM sys.databases;

 --DBCC LOGINFO (CMP13)