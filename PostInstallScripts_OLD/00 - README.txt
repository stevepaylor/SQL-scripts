After you have installed SQL Server along with the appropriate service pack and hot fix, run the scripts in this folder in the order in which they are numbered.

NOTE 1: When you create the DBA database, run the script corresponding to the version of SQL Server installed. You must edit the script with the appropriate paths for the mdf and ldf files on the server.

NOTE 2: To create the Backup jobs (FULL, DIFF and INCR) you must edit the InstallBackupJobs script with the appropriate paths.

For San Diego servers
========================
@destdir = \\sequel\sql_prod1 (Production Full and Differential jobs. Please use whichever share 1 -3 has the most available space)
@destdir = \\sequel\sql_nonprod1 (Non-productino Full and Differential jobs. Please use whichever share 1 -3 has the most available space)
@destdir = \\sequel\sql_incr (Incremental job)

For Las Vegas servers
========================
@destdir = \\ghostbar\sql_full\ (Full and Differential jobs)
@destdir = \\ghostbar\sql_incr\ (Incremental job)


2- Parameter called @BackupSoftware.  
Use the conventions below:

For 2008 and greater
============
@BackupSoftware = Null (Native)


For 2005:
============
@BackupSoftware  = LITESPEED (Lite Speed)
@BackupSoftware  = SQLBACKUP (Red Gate SQL Backup)
@BackupSoftware  = Null (Native)
@BufferCount     = NULL
@MaxTransferSize = NULL
@BlockSize       = NULL


For VMs (regardless of the SQL version):
============
@BufferCount     = NULL
@MaxTransferSize = NULL
@BlockSize       = NULL