--Technorati Tags: Tracer Token

--— When latency is observed, use commands below to
--—     insert a new tracer token in the publication database
--—     every 1 minute.

WHILE (1=1)

BEGIN

       EXEC sys.sp_posttracertoken

       @publication = 'TranRepl_PlayerPortal_on_RDS'

       --— Wait 1 minute

       WAITFOR DELAY '00:01:00'

END