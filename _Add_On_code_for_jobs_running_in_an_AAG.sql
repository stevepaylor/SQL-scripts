/*** 
This in necessary to allow the job to run and not fail if this is not the PRIMARY REPLICA. 

Make sure that in the job step the database is set to 'master'.  Then add the database name to the command snytax. 
eg. <db-name>.dbo.<proc-name> 
eg. <db-name>.dbo.<table-name>

Don't use the "USE <db_name>" command

***/
IF (SELECT primary_replica 
      FROM sys.dm_hadr_availability_group_states 
	 WHERE primary_recovery_health = 1 
	   AND group_id = (SELECT ag_id FROM sys.dm_hadr_name_id_map  WHERE ag_name = 'CASI24AG01pr')) = @@Servername  -- BE SURE TO CHANGE THE agname
BEGIN
   PRINT 'This is the PRIMARY replica. Processing command(s).';

-- PLACE CODE HERE
-----------------------------------------------------------------------------------------------------------

-- blah
-- blah
-- blah

-----------------------------------------------------------------------------------------------------------
-- END OF USER CODE

SELECT	'Return Value' = @return_value

END
ELSE
BEGIN
   PRINT 'This is a SECONDARY replica. Skipping command(s).';
END