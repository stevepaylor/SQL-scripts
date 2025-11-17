USE master;
GO

-- Rename V1 to original names

ALTER DATABASE ig_app_v1
Modify Name = ig_app ;

ALTER DATABASE ig_business_v1
Modify Name = ig_business ;

ALTER DATABASE ig_dimension_v1 
Modify Name = ig_dimension ;

ALTER DATABASE ig_log_v1
Modify Name = ig_log ;

ALTER DATABASE ig_revconfig_v1 
Modify Name = ig_revconfig ;

ALTER DATABASE ig_task_v1
Modify Name = ig_task ;

ALTER DATABASE ig_transaction_v1 
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
ALTER DATABASE ig_transaction_v1
Modify Name = ig_transaction ;
ALTER DATABASE ig_transaction 
SET MULTI_USER;

ALTER DATABASE it_cfg_v1 
Modify Name = it_cfg ;

ALTER DATABASE it_ga_v1 
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
ALTER DATABASE it_ga_v1
Modify Name = it_ga ;
ALTER DATABASE it_ga 
SET MULTI_USER;

ALTER DATABASE it_perms_v1
Modify Name = it_perms ;

ALTER DATABASE it_rlt_v1
Modify Name = it_rlt ;

ALTER DATABASE it_sysweb_v1 
Modify Name = it_sysweb ;

ALTER DATABASE it_trn_v1
Modify Name = it_trn ;

GO
