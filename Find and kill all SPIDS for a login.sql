Use
Master
Go
Declare
@dbname sysname
Set
@dbname ='it_cfg'
Declare
@spid int
Select
@spid =min(spid)from master.dbo.sysprocesses
where
dbid=db_id(@dbname)
While
--@spid IsNotNull
@spid Is Not Null
Begin
    
Execute ('Kill '+@spid)
   
SELECT @spid = min(spid)from master.dbo.sysprocesses
     
where dbid =db_id(@dbname)
and
spid > @spid

End

