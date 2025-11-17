CREATE
PROC usp_scheduled_reports
AS
SET
NOCOUNT 
on 
SELECT


'exec msdb.dbo.sp_start_job @job_name = ' + CHAR(39) + CONVERT(VARCHAR(100),sjs.name COLLATE SQL_Latin1_General_CP1_CI_AS ) + CHAR(39) + ' -- ' + c.name FROM msdb.dbo.sysjobs sjs 
 
INNER JOIN ReportServer.dbo.ReportSchedule rs ON rs.ScheduleID = CAST(sjs.name AS UNIQUEIDENTIFIER) 

  
 
INNER JOIN ReportServer.dbo.Catalog c ON rs.ReportID = c.ItemID 
 
WHERE category_id IN (SELECT category_id FROM msdb.dbo.syscategories WHERE name = 'Report Server')  
 
ORDER BY sjs.name 