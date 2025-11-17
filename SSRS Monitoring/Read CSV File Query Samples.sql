sp_configure 'Ad Hoc Distributed Queries',1
GO
reconfigure
GO

select 
TIMESTAMPX
from openrowset('MSDASQL'
,'Driver={Microsoft Access Text Driver (*.txt, *.csv)}'
,'select * from C:\Monitor_SSRS\ReportCurrentTimestamp.CSV')

--OR

select
TIMESTAMPX
--from openrowset('MSDASQL'
--,'Driver={Microsoft Access Text Driver (*.txt, *.csv)}; 
--DBQ=C:\blog\' 
--,'select * from "input.CSV"') T

--OR

--select
--[hour],
--UserID,
--[ReportLaunch]
--from openrowset('MSDASQL'
-- ,'Driver={Microsoft Access Text Driver (*.txt, *.csv)}; 
-- DefaultDir=C:\blog\' 
-- ,'select * from "input.CSV"') T