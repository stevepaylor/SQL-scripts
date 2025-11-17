USE master;
GO

-- Rename original databasesto _OLD

--ALTER DATABASE ig_app
--Modify Name = ig_app_OLD ;

--ALTER DATABASE ig_business 
--SET SINGLE_USER
--WITH ROLLBACK IMMEDIATE;
--ALTER DATABASE ig_business
--Modify Name = ig_business_OLD ;
ALTER DATABASE ig_business_OLD 
SET MULTI_USER;


ALTER DATABASE ig_dimension 
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
ALTER DATABASE ig_dimension 
Modify Name = ig_dimension_OLD ;
ALTER DATABASE ig_dimension_OLD 
SET MULTI_USER;

--ALTER DATABASE ig_log
--Modify Name = ig_log_OLD ;

--ALTER DATABASE ig_revconfig 
--Modify Name = ig_revconfig_OLD ;

--ALTER DATABASE ig_task
--Modify Name = ig_task_OLD ;

--ALTER DATABASE ig_transaction
--Modify Name = ig_transaction_OLD ;

--ALTER DATABASE it_cfg 
--Modify Name = it_cfg_OLD ;
ALTER DATABASE it_cfg 
SET MULTI_USER

--ALTER DATABASE it_ga
--Modify Name = it_ga_OLD ;

ALTER DATABASE it_perms 
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
ALTER DATABASE it_perms
Modify Name = it_perms_OLD ;
--ALTER DATABASE it_perms_OLD 
--SET MULTI_USER;

--ALTER DATABASE it_rlt
--Modify Name = it_rlt_OLD ;

ALTER DATABASE it_sysweb 
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
ALTER DATABASE it_sysweb 
Modify Name = it_sysweb_OLD ;
ALTER DATABASE it_sysweb_OLD 
SET MULTI_USER;

ALTER DATABASE it_trn 
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
ALTER DATABASE it_trn
Modify Name = it_trn_OLD ;
ALTER DATABASE it_trn_OLD 
SET MULTI_USER;

GO
