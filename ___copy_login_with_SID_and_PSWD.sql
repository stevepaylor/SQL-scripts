WITH users AS 
(SELECT name, sid, CONVERT (varbinary(256), [password]) HashPW 
 FROM master..syslogins 
 WHERE CONVERT (varbinary(256), [password]) IS NOT NULL) 
 
 SELECT 'CREATE LOGIN [' + name + '] WITH PASSWORD = ' + 
 UPPER(master.dbo.fn_varbintohexstr(HashPW)) + ' HASHED, CHECK_POLICY = OFF, SID = ' + 
 UPPER(master.dbo.fn_varbintohexstr(sid)) 
 FROM users 
 ORDER BY name