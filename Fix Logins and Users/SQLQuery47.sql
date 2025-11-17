--First create this report table:

DROP TABLE IF EXISTS #REPORT

CREATE TABLE #REPORT ( [DATABASE] VARCHAR (MAX),[USER] VARCHAR (MAX), [SID] VARBINARY (85))

--Then execute this query and run it:

select 'use ['+name+'] '+char(13)+                                                       
'insert into #report                                                                     
            select db_name(db_id()) collate sql_latin1_general_cp1_ci_as as [database] , 
                   name collate sql_latin1_general_cp1_ci_as as [user] ,
				   [sid] as [sid]
    from sys.database_principals                                                         
        where type in (''s'',''u'')                                                      
            and name not in                                                              
                (''dbo'',''guest'',''information_schema'',''sys'')'+char(13)+char(13)    
from sys.databases                                                                       
    where name not in ('master','model','msdb','tempdb')

--Then you can have:

--login without user
select name from sys.server_principals
    where [sid] not in 
        (select [sid] from #report)
        order by 1
--AND

--user without login
select [database], [user] collate latin1_general_ci_as , [sid]
    from #report
        where [sid] not in 
            ( select [sid] --collate latin1_general_ci_as
                from sys.server_principals)
order by 1