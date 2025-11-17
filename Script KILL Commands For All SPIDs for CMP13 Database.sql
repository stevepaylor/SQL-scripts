USE [master] 
GO 

SELECT 'KILL ' + CAST(session_id AS VARCHAR(10)) AS 'SQL Command'
--, login_name as 'Login'
FROM sys.dm_exec_sessions
WHERE is_user_process = 1
AND database_id = DB_ID('CMP13'); --specify database name
GO