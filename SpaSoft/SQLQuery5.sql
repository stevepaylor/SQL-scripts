select 'ALTER ROLE db_owner ADD MEMBER [' + loginname + '];' from syslogins
where status = 9 and len(loginname) > 30
and not (loginname in ('##MS_PolicyTsqlExecutionLogin##','##MS_PolicyEventProcessingLogin##',
				'NT SERVICE\SQLTELEMETRY$SQLEXPRESS'))