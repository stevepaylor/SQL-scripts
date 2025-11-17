1) DETACH DATABASE CMP13
2) Rename datafile and logfile in MDF.OLD and LDF.OLD
3) Create a new database with THE SAME name and identical original datafile and logfile position. I
4) ALTER DATABASE CMP13 SET OFFLINE
5) Now you can put the original datafile in the original position
6) ALTER DATABASE CMP13 SET ONLINE. This will fail but now we’ll can rebuild the log file
7) ALTER DATABASE [CMP13] REBUILD LOG ON (NAME='CMP13_log',FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\CMP13_log.ldf')
At this point the database will be usable but SQL Server at the end will show this warning:
Warning: The log for database ‘CMP13’ has been rebuilt. Transactional consistency has been lost. The RESTORE chain was broken, and the server no longer has context on the previous log files, so you will need to know what they were. You should run DBCC CHECKDB to validate physical consistency. The database has been put in dbo-only mode. When you are ready to make the database available for use, you will need to reset database options and delete any extra log files.
8) Final Step: open the database to users:
ALTER DATABASE [CMP13] SET MULTI_USER