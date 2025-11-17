
 

USE [iQ-Gaming]
GO

DECLARE @Publication_Name NVARCHAR(50) = 'TranRepl_PlayerPortal_QA_RDS'
--DECLARE @Publication_Name NVARCHAR(50) = 'TranRepl_PlayerPortal_PROD_RDS'

EXEC sp_changepublication @publication = @Publication_Name, @property = N'allow_anonymous', @value = 'false'

EXEC sp_changepublication @publication = @Publication_Name, @property = N'immediate_sync', @value = 'false'


exec sp_addarticle @publication = @Publication_Name, @article = N'tCasino', @source_owner = N'CMP_13-1', @source_object = N'tCasino', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tCasino', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tCasino]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tCasino]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tCasino]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tCountry', @source_owner = N'CMP_13-1', @source_object = N'tCountry', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tCountry', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tCountry]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tCountry]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tCountry]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tState', @source_owner = N'CMP_13-1', @source_object = N'tState', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tState', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tState]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tState]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tState]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tPlayer', @source_owner = N'CMP_13-1', @source_object = N'tPlayer', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tPlayer', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tPlayer]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tPlayer]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tPlayer]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tPlayerAddress', @source_owner = N'CMP_13-1', @source_object = N'tPlayerAddress', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tPlayerAddress', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tPlayerAddress]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tPlayerAddress]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tPlayerAddress]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tPlayerEmail', @source_owner = N'CMP_13-1', @source_object = N'tPlayerEmail', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tPlayerEmail', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tPlayerEmail]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tPlayerEmail]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tPlayerEmail]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tPlayerCard', @source_owner = N'CMP_13-1', @source_object = N'tPlayerCard', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tPlayerCard', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tPlayerCard]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tPlayerCard]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tPlayerCard]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tPlayerCasino', @source_owner = N'CMP_13-1', @source_object = N'tPlayerCasino', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tPlayerCasino', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tPlayerCasino]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tPlayerCasino]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tPlayerCasino]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tPlayerAttributeDtl', @source_owner = N'CMP_13-1', @source_object = N'tPlayerAttributeDtl', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tPlayerAttributeDtl', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tPlayerAttributeDtl]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tPlayerAttributeDtl]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tPlayerAttributeDtl]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tPlayerCasinoHost', @source_owner = N'CMP_13-1', @source_object = N'tPlayerCasinoHost', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tPlayerCasinoHost', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tPlayerCasinoHost]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tPlayerCasinoHost]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tPlayerCasinoHost]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tGroup', @source_owner = N'CMP_13-1', @source_object = N'tGroup', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tGroup', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tGroup]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tGroup]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tGroup]', @force_invalidate_snapshot = 1

exec sp_addarticle @publication = @Publication_Name, @article = N'tPlayerGroup', @source_owner = N'CMP_13-1', @source_object = N'tPlayerGroup', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'tPlayerGroup', @destination_owner = N'CMP_13-1', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_CMP_13-1tPlayerGroup]', @del_cmd = N'CALL [sp_MSdel_CMP_13-1tPlayerGroup]', @upd_cmd = N'SCALL [sp_MSupd_CMP_13-1tPlayerGroup]', @force_invalidate_snapshot = 1


EXEC sp_refreshsubscriptions @publication = @Publication_Name

EXEC sp_changepublication @publication = @Publication_Name, @property = N'allow_anonymous', @value = 'true'

EXEC sp_changepublication @publication = @Publication_Name, @property = N'immediate_sync', @value = 'true'

