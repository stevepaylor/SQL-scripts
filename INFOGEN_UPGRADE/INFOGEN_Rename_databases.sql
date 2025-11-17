USE master;
GO

ALTER DATABASE ig_app
Modify Name = ig_app_OLD ;

ALTER DATABASE ig_business
Modify Name = ig_business_OLD ;

ALTER DATABASE ig_dimension 
Modify Name = ig_dimension_OLD ;

ALTER DATABASE ig_log
Modify Name = ig_log_OLD ;

ALTER DATABASE ig_revconfig 
Modify Name = ig_revconfig_OLD ;

ALTER DATABASE ig_task
Modify Name = ig_task_OLD ;

ALTER DATABASE ig_transaction
Modify Name = ig_transaction_OLD ;

ALTER DATABASE it_cfg 
Modify Name = it_cfg_OLD ;

ALTER DATABASE it_ga
Modify Name = it_ga_OLD ;

ALTER DATABASE it_perms
Modify Name = it_perms_OLD ;

ALTER DATABASE it_rlt
Modify Name = it_rlt_OLD ;

ALTER DATABASE it_sysweb 
Modify Name = it_sysweb_OLD ;

ALTER DATABASE it_trn
Modify Name = it_trn_OLD ;

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
Modify Name = ig_transaction ;

ALTER DATABASE it_cfg_v1 
Modify Name = it_cfg ;

ALTER DATABASE it_ga_v1
Modify Name = it_ga ;

ALTER DATABASE it_perms_v1
Modify Name = it_perms ;

ALTER DATABASE it_rlt_v1
Modify Name = it_rlt ;

ALTER DATABASE it_sysweb_v1 
Modify Name = it_sysweb ;

ALTER DATABASE it_trn_v1
Modify Name = it_trn ;

GO
