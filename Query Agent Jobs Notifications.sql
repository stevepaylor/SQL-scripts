SELECT j.name AS JobName,j.notify_level_email, e.name AS EmailOperator,j.notify_level_netsend, n.name AS NetSendOperator
,j.notify_level_page, p.name AS PagerOperator,j.notify_level_eventlog,j.delete_level
FROM msdb.dbo.sysjobs j 
LEFT JOIN msdb.dbo.sysoperators e ON j.notify_email_operator_id = e.id
LEFT JOIN msdb.dbo.sysoperators n ON j.notify_netsend_operator_id = n.id
LEFT JOIN msdb.dbo.sysoperators p ON j.notify_page_operator_id = p.id
WHERE j.name LIKE 'DBA - AAG%'
--AND e.name <> 'StevePager'
ORDER BY p.name,j.notify_level_eventlog