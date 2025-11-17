SELECT 'Publisher help'
EXEC sp_replmonitorhelppublisher
  @publisher = 'DWHDB01PR' 
--, @refreshpolicy = refreshpolicy

SELECT 'Subscription Pending CMDs'
EXEC sp_replmonitorsubscriptionpendingcmds 
  @publisher = 'DWHDB01PR'  
, @publisher_db = 'iQ-Gaming'  
, @publication = 'TranRepl_PlayerPortal_on_RDS'  
, @subscriber = '10.16.0.126'  
, @subscriber_db = 'iQ-Gaming-repl'   
, @subscription_type = 0

SELECT 'Subscription Pending CMDs'
EXEC sp_replmonitorsubscriptionpendingcmds
  @publisher = 'DWHDB01PR'  
, @publisher_db = 'iQ-Gaming'  
, @publication = 'TranRepl_PlayerPortal_on_RDS'  
, @subscriber = '10.16.0.126'  
, @subscriber_db = 'iQ-Gaming-repl'   
, @subscription_type = 0

SELECT 'Publisher help'
EXEC sp_replmonitorhelppublisher
  @publisher = 'DWHDB01PR' 
--, @refreshpolicy = refreshpolicy
