USE [master]
GO
CREATE DATABASE [ig_app] ON 
( FILENAME = N'K:\UserDBdata\ig_app_data.mdf' ),
( FILENAME = N'L:\UserDBlog\ig_app_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [ig_business] ON 
( FILENAME = N'K:\UserDBdata\ig_business_data.mdf' ),
( FILENAME = N'L:\UserDBlog\ig_business_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [ig_dimension] ON 
( FILENAME = N'K:\UserDBdata\ig_dimension_data.mdf' ),
( FILENAME = N'L:\UserDBlog\ig_dimension_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [ig_log] ON 
( FILENAME = N'K:\UserDBdata\ig_log_data.mdf' ),
( FILENAME = N'L:\UserDBlog\ig_log_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [ig_revconfig] ON 
( FILENAME = N'K:\UserDBdata\ig_revconfig_data.mdf' ),
( FILENAME = N'L:\UserDBlog\ig_revconfig_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [ig_task] ON 
( FILENAME = N'K:\UserDBdata\ig_task_data.mdf' ),
( FILENAME = N'L:\UserDBlog\ig_task_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [ig_transaction] ON 
( FILENAME = N'K:\UserDBdata\ig_transaction_data.mdf' ),
( FILENAME = N'L:\UserDBlog\ig_transaction_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [it_cfg] ON 
( FILENAME = N'K:\UserDBdata\it_cfg_data.mdf' ),
( FILENAME = N'L:\UserDBlog\it_cfg_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [it_ga] ON 
( FILENAME = N'K:\UserDBdata\it_ga_data.mdf' ),
( FILENAME = N'L:\UserDBlog\it_ga_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [it_perms] ON 
( FILENAME = N'K:\UserDBdata\it_perms_data.mdf' ),
( FILENAME = N'L:\UserDBlog\it_perms_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [it_rlt] ON 
( FILENAME = N'K:\UserDBdata\it_rlt_data.mdf' ),
( FILENAME = N'L:\UserDBlog\it_rlt_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [it_sysweb] ON 
( FILENAME = N'K:\UserDBdata\it_sysweb_data.mdf' ),
( FILENAME = N'L:\UserDBlog\it_sysweb_log.ldf' )
 FOR ATTACH
GO

USE [master]
GO
CREATE DATABASE [it_trn] ON 
( FILENAME = N'K:\UserDBdata\it_trn_data.mdf' ),
( FILENAME = N'L:\UserDBlog\it_trn_log.ldf' )
 FOR ATTACH
GO
