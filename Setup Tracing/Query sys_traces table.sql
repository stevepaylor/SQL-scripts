SELECT * --TextData, HostName, ApplicationName, LoginName, StartTime, DatabaseName, SessionLoginName
FROM sys.fn_trace_gettable('E:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Log\log_784.trc', null)
WHERE StartTime BETWEEN '2022-03-24 17:20' AND '2022-03-24 17:40'

--0x0F77191DB78A3246813C08E06E2D2EFB

SQLAgent - TSQL JobStep (Job 0x0F77191DB78A3246813C08E06E2D2EFB : S.......................tep 1)