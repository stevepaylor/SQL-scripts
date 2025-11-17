SELECT CONVERT(char(30), GETDATE(), 120) 
--AS UsingConvertTo_ISO860


--select 
--[hour],
--UserID,
--[ReportLaunch]
--from openrowset('MSDASQL'
--,'Driver={Microsoft Access Text Driver (*.txt, *.csv)}'
--,'select * from C:\blog\input.CSV')


SELECT TOP 1 'YES', GETDATE(), DATEADD(MM,1,GETDATE())
FROM DBA.dbo.DBActivity
WHERE '2019-03-19 13:54:08' < DATEADD(MM,1,GETDATE())