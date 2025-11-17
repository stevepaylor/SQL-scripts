SELECT CONVERT(VARCHAR(32),name) Name, 'exec sp_helptext ''' + activation_procedure + '''' ActivationProc_Code 
FROM msdb.sys.service_queues