select *
from msdb.dbo.Sysmail_mailitems
order by send_request_date desc


select *
from [dbo].[sysmail_unsentitems]
order by send_request_date desc

SELECT er.log_id AS [LogID], 
    er.event_type AS [EventType], 
    er.log_date AS [LogDate], 
    er.description AS [Description], 
    er.process_id AS [ProcessID], 
    er.mailitem_id AS [MailItemID], 
    er.account_id AS [AccountID], 
    er.last_mod_date AS [LastModifiedDate], 
    er.last_mod_user AS [LastModifiedUser],
    fi.send_request_user,
    fi.send_request_date,
    fi.recipients, fi.subject, fi.body
FROM msdb.dbo.sysmail_event_log er 
    LEFT JOIN msdb.dbo.sysmail_faileditems fi
ON er.mailitem_id = fi.mailitem_id
ORDER BY [LogDate] DESC

SELECT ssi.sent_date, * 
FROM msdb.dbo.sysmail_sentitems ssi
ORDER BY ssi.sent_date DESC

SELECT CONVERT(VARCHAR(32),name) Name, 'exec sp_helptext ''' + activation_procedure + '''' ActivationProc_Code 
FROM msdb.sys.service_queues

InternalMailQueue	exec sp_helptext '[dbo].[sp_ExternalMailQueueListener]'
ExternalMailQueue	exec sp_helptext '[dbo].[sp_sysmail_activate]'
syspolicy_event_queue	exec sp_helptext '[dbo].[sp_syspolicy_events_reader]'
QueryNotificationErrorsQueue	NULL
EventNotificationErrorsQueue	NULL
ServiceBrokerQueue	NULL

sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'Database Mail XPs', 1;  
GO  
RECONFIGURE  
GO  

--The following example enables the Database Mail extended stored procedures if it is not already enabled.

SQL

Copy
IF EXISTS (
    SELECT * FROM sys.configurations 
    WHERE NAME = 'Database Mail XPs' AND VALUE = 0)
BEGIN
  PRINT 'Enabling Database Mail XPs'
  EXEC sp_configure 'show advanced options', 1;  
  RECONFIGURE
  EXEC sp_configure 'Database Mail XPs', 1;  
  RECONFIGURE  
END