USE msdb;
GO

SELECT *  
FROM sysjobs_view  
WHERE notify_level_page <> 0;
GO
 
SET NOCOUNT ON;
--DECLARE @Operator varchar(50) = 'ITappsDBA' -- place your operator name here
 
SELECT 'EXEC sp_update_job @job_name = ''' + j.[name] + 
	   ''',	@notify_page_operator_name=N'''';'
       
FROM sysjobs_view j
WHERE j.enabled = 1 
AND (j.notify_level_page IS NOT NULL
     OR j.notify_level_page > 0) 
AND j.[name] NOT LIKE 'DBA -%'
GO

-- CMKTDB01qa

--EXEC sp_update_job @job_name = 'Restart Accum Poster job',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'IndexOptimize - USER_DATABASES',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Earned Transactions - Extract For Purge',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Clear CTR Values',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Update SDS Post DTM on Directory',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseBackup - USER_DATABASES - LOG',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DBA - Record DB Connections',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseBackup - USER_DATABASES - DIFF',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Accum Poster - Always Running',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Viejas Reward Manager Promo2',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Auto Settle Prizes',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CommandLog Cleanup',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Accum Reduction - Week',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'sp_purge_jobhistory',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Accum Reduction - Trip',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseIntegrityCheck - SYSTEM_DATABASES',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'RandomWinManager Status Update - Always Running',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Accum Reduction - Day',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Power Promotions Only: Purge Send2',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseBackup - USER_DATABASES - FULL',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Accum Reduction - Quarter',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseIntegrityCheck - USER_DATABASES',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Expire Promo2',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DB Backup.Subplan_1',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Casino Marketplace Offers: Expire Offers',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Update Tags on Templates 2',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Reset CardIn',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Update Tags on Templates',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DBA db backup.Subplan_1',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CasinoTableUtilization',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Accum Reduction - Month',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Output File Cleanup',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseBackup - SYSTEM_DATABASES - FULL',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'PurgetblReceiveSDS2',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'sp_delete_backuphistory',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Accum Reduction - Year',	@notify_page_operator_name=N'';

-- DBAMDB02dv

--EXEC sp_update_job @job_name = 'MSCRM_CONFIG.HardDelete',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'syspolicy_purge_history',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Junket Restore',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'MSCRM_CONFIG.SiteWideCleanup',	@notify_page_operator_name=N'';

-- DBAMDB01dv

--EXEC sp_update_job @job_name = 'Slot Service Birthday Notification Feed',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_23',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_7',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Slot Service Open Event Close',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_1',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'ArchiveIViewOrdering',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Slot Service Clean SDS RS Load',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_13',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_CASIDB01PR_DBAMDB01DV_1',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_3',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_38',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_22',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_5',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_43',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_29',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_CASIDB01PR_DBAMDB01DV_0',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_35',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_14',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_2',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_42',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_30',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Reset_Beverage_Requests',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_17',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_24',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = '0BC7A2A9-FCD6-4361-B4C0-27B73B3C0815',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_45',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = '879FE718-DF09-4044-B932-DA1B855B72DD',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_19',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'PokerTracking_Updates_Player_Name',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_11',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = '080B1082-5C84-47CA-A685-9FFA4632D4D3',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DC7C4F5C-FD8C-4136-8ED4-1E75AABB2365',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'mdw_purge_data_[DBA_DW]',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_33',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'syspolicy_purge_history',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = '579048F9-D8F3-4901-B7BA-F00BB915B074',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'TITLE31_ReconcilePlayerRatings',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_32',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_20',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_12',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_31',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_0',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_21',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_9',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'A3EEC4CD-D187-4011-829C-FA47E652FF52',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_41',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_26',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_40',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_46',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_15',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Delete-Guest-Pictures',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_28',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_10',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_44',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_47',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_39',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_4',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_34',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_8',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_18',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_25',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Slot Service Archive Open Events',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_37',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_36',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_16',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_6',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_27',	@notify_page_operator_name=N'';

--CASIDB21qa

--EXEC sp_update_job @job_name = 'DatabaseBackup - SYSTEM_DATABASES - FULL',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'IndexOptimize - USER_DATABASES',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Output File Cleanup',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'sp_purge_jobhistory',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'sp_delete_backuphistory',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseIntegrityCheck - SYSTEM_DATABASES',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseBackup - USER_DATABASES - FULL',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseBackup - USER_DATABASES - LOG',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'syspolicy_purge_history',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'ASPState_Job_DeleteExpiredSessions',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseIntegrityCheck - USER_DATABASES',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DatabaseBackup - USER_DATABASES - DIFF',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CommandLog Cleanup',	@notify_page_operator_name=N'';

-- DBAMDB01dv

--EXEC sp_update_job @job_name = 'Slot Service Birthday Notification Feed',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_23',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_7',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Slot Service Open Event Close',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_1',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'ArchiveIViewOrdering',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Slot Service Clean SDS RS Load',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_13',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_CASIDB01PR_DBAMDB01DV_1',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_3',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_38',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_22',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_5',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_43',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_29',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_CASIDB01PR_DBAMDB01DV_0',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_35',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_14',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_2',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_42',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_30',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Reset_Beverage_Requests',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_17',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_24',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = '0BC7A2A9-FCD6-4361-B4C0-27B73B3C0815',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_45',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = '879FE718-DF09-4044-B932-DA1B855B72DD',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_19',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'PokerTracking_Updates_Player_Name',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_11',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = '080B1082-5C84-47CA-A685-9FFA4632D4D3',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'DC7C4F5C-FD8C-4136-8ED4-1E75AABB2365',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'mdw_purge_data_[DBA_DW]',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_33',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'syspolicy_purge_history',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = '579048F9-D8F3-4901-B7BA-F00BB915B074',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'TITLE31_ReconcilePlayerRatings',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_32',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_20',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_12',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_31',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_0',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_21',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_9',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'A3EEC4CD-D187-4011-829C-FA47E652FF52',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_41',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_26',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_40',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_46',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_15',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Delete-Guest-Pictures',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_28',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_10',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_44',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_47',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_39',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_4',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_34',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_8',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_18',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_25',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'Slot Service Archive Open Events',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_37',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_36',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_16',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_6',	@notify_page_operator_name=N'';
--EXEC sp_update_job @job_name = 'CDW_DBAMDB01DV_DBAMDB01DV_27',	@notify_page_operator_name=N'';