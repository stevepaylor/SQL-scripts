sp_helpfile

use master

go

Alter database tempdb modify file (name = tempdev, filename = 'K:\SQL_TempDBdata\tempdb.mdf')

go

Alter database tempdb modify file (name = templog, filename = 'K:\SQL_TempDBlog\templog.ldf')

go

--Alter database tempdb modify file (name = tempdb1, filename = 'E:\SQL_Database_Files\LYNCLOCAL\TempDBdata\tempdb1.ndf')

--go

