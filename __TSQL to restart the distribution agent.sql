-- This script uses sqlcmd scripting variables. They are in the form
-- $(MyVariable). For information about how to use scripting variables  
-- on the command line and in SQL Server Management Studio, see the 
-- "Executing Replication Scripts" section in the topic
-- "Programming Replication Using System Stored Procedures".

DECLARE @subscriptionDB AS sysname;
DECLARE @publication AS sysname;
SET @subscriptionDB = N'iQ-Gaming-repl';
SET @publication = N'TranRepl_PlayerPortal_on_RDS';

USE [AdventureWorks2012Replica]

-- Execute at the Publisher to reinitialize the push subscription.
EXEC sp_reinitsubscription 
    @subscriber = '10.16.0.126',
    @destination_db = @subscriptionDB,
    @publication = @publication;
GO

-- Start the Distribution Agent.

--Distribution Agent - Start /Stop in T-SQL
-- To STOP the Distribution Agent:

sp_MSstopdistribution_agent @publisher, @publisher_db, @publication,
 @subscriber, @subscriber_db

--To START the Distribution Agent:

sp_MSstartdistribution_agent @publisher, @publisher_db, @publication,
 @subscriber, @subscriber_db