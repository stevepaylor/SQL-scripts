--USE MASTER
--GO

--RESTORE FILELISTONLY FROM
--DISK = 'R:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\CMKTDB01PR_CMKTDB_1.bak'
--GO


--RESTORE DATABASE CMKTDB10 FROM
-- DISK = '\\CMKTDB13BPR\N$\CMKTMC13PR$CMKTAG13pr_CMKTDB10_FULL_20160209_223001.bak'
--WITH 
-- MOVE 'CMktDB'   TO 'J:\UserDBdata2\CMKTDB10_data.mdf'
--,MOVE 'CMktDB_2' TO 'J:\UserDBdata2\CMKTDB10_data_2.ndf'
--,MOVE 'CMktDB_3' TO 'J:\UserDBdata2\CMKTDB10_data_3.ndf'
--,MOVE 'CMktDB_4' TO 'J:\UserDBdata2\CMKTDB10_data_4.ndf'
--,MOVE 'CMktDB_5' TO 'J:\UserDBdata2\CMKTDB10_data_5.ndf'
--,MOVE 'CMktDB_6' TO 'J:\UserDBdata2\CMKTDB10_data_6.ndf'
--,MOVE 'CMktDB_7' TO 'J:\UserDBdata2\CMKTDB10_data_7.ndf'
--,MOVE 'CMktDB_8' TO 'J:\UserDBdata2\CMKTDB10_data_8.ndf'
--,MOVE 'CMktDB_log'  TO 'L:\UserDBlog\CMKTDB10_log.ldf'
--,STATS = 5
--GO

USE [master]
RESTORE DATABASE [CMKTDB10_TEST] FROM  
 DISK = 'R:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\CMKTDB01PR_CMKTDB_1.bak'
,DISK = 'R:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\CMKTDB01PR_CMKTDB_2.bak'
,DISK = 'R:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\CMKTDB01PR_CMKTDB_3.bak' 
WITH  
 FILE = 1
,MOVE N'CMktDB' TO N'J:\UserDBdata2\CMKTDB10_TEST_data.mdf'
,MOVE N'CMKTDB_2' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_2.ndf'
,MOVE N'CMKTDB_3' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_3.ndf'
,MOVE N'CMKTDB_4' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_4.ndf'
,MOVE N'CMKTDB_5' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_5.ndf'
,MOVE N'CMKTDB_6' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_6.ndf'
,MOVE N'CMKTDB_7' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_7.ndf'
,MOVE N'CMKTDB_8' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_8.ndf'
,MOVE N'CMktDB_log' TO N'L:\UserDBlog\CMKTDB10_TEST_log.ldf'
,NOUNLOAD
,NORECOVERY
,STATS = 5
GO


--USE [master]
--RESTORE DATABASE [CMKTDB10_TEST] FROM  
-- DISK = 'R:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Backup\CMKTDB01PR_CMKTDB.DIF'
--WITH  
-- FILE = 1
--,MOVE N'CMktDB' TO N'J:\UserDBdata2\CMKTDB10_TEST_data.mdf'
--,MOVE N'CMKTDB_2' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_2.ndf'
--,MOVE N'CMKTDB_3' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_3.ndf'
--,MOVE N'CMKTDB_4' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_4.ndf'
--,MOVE N'CMKTDB_5' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_5.ndf'
--,MOVE N'CMKTDB_6' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_6.ndf'
--,MOVE N'CMKTDB_7' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_7.ndf'
--,MOVE N'CMKTDB_8' TO N'J:\UserDBdata2\CMKTDB10_data_TEST_8.ndf'
--,MOVE N'CMktDB_log' TO N'L:\UserDBlog\CMKTDB10_TEST_log.ldf'
--,NOUNLOAD
--,RECOVERY
--,STATS = 5
--GO
