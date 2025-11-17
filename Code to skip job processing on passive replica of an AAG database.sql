Step 1: Check for Updateabitity of the DB 

-- if this step succeeds, the job will proceed to the next step (step 2)
-- if this step fails, the job will skip to the final step skipping the processing 
-- Set step to "go to next step" on success and "go to step 3" on failure 

IF DATABASEPROPERTYEX('<db name>', 'Updateability') = 'READ_WRITE'
BEGIN
 PRINT 'Database <db name> is writeable.  Mode is -- ' + CAST(DATABASEPROPERTYEX('<db name>', 'Updateability') AS VARCHAR(20)) + '.  --  processing commands.'
END
ELSE
BEGIN
   -- RAISERROR will cause the step to be seen as failed, triggering skip to final step
   RAISERROR('Database is not writeable.', 11, 1);
END

Step 2:

-- the normal processing step 
-- will get here if step 1 succeeded
-- Set step to "quit job reporting success" on success and "quit the job reporting failure" on failure

Step 3: Print Database not updateable message and exit

-- alternative step instead of step 2 reached only if the database is not READ_WRITE
-- Set step to "quit job reporting success" on success and "quit the job reporting failure" on failure

PRINT 'Database <db name> is not writeable.  Mode is -- ' + CAST(DATABASEPROPERTYEX('<db name>', 'Updateability') AS VARCHAR(20)) + '.  -- Skipped processing.';


