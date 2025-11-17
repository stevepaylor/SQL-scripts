select l.dns_name,l.port from sys.dm_hadr_database_replica_states s
--inner join sys.availability_group_listeners l on l.group_id = s.group_id and db_name(database_id) ='SQLdmRepository'
inner join sys.availability_group_listeners l on l.group_id = s.group_id --and db_name(database_id) ='SOPH_TEST'

