--====================================
--  Create database trigger template 
--====================================
USE AdventureWorksLT2019
GO

IF EXISTS(
  SELECT *
    FROM sys.triggers
   WHERE name = N'CustomerLiteTrigger'
     AND parent_class_desc = N'DATABASE'
)
	DROP TRIGGER CustomerLiteTrigger ON DATABASE
GO

CREATE TRIGGER CustomerLiteTrigger ON DATABASE 
	FOR <data_definition_statements, , DROP_TABLE, ALTER_TABLE> 
AS 
IF IS_MEMBER ('db_owner') = 0
BEGIN
   PRINT 'You must ask your DBA to drop or alter tables!' 
   ROLLBACK TRANSACTION
END
GO


