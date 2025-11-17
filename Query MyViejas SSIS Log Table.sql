USE MyViejasSSIS
GO

SELECT 
  id
, [event]
, computer
, operator
, source
, sourceid
, executionid
, starttime
, endtime
, DATEDIFF(S,starttime,endtime) AS DurationSeconds
, datacode
, databytes
, message

FROM MyViejasSSIS.dbo.sysssislog

WHERE id > 22

ORDER BY 
  starttime
, endtime

GO

--TRUNCATE TABLE MyViejasSSIS.dbo.sysssislog
--GO