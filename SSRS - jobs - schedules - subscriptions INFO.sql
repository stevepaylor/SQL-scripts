SELECT
     b.name AS JobName
   , e.name as catalog_item_name
   , e.path as catalog_item_path
   , d.description subscription_desc
   , a.SubscriptionID
   , d.laststatus as subscriptions_laststatus
   , d.eventtype as subscriptions_eventtype
   , d.LastRunTime as subscriptions_LastRunTime
   , b.date_created as sysjobs_date_created
   , b.date_modified as sysjobs_date_date_modified
FROM 
   ReportServer.dbo.ReportSchedule a 
   JOIN msdb.dbo.sysjobs b 
   ON CAST(a.ScheduleID as nvarchar(128)) = b.name
   JOIN ReportServer.dbo.ReportSchedule c 
   ON b.name = CAST(c.ScheduleID as nvarchar(128))
   JOIN ReportServer.dbo.Subscriptions d  
   ON c.SubscriptionID = d.SubscriptionID
   JOIN ReportServer.dbo.Catalog e 
   ON d.report_oid = e.itemid

WHERE 
--   e.name = 'Sales_Report'
d.description LIKE '%11AM%'