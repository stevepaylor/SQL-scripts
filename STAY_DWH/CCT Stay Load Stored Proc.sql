USE [VendorDataWarehouse]
GO

/****** Object:  StoredProcedure [Agilysys_Stay_V1].[spStoreData_Agilysys_Stay_V1]    Script Date: 4/30/2024 3:16:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Agilysys_Stay_V1].[spStoreData_Agilysys_Stay_V1]

--Declare
	 @SourceSystemId	SMALLINT
	,@SourceSystemLogId	INT = NULL
AS

/*
Exec Agilysys_Stay_V1.spStoreData_Agilysys_Stay_V1 @SourceSystemId = 2, @SourceSystemLogId = Null
*/

BEGIN 
SET NOCOUNT ON

---------------------------------------------------------------
/* When running this we want to be able to create log events */
---------------------------------------------------------------
DECLARE @CurrentTime		DATETIME = CURRENT_TIMESTAMP
DECLARE @SqlTemplate		NVARCHAR(MAX)
DECLARE @Sql			NVARCHAR(MAX)
DECLARE @InsertSql		NVARCHAR(MAX)
DECLARE @AdditionalParameters	NVARCHAR(MAX)

DECLARE @RowCount		INT
DECLARE @ErrorCode		INT
DECLARE @ErrorCodeReturn	INT
DECLARE @ErrorMessage		NVARCHAR(MAX)
DECLARE @IsError		BIT
DECLARE @StartDate		DATETIME
DECLARE @Description		NVARCHAR(MAX)

/* Declare and get source system keys */
DECLARE @Key_transaction_item_revenue_aggregate	DATETIME

EXECUTE [dbo].[spLoadData_GetKeyDateTime]
	@SourceSystemId	= @SourceSystemId
	,@TableName	= 'transaction_item_revenue_aggregate'
	,@ColumnName	= 'Date'
	,@Key		= @Key_transaction_item_revenue_aggregate OUT

DECLARE @Key_properties	DATETIME

EXECUTE [dbo].[spLoadData_GetKeyDateTime]
	@SourceSystemId	= @SourceSystemId
	,@TableName	= 'properties'
	,@ColumnName	= 'create_time'
	,@Key		= @Key_properties OUT

DECLARE @Key_reservations	DATETIME

EXECUTE [dbo].[spLoadData_GetKeyDateTime]
	@SourceSystemId	= @SourceSystemId
	,@TableName	= 'reservations'
	,@ColumnName	= 'create_time'
	,@Key		= @Key_reservations OUT

DECLARE @Key_guests	DATETIME

EXECUTE [dbo].[spLoadData_GetKeyDateTime]
	@SourceSystemId	= @SourceSystemId
	,@TableName	= 'guests'
	,@ColumnName	= 'create_time'
	,@Key		= @Key_guests OUT

DECLARE @Key_groups	DATETIME

EXECUTE [dbo].[spLoadData_GetKeyDateTime]
	@SourceSystemId	= @SourceSystemId
	,@TableName	= 'groups'
	,@ColumnName	= 'create_time'
	,@Key		= @Key_groups OUT

DECLARE @Key_rooms	DATETIME

EXECUTE [dbo].[spLoadData_GetKeyDateTime]
	@SourceSystemId	= @SourceSystemId
	,@TableName	= 'rooms'
	,@ColumnName	= 'create_time'
	,@Key		= @Key_rooms OUT

---------------------------------------------------------------------------------------
/* Create temp tables specific to source system */
---------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#transaction_item_revenue_aggregate') IS NULL
	CREATE TABLE #transaction_item_revenue_aggregate
	(
		Idnty			Int Identity(1,1)		Not Null
		,tax_included		Bit				Null		
		,[date]			Date				Null
		,tenant_id		Nvarchar(Max)			Null
		,property_id		Nvarchar(Max)			Null
		,item_name		Nvarchar(Max)			Null
		,item_code		Nvarchar(Max)			Null
		,category		Nvarchar(Max)			Null
		,sub_category		Nvarchar(Max)			Null
		,ledger_name		Nvarchar(Max)			Null
		,net_amount		Decimal(19,8)				Null
		,tax			Decimal(19,8)				Null
		,gross_amount		Decimal(19,8)			Null
		,transaction_type	Nvarchar(Max)			Null
		,room_revenue		Bit				Null
		,item_id		Nvarchar(Max)			Null
		,category_id		Nvarchar(Max)			Null
		,sub_category_id	Nvarchar(Max)			Null
		,last_updated_at	Datetimeoffset			Null
		,historic		Bit				Null
		,vat_amount		Decimal(19,8)			Null
		,vat			Bit				Null
		,[user_name]		Nvarchar(Max)			Null
		,no_of_line_items	Decimal(19,8)			Null
	)

IF OBJECT_ID('tempdb..#transaction_item_revenue_aggregate_AggregatedPerDayDimensions') IS NULL
	CREATE TABLE #transaction_item_revenue_aggregate_AggregatedPerDayDimensions
	(
		Idnty			Int Identity(1,1)		Not Null
		,[date]			Date				Null
		,tenant_id		Nvarchar(Max)			Null
		,property_id		Nvarchar(Max)			Null
		,category		Nvarchar(Max)			Null
		,sub_category		Nvarchar(Max)			Null
		,[user_name]		Nvarchar(Max)			Null
		,ledger_name		Nvarchar(Max)			Null
		,tax			Decimal(19,8)			Null
		,gross_amount		Decimal(19,8)			Null
		,net_amount		Decimal(19,8)			Null
	)


IF OBJECT_ID('tempdb..#properties') IS NULL
	CREATE TABLE #properties
	(
		Idnty				Int Identity(1,1)		Not Null
		,id				Nvarchar(Max)			Null
		,check_in_time			time				Null
		,checkout_time			time				Null
		,create_time			DateTime2			Null
		,is_deleted			Bit				Null
		,tenant_id			Nvarchar(Max)			Null
		,time_zone			Nvarchar(Max)			Null
		,update_time			DateTime2			Null
		,accounting_style_required	Bit				Null
		,production_property		Bit				Null
		,first_room_stay_at		DateTime2			Null
		,first_reservation_created_at	DateTime2			Null
		,first_room_charge_at		DateTime2			Null
		,recent_room_stay_at		DateTime2			Null
		,recent_room_charge_at		DateTime2			Null
		,recent_reservation_created_at	DateTime2			Null
		,tenant_name			Nvarchar(Max)			Null
		,property_name			Nvarchar(Max)			Null
		,tenant_code			Nvarchar(Max)			Null
		,property_code			Nvarchar(Max)			Null
		,[language]			Nvarchar(Max)			Null
		,country			Nvarchar(Max)			Null
		,currency_code			Nvarchar(Max)			Null
		,long_date_format		Nvarchar(Max)			Null
		,short_date_format		Nvarchar(Max)			Null
		,time_format			Nvarchar(Max)			Null
		,clock_type			Nvarchar(Max)			Null
		,locale_code			Bit				Null
		,content_date_format		Nvarchar(Max)			Null
		,content_time_format		Nvarchar(Max)
	)


IF OBJECT_ID('tempdb..#reservations') IS NULL
	CREATE TABLE #reservations
	(
		Idnty						Int Identity(1,1)		Not Null
		,do_not_move_room				Bit				Null
		,cancellation_time_utc				DateTime2			Null
		,id						Nvarchar(Max)			Null
		,account_id					Nvarchar(Max)			Null
		,allocation_id					Nvarchar(Max)			Null
		,arrival_date					date				Null
		,cancellation_date				date				Null
		,confirmation_code				Nvarchar(Max)			Null
		,create_time					DateTime2			Null
		,departure_date					date				Null
		,early_arrival					Bit				Null
		,number_of_adults				integer				Null
		,number_of_children				integer				Null
		,primary_guest_first_name			Nvarchar(Max)			Null
		,primary_guest_last_name			Nvarchar(Max)			Null
		,property_id					Nvarchar(Max)			Null
		,reservation_alias				Nvarchar(Max)			Null
		,[status]					Nvarchar(Max)			Null
		,tenant_id					Nvarchar(Max)			Null
		,guest_type_id					Nvarchar(Max)			Null
		,market_segment_id				Nvarchar(Max)			Null
		,source_of_business_id				Nvarchar(Max)			Null
		,update_time					DateTime2			Null
		,company_id					Nvarchar(Max)			Null
		,group_id					Nvarchar(Max)			Null
		,vip_status_id					Nvarchar(Max)			Null
		,non_registered_guest				Bit				Null
		,walk_in					Bit				Null
		,cancellation_policy_id				Nvarchar(Max)			Null
		,deposit_policy_id				Nvarchar(Max)			Null
		,cancellation_policy_overridden_by		Nvarchar(Max)			Null
		,cancellation_policy_overridden_amount		Decimal(19,8)				Null
		,cancellation_policy_overridden_percentage	Decimal(19,8)				Null
		,overridden_cancellation_policy_id		Nvarchar(Max)			Null
		,estimated_time_of_arrival			DateTime2			Null
		,estimated_time_of_departure			DateTime2			Null
		,suppress_rate					Bit				Null
		,booker_id					Nvarchar(Max)			Null
		,booked_by					Nvarchar(Max)			Null
		,primary_guest_id				Nvarchar(Max)			Null
		,cancellation_code				Nvarchar(Max)			Null
		,cancellation_reason				Nvarchar(Max)			Null
		,cancelled_by					Nvarchar(Max)			Null
		,agent_ids					Varchar(200)			Null
		,early_check_in_time				Time				Null
		,late_checkout_time				Time				Null
		,web_check_in					Bit				Null
		,no_of_documents				integer				Null
		,share_id					Nvarchar(Max)			Null
		,no_of_pets					integer				Null
		,web_check_out					Bit				Null
		,room_ready_sms_enabled				Bit				Null
		,web_check_in_sms_enabled			Bit				Null
		,web_check_out_sms_enabled			Bit				Null
		,room_feature_preference_names			Varchar(200)			Null
		,number_of_guests				integer				Null
		,guest_preference_ids				Varchar(200)			Null
		,housekeeping_pattern_id			Nvarchar(Max)			Null
		,red_eye_arrival_guest_arrival_date		date				Null
		,red_eye_arrival_estimated_time_of_arrival	DateTime2			Null
		,red_eye_arrival_status				Nvarchar(Max)			Null
		,checkin_at					DateTime2			Null
		,checkin_by					Nvarchar(Max)			Null
		,checkout_at					DateTime2			Null
		,checkout_by					Nvarchar(Max)			Null
		,do_not_move_reason_description			Nvarchar(Max)			Null
		,do_not_move_reason_date_time			DateTime2			Null
		,do_not_move_reason_updated_by			Nvarchar(Max)			Null
		,do_not_move_reason_id				Nvarchar(Max)			Null
		,deposit_policy_amount				Decimal(19,8)				Null
		,deposit_policy_tax				Decimal(19,8)				Null
		,number_of_age_category1			integer				Null
		,number_of_age_category2			integer				Null
		,deposit_total_due				Decimal(19,8)				Null
		,_export_ts					DateTime2			Null
		,source_interface_id				Nvarchar(Max)			Null
		,auto_check_in					Nvarchar(Max)			Null
		,digital_key_status				Nvarchar(Max)			Null
		,physical_key_status				Nvarchar(Max)			Null
		,disclose_room_type				Bit				Null
		,check_in_type					Nvarchar(Max)			Null
		,check_out_type					Nvarchar(Max)			Null
		,check_in					Bit				Null
		,check_out					Bit				Null
		,old_room_type_id				Nvarchar(Max)			Null
		,old_pms_confirmation_code			Nvarchar(Max)			Null
		,comp_overridden				Bit				Null
		,comp_overridden_user				Nvarchar(Max)			Null
		,player_id					Nvarchar(Max)			Null
		,commission_percentage				Decimal(19,8)				Null
		,moved_status					Bit				Null
		,override_policy_amount				Decimal(19,8)				Null
		,original_policy_amount				Decimal(19,8)				Null
		,cancellation_fee_amount			Decimal(19,8)				Null
		,cancellation_amount_charged			Decimal(19,8)				Null
		,cancellation_policy_overridden_datetime	DateTime2			Null
		,cancellation_policy_override_reason		Nvarchar(Max)			Null
		,original_cancellation_policy			Nvarchar(Max)			Null
		,guest_requested_ada_room_type			Bit				Null
		,guest_requested_connecting_room_type		Bit				Null
		,ada_room_assigned				Bit				Null
		,connecting_room_assigned			Bit				Null
		,room_assignment_result				Nvarchar(Max)			Null
		,existing_user_name				Nvarchar(Max)			Null
		,overriding_user_name				Nvarchar(Max)			Null
		,created_date_time				DateTime2			Null
		,_export_create_ts				datetimeoffset			Null
		,_export_update_ts				datetimeoffset			Null
		,number_of_age_category3			integer				Null
		,number_of_age_category4			integer				Null
		,number_of_age_category5			integer				Null
		,number_of_age_category6			integer				Null
		,number_of_age_category7			integer				Null
		,number_of_age_category8			integer				Null
	)


IF OBJECT_ID('tempdb..#groups') IS NULL
	CREATE TABLE #groups
	(
		Idnty					Int Identity(1,1)		Not Null
		,id					Nvarchar(Max) 			Null
		,account_id				Nvarchar(Max) 			Null
		,adults_included			integer				Null
		,allocation_id				Nvarchar(Max) 			Null
		,booking_status				Nvarchar(Max) 			Null
		,cancellation_policy_id			Nvarchar(Max) 			Null
		,children_included			integer				Null
		,create_time				Date				Null
		,deposit_policy_id			Nvarchar(Max) 			Null
		,end_date				date				Null
		,extra_adult_charge			Decimal(19,8)				Null
		,extra_children_charge			Decimal(19,8)				Null
		,group_code				Nvarchar(Max) 			Null
		,group_name				Nvarchar(Max) 			Null
		,guest_type_id				Nvarchar(Max) 			Null
		,market_segment_id			Nvarchar(Max) 			Null
		,profile_id				Nvarchar(Max) 			Null
		,property_id				Nvarchar(Max) 			Null
		,source_of_business_id			Nvarchar(Max) 			Null
		,[start_date]				date				Null
		,tax_exempt				Bit				Null
		,tenant_id				Nvarchar(Max) 			Null
		,update_time				Date	Null
		,rate_plan_id				Nvarchar(Max) 			Null
		,shoulder_end_date			date				Null
		,shoulder_start_date			date				Null
		,transaction_item_id			Nvarchar(Max) 			Null
		,confirmation_code			Nvarchar(Max) 			Null
		,released				Bit				Null
		,profile_type				Nvarchar(Max) 			Null
		,[description]				Nvarchar(Max) 			Null
		,rolling_release_enabled		Bit				Null
		,auto_release_enabled			Bit				Null
		,cut_off_date				date				Null
		,departure_date				date				Null
		,housing_restricted			Bit				Null
		,room_blocks_for_shoulder_dates		Bit				Null
		,allocate_blocks_for_shoulder_dates	Bit				Null
		,overridden_arc_rule_id			Nvarchar(Max) 			Null
		,wholesaler				Bit				Null
	)

IF OBJECT_ID('tempdb..#guests') IS NULL
	CREATE TABLE #guests
	(
		Idnty			Int Identity(1,1)		Not Null
		,code			Nvarchar(Max)			Null
		,id			Nvarchar(Max)			Null
		,tenant_id		Nvarchar(Max)			Null
		,anonymized		Bit				Null
		,anonymized_message	Nvarchar(Max)			Null
		,create_time		DateTime2			Null
		,update_time		DateTime2			Null
		,archived		Bit				Null
		,external_profile_id	Nvarchar(Max)			Null
		,first_name		Nvarchar(Max)			Null
		,last_name		Nvarchar(Max)			Null
		,anniversary		date				Null
		,birth_date		date				Null
		,middle_initial		Nvarchar(Max)			Null
		,suffix			Nvarchar(Max)			Null
		,title			Nvarchar(Max)			Null
		,company_title		Nvarchar(Max)			Null
		,pronunciation		Nvarchar(Max)			Null
		,gender			Nvarchar(Max)			Null
		,[language]		Nvarchar(Max)			Null
		,alias			Nvarchar(Max)			Null
		,company_name		Nvarchar(Max)			Null
		,[type]			Nvarchar(Max)			Null
		,player_id		Nvarchar(Max)			Null
		,cms_type		Nvarchar(Max)			Null
		,card_id_available	Bit				Null
		,gps_id			Nvarchar(Max)			Null
		,opt_in_for_marketing	Bit				Null
		,merge_remnant		Bit				Null
	)



IF OBJECT_ID('tempdb..#rooms') IS NULL
	CREATE TABLE #rooms
	(
		Idnty				Int Identity(1,1)		Not Null
		,id				Varchar(Max)			Null
		,is_ada				Bit				Null
		,last_sell			Bit				Null
		,reset_value			integer				Null
		,rack_number			integer				Null
		,room_number			Varchar(Max)			Null
		,room_type_id			Varchar(Max)			Null
		,building_id			Varchar(Max)			Null
		,floor_id			Varchar(Max)			Null
		,create_time			DateTime			Null
		,property_id			Varchar(Max)			Null
		,tenant_id			Varchar(Max)			Null
		,update_time			DateTime			Null
		,total_days_occupied		integer				Null
		,housekeeping_room_condition	Varchar(Max)			Null
		,occupancy_status		Varchar(Max)			Null
		,[start_date]			date				Null
		,end_date			date				Null
		,suite				Bit				Null
		,[description]			Varchar(Max)			Null
		,connecting_room_ids		Varchar(200)			Null
		,no_of_associated_rooms		integer				Null
	)

IF OBJECT_ID('tempdb..#room_classes') IS NULL
	CREATE TABLE #room_classes
	(
		Idnty				Int Identity(1,1)		Not Null
		,id				Varchar(Max)			Null
		,[name]				Varchar(Max)			Null
		,active				Bit				Null
		,tenant_id			Varchar(Max)			Null
		,property_id			Varchar(Max)			Null
		,[rank]				Int				Null
	)

IF OBJECT_ID('tempdb..#room_types') IS NULL
Begin
	Create Table #room_types
	(
		Idnty				Int Identity(1,1)		Not Null
		,id				Varchar(Max)			Null
		,[name]				Varchar(Max)			Null
		,type_code			Varchar(Max)			Null
		,housekeeping_pattern_id	Varchar(Max)			Null
		,is_ada				Bit				Null
		,is_virtual			Bit				Null
		,max_guests			integer				Null
		,max_pets			integer				Null
		,non_bedded			Bit				Null
		,default_building_id		Varchar(Max)			Null
		,pets				Bit				Null
		,property_id			Varchar(Max)			Null
		,room_class_id			Varchar(Max)			Null
		,tenant_id			Varchar(Max)			Null
		,is_roh				Bit				Null
		,[description]			Varchar(Max)			Null
		,smoking_allowed		Bit				Null
		,bed_ids			Varchar(200)			Null
		,suite				Bit				Null
	)
End

-----------------------------------------------
/* Begin inserts into temporary opera tables */
-----------------------------------------------

/* transaction_item_revenue_aggregate */
SELECT @SqlTemplate = N'
SELECT	Case When tax_included	Then 1 Else 0 End tax_included
       ,date		
       ,tenant_id	
       ,property_id	
       ,item_name	
       ,item_code	
       ,category	
       ,sub_category	
       ,ledger_name	
       ,net_amount	
       ,tax		
       ,gross_amount	
       ,transaction_type
       ,room_revenue	
       ,item_id	
       ,category_id	
       ,sub_category_id
       ,last_updated_at
       ,historic	
       ,vat_amount	
       ,vat		
       ,user_name	
       ,no_of_line_items
FROM {Database}.public.transaction_item_revenue_aggregate
{Criteria}'

SELECT @InsertSql = N'
INSERT #transaction_item_revenue_aggregate (
	tax_included	
       ,date		
       ,tenant_id	
       ,property_id	
       ,item_name	
       ,item_code	
       ,category	
       ,sub_category	
       ,ledger_name	
       ,net_amount	
       ,tax		
       ,gross_amount	
       ,transaction_type
       ,room_revenue	
       ,item_id	
       ,category_id	
       ,sub_category_id
       ,last_updated_at
       ,historic	
       ,vat_amount	
       ,vat		
       ,[user_name]	
       ,no_of_line_items
	)'

SELECT @AdditionalParameters = N'@Key_transaction_item_revenue_aggregate [DATETIME] = ' + CONVERT(VARCHAR(MAX), @Key_transaction_item_revenue_aggregate, 120)

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE transaction_item_revenue_aggregate.Date >= TO_DATE(@Key_transaction_item_revenue_aggregate,''YYYY-MM-DD'')
')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #transaction_item_revenue_aggregate (Date)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE transaction_item_revenue_aggregate.last_updated_at >= TO_DATE(@Key_transaction_item_revenue_aggregate,''YYYY-MM-DD'')
And	transaction_item_revenue_aggregate.Date < TO_DATE(@Key_transaction_item_revenue_aggregate, ''YYYY-MM-DD'')
')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #transaction_item_revenue_aggregate (last_update_at)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

--Aggregating data due to not having unique identifiers in the transaction table
Insert #transaction_item_revenue_aggregate_AggregatedPerDayDimensions
(
	[date]		
	,property_id	
	,category	
	,sub_category
	,ledger_name
	,[user_name]
	,tenant_id
	,tax		
	,gross_amount		
	,net_amount
)
Select	[date]
	,property_id
	,category
	,sub_category
	,ledger_name
	,[user_name]
	,tenant_id
	,Sum(tax)
	,Sum(gross_amount)
	,Sum(net_amount)
From	#transaction_item_revenue_aggregate
Group By [date]
	,property_id
	,category
	,sub_category
	,ledger_name
	,[user_name]
	,tenant_id

SELECT @Description = 'Insert #transaction_item_revenue_aggregate_AggregatedPerDayDimensions'
	,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
	,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
	,@Description = @Description, @DescriptionReturn = @Description OUT
IF @ErrorCodeReturn <> 0 GOTO ERROR

/* properties */
SELECT @SqlTemplate = N'
SELECT	id				
	,check_in_time			
	,checkout_time			
	,create_time			
	,is_deleted			
	,tenant_id			
	,time_zone			
	,update_time			
	,accounting_style_required	
	,production_property		
	,first_room_stay_at		
	,first_reservation_created_at	
	,first_room_charge_at		
	,recent_room_stay_at		
	,recent_room_charge_at		
	,recent_reservation_created_at	
	,tenant_name			
	,property_name			
	,tenant_code			
	,property_code			
	,language			
	,country			
	,currency_code			
	,long_date_format		
	,short_date_format		
	,time_format			
	,clock_type			
	,locale_code			
	,content_date_format		
	,content_time_format		
FROM {Database}.public.properties
{Criteria}'

SELECT @InsertSql = N'
INSERT #properties 
(
	id				
	,check_in_time			
	,checkout_time			
	,create_time			
	,is_deleted			
	,tenant_id			
	,time_zone			
	,update_time			
	,accounting_style_required	
	,production_property		
	,first_room_stay_at		
	,first_reservation_created_at	
	,first_room_charge_at		
	,recent_room_stay_at		
	,recent_room_charge_at		
	,recent_reservation_created_at	
	,tenant_name			
	,property_name			
	,tenant_code			
	,property_code			
	,language		
	,country			
	,currency_code			
	,long_date_format		
	,short_date_format		
	,time_format			
	,clock_type			
	,locale_code			
	,content_date_format		
	,content_time_format	
)'

SELECT @AdditionalParameters = N'@Key_properties [DATETIME] = ' + CONVERT(VARCHAR(MAX), @Key_properties, 120)

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE properties.create_time >= TO_DATE(@Key_properties,''YYYY-MM-DD'')
')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #properties (create_time)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE properties.update_time >= TO_DATE(@Key_properties,''YYYY-MM-DD'')
And	properties.create_time < TO_DATE(@Key_properties, ''YYYY-MM-DD'')

')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #properties (update_time)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

/* reservations */
SELECT @SqlTemplate = N'
SELECT	Case When do_not_move_room Then 1 Else 0 End do_not_move_room			
	,cancellation_time_utc				
	,id						
	,account_id					
	,allocation_id					
	,arrival_date					
	,cancellation_date				
	,confirmation_code				
	,create_time					
	,departure_date					
	,Case When early_arrival Then 1 Else 0 End early_arrival 					
	,number_of_adults				
	,number_of_children				
	,primary_guest_first_name			
	,primary_guest_last_name			
	,property_id					
	,reservation_alias				
	,status					
	,tenant_id					
	,guest_type_id					
	,market_segment_id				
	,source_of_business_id				
	,update_time					
	,company_id					
	,group_id					
	,vip_status_id					
	,Case When non_registered_guest	Then 1 Else 0 End non_registered_guest			
	,Case When walk_in Then 1 Else 0 End walk_in				
	,cancellation_policy_id				
	,deposit_policy_id				
	,cancellation_policy_overridden_by		
	,cancellation_policy_overridden_amount		
	,cancellation_policy_overridden_percentage	
	,overridden_cancellation_policy_id		
	,estimated_time_of_arrival			
	,estimated_time_of_departure			
	,Case When suppress_rate Then 1 Else 0 End suppress_rate					
	,booker_id					
	,booked_by					
	,primary_guest_id				
	,cancellation_code				
	,cancellation_reason				
	,cancelled_by					
	,CAST(array_to_string(agent_ids, '' , ''''*'') as varchar(200)) as agent_ids 					
	,early_check_in_time				
	,late_checkout_time				
	,Case When web_check_in Then 1 Else 0 End web_check_in				
	,no_of_documents				
	,share_id					
	,no_of_pets					
	,Case When web_check_out Then 1 Else 0 End web_check_out					
	,Case When room_ready_sms_enabled Then 1 Else 0 End room_ready_sms_enabled				
	,Case When web_check_in_sms_enabled Then 1 Else 0 End web_check_in_sms_enabled		
	,Case When web_check_out_sms_enabled Then 1 Else 0 End web_check_out_sms_enabled		
	,CAST(array_to_string(room_feature_preference_names, '' , ''''*'') as varchar(200)) as room_feature_preference_names 
	,number_of_guests				
	,CAST(array_to_string(guest_preference_ids, '' , ''''*'') as varchar(200)) as guest_preference_ids 
	,housekeeping_pattern_id			
	,red_eye_arrival_guest_arrival_date		
	,red_eye_arrival_estimated_time_of_arrival	
	,red_eye_arrival_status				
	,checkin_at					
	,checkin_by					
	,checkout_at					
	,checkout_by					
	,do_not_move_reason_description			
	,do_not_move_reason_date_time			
	,do_not_move_reason_updated_by			
	,do_not_move_reason_id				
	,deposit_policy_amount				
	,deposit_policy_tax				
	,number_of_age_category1			
	,number_of_age_category2			
	,deposit_total_due				
	,_export_ts					
	,source_interface_id				
	,auto_check_in					
	,digital_key_status				
	,physical_key_status				
	,Case When disclose_room_type Then 1 Else 0 End	disclose_room_type		
	,check_in_type					
	,check_out_type					
	,Case When check_in	Then 1 Else 0 End check_in				
	,Case When check_out	Then 1 Else 0 End check_out				
	,old_room_type_id				
	,old_pms_confirmation_code			
	,Case When comp_overridden Then 1 Else 0 End comp_overridden			
	,comp_overridden_user				
	,player_id					
	,commission_percentage				
	,Case When moved_status Then 1 Else 0 End moved_status			
	,override_policy_amount				
	,original_policy_amount				
	,cancellation_fee_amount			
	,cancellation_amount_charged			
	,cancellation_policy_overridden_datetime	
	,cancellation_policy_override_reason		
	,original_cancellation_policy			
	,Case When guest_requested_ada_room_type		Then 1 Else 0 End guest_requested_ada_room_type		
	,Case When guest_requested_connecting_room_type		Then 1 Else 0 End guest_requested_connecting_room_type
	,Case When ada_room_assigned				Then 1 Else 0 End ada_room_assigned
	,Case When connecting_room_assigned			Then 1 Else 0 End connecting_room_assigned
	,room_assignment_result				
	,existing_user_name				
	,overriding_user_name				
	,created_date_time				
	,_export_create_ts				
	,_export_update_ts				
	,number_of_age_category3			
	,number_of_age_category4			
	,number_of_age_category5			
	,number_of_age_category6			
	,number_of_age_category7			
	,number_of_age_category8			
FROM {Database}.public.reservations
{Criteria}'

SELECT @InsertSql = N'
INSERT #reservations 
(
	do_not_move_room				
	,cancellation_time_utc				
	,id						
	,account_id					
	,allocation_id					
	,arrival_date					
	,cancellation_date				
	,confirmation_code				
	,create_time					
	,departure_date					
	,early_arrival					
	,number_of_adults				
	,number_of_children				
	,primary_guest_first_name			
	,primary_guest_last_name			
	,property_id					
	,reservation_alias				
	,status					
	,tenant_id					
	,guest_type_id					
	,market_segment_id				
	,source_of_business_id				
	,update_time					
	,company_id					
	,group_id					
	,vip_status_id					
	,non_registered_guest				
	,walk_in					
	,cancellation_policy_id				
	,deposit_policy_id				
	,cancellation_policy_overridden_by		
	,cancellation_policy_overridden_amount		
	,cancellation_policy_overridden_percentage	
	,overridden_cancellation_policy_id		
	,estimated_time_of_arrival			
	,estimated_time_of_departure			
	,suppress_rate					
	,booker_id					
	,booked_by					
	,primary_guest_id				
	,cancellation_code				
	,cancellation_reason				
	,cancelled_by					
	,agent_ids					
	,early_check_in_time				
	,late_checkout_time				
	,web_check_in					
	,no_of_documents				
	,share_id					
	,no_of_pets					
	,web_check_out					
	,room_ready_sms_enabled				
	,web_check_in_sms_enabled			
	,web_check_out_sms_enabled			
	,room_feature_preference_names			
	,number_of_guests				
	,guest_preference_ids				
	,housekeeping_pattern_id			
	,red_eye_arrival_guest_arrival_date		
	,red_eye_arrival_estimated_time_of_arrival	
	,red_eye_arrival_status				
	,checkin_at					
	,checkin_by					
	,checkout_at					
	,checkout_by					
	,do_not_move_reason_description			
	,do_not_move_reason_date_time			
	,do_not_move_reason_updated_by			
	,do_not_move_reason_id				
	,deposit_policy_amount				
	,deposit_policy_tax				
	,number_of_age_category1			
	,number_of_age_category2			
	,deposit_total_due				
	,_export_ts					
	,source_interface_id				
	,auto_check_in					
	,digital_key_status				
	,physical_key_status				
	,disclose_room_type				
	,check_in_type					
	,check_out_type					
	,check_in					
	,check_out					
	,old_room_type_id				
	,old_pms_confirmation_code			
	,comp_overridden				
	,comp_overridden_user				
	,player_id					
	,commission_percentage				
	,moved_status					
	,override_policy_amount				
	,original_policy_amount				
	,cancellation_fee_amount			
	,cancellation_amount_charged			
	,cancellation_policy_overridden_datetime	
	,cancellation_policy_override_reason		
	,original_cancellation_policy			
	,guest_requested_ada_room_type			
	,guest_requested_connecting_room_type		
	,ada_room_assigned				
	,connecting_room_assigned			
	,room_assignment_result				
	,existing_user_name				
	,overriding_user_name				
	,created_date_time				
	,_export_create_ts				
	,_export_update_ts				
	,number_of_age_category3			
	,number_of_age_category4			
	,number_of_age_category5			
	,number_of_age_category6			
	,number_of_age_category7			
	,number_of_age_category8				
)'

SELECT @AdditionalParameters = N'@Key_reservations [DATETIME] = ' + CONVERT(VARCHAR(MAX), @Key_reservations, 120)

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE reservations.create_time >= TO_DATE(@Key_reservations,''YYYY-MM-DD'')
')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #reservations (create_time)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE reservations.update_time >= TO_DATE(@Key_reservations,''YYYY-MM-DD'')
And	reservations.create_time < TO_DATE(@Key_reservations, ''YYYY-MM-DD'')
')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #reservations (update_time)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

/* Guests */
SELECT @SqlTemplate = N'
SELECT	
	id			
	,tenant_id		
	,Case When anonymized	 Then 1 Else 0 End anonymized	
	,anonymized_message	
	,create_time		
	,update_time		
	,Case When archived	Then 1 Else 0 End archived	
	,external_profile_id	
	,first_name		
	,last_name		
	,anniversary		
	,birth_date		
	,middle_initial		
	,suffix			
	,title			
	,company_title		
	,pronunciation		
	,gender			
	,language		
	,alias			
	,company_name		
	,type		
	,player_id		
	,cms_type		
	,Case When card_id_available	Then 1 Else 0 End card_id_available
	,gps_id			
	,Case When opt_in_for_marketing	Then 1 Else 0 End opt_in_for_marketing
	,Case When merge_remnant	Then 1 Else 0 End merge_remnant
FROM {Database}.public.guests
{Criteria}'

SELECT @InsertSql = N'
INSERT #guests 
(
	id			
	,tenant_id		
	,anonymized		
	,anonymized_message	
	,create_time		
	,update_time		
	,archived		
	,external_profile_id	
	,first_name		
	,last_name		
	,anniversary		
	,birth_date		
	,middle_initial		
	,suffix			
	,title			
	,company_title		
	,pronunciation		
	,gender			
	,language	
	,alias			
	,company_name		
	,type			
	,player_id		
	,cms_type		
	,card_id_available	
	,gps_id			
	,opt_in_for_marketing	
	,merge_remnant			
)'

SELECT @AdditionalParameters = N'@Key_guests [DATETIME] = ' + CONVERT(VARCHAR(MAX), @Key_guests, 120)

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE guests.create_time >= TO_DATE(@Key_guests,''YYYY-MM-DD'')
')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #guests (create_time)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE guests.update_time >= TO_DATE(@Key_guests,''YYYY-MM-DD'')
And	guests.create_time < TO_DATE(@Key_guests, ''YYYY-MM-DD'')
')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #guests (update_time)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

/* groups */
SELECT @SqlTemplate = N'
SELECT	id					
	,account_id				
	,adults_included			
	,allocation_id				
	,booking_status				
	,cancellation_policy_id			
	,children_included			
	,create_time				
	,deposit_policy_id			
	,end_date				
	,extra_adult_charge			
	,extra_children_charge			
	,group_code				
	,group_name				
	,guest_type_id				
	,market_segment_id			
	,profile_id				
	,property_id				
	,source_of_business_id			
	,start_date			
	,tax_exempt				
	,tenant_id				
	,update_time				
	,rate_plan_id				
	,shoulder_end_date			
	,shoulder_start_date			
	,transaction_item_id			
	,confirmation_code			
	,released				
	,profile_type				
	,description			
	,rolling_release_enabled		
	,auto_release_enabled			
	,cut_off_date				
	,departure_date				
	,housing_restricted			
	,room_blocks_for_shoulder_dates		
	,allocate_blocks_for_shoulder_dates	
	,overridden_arc_rule_id			
	,wholesaler
FROM {Database}.public.groups
{Criteria}'

SELECT @InsertSql = N'
INSERT #groups 
(
	id					
	,account_id				
	,adults_included			
	,allocation_id				
	,booking_status				
	,cancellation_policy_id			
	,children_included			
	,create_time				
	,deposit_policy_id			
	,end_date				
	,extra_adult_charge			
	,extra_children_charge			
	,group_code				
	,group_name				
	,guest_type_id				
	,market_segment_id			
	,profile_id				
	,property_id				
	,source_of_business_id			
	,start_date				
	,tax_exempt				
	,tenant_id				
	,update_time				
	,rate_plan_id				
	,shoulder_end_date			
	,shoulder_start_date			
	,transaction_item_id			
	,confirmation_code			
	,released				
	,profile_type				
	,description				
	,rolling_release_enabled		
	,auto_release_enabled			
	,cut_off_date				
	,departure_date				
	,housing_restricted			
	,room_blocks_for_shoulder_dates		
	,allocate_blocks_for_shoulder_dates	
	,overridden_arc_rule_id			
	,wholesaler				
)'

SELECT @AdditionalParameters = N'@Key_groups [DATETIME] = ' + CONVERT(VARCHAR(MAX), @Key_groups, 120)

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE groups.create_time >= TO_DATE(@Key_groups,''YYYY-MM-DD'')
')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #groups (create_time)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE groups.update_time >= TO_DATE(@Key_groups,''YYYY-MM-DD'')
And	groups.create_time < TO_DATE(@Key_groups, ''YYYY-MM-DD'')
')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #groups (update_time)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

/* rooms */
SELECT @SqlTemplate = N'
Select  id
	,Case When is_ada Then 1 Else 0 End is_ada
	,Case When last_sell Then 1 Else 0 End last_sell
	,reset_value
	,rack_number
	,room_number
	,room_type_id
	,building_id
	,floor_id
	,create_time
	,property_id
	,tenant_id
	,update_time
	,total_days_occupied
	,housekeeping_room_condition
	,occupancy_status
	,start_date
	,end_date
	,Case When suite Then 1 Else 0 End suite
	,description
	,CAST(array_to_string(connecting_room_ids, '' , ''''*'') as varchar(200)) as connecting_room_ids 
	,no_of_associated_rooms
FROM {Database}.public.rooms
{Criteria}'

SELECT @InsertSql = N'
INSERT #rooms 
(
	id				
	,is_ada				
	,last_sell			
	,reset_value			
	,rack_number			
	,room_number			
	,room_type_id			
	,building_id			
	,floor_id			
	,create_time			
	,property_id			
	,tenant_id			
	,update_time			
	,total_days_occupied		
	,housekeeping_room_condition	
	,occupancy_status		
	,[start_date]			
	,end_date			
	,suite				
	,[description]			
	,connecting_room_ids		
	,no_of_associated_rooms		
)'

SELECT @AdditionalParameters = N'@Key_rooms [DATETIME] = ' + CONVERT(VARCHAR(MAX), @Key_rooms, 120)

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE rooms.create_time >= TO_DATE(@Key_rooms,''YYYY-MM-DD'')
')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #rooms (create_time)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}',
N'WHERE rooms.update_time >= TO_DATE(@Key_rooms,''YYYY-MM-DD'')
And	rooms.create_time < TO_DATE(@Key_rooms, ''YYYY-MM-DD'')

')

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #rooms (update_time)'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

/* room_classes */
SELECT @SqlTemplate = N'
Select  
	id			
	,name		
	,active			
	,tenant_id		
	,property_id		
	,rank			
FROM {Database}.public.room_classes
'

SELECT @InsertSql = N'
INSERT #room_classes 
(
	id			
	,name		
	,active			
	,tenant_id		
	,property_id		
	,rank		
)'

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}','') --NO criteria

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #room_classes'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

/* room_types */
SELECT @SqlTemplate = N'
Select  
	id
	,name
	,type_code
	,housekeeping_pattern_id
	,is_ada
	,is_virtual
	,max_guests
	,max_pets
	,non_bedded
	,default_building_id
	,pets
	,property_id
	,room_class_id
	,tenant_id
	,is_roh
	,description
	,smoking_allowed
	,CAST(array_to_string(bed_ids, '' , ''''*'') as varchar(200)) as bed_ids 
	,Case When suite Then 1 Else 0 End suite
FROM {Database}.public.room_types
'

SELECT @InsertSql = N'
INSERT #room_types 
(
	id
	,name
	,type_code
	,housekeeping_pattern_id
	,is_ada
	,is_virtual
	,max_guests
	,max_pets
	,non_bedded
	,default_building_id
	,pets
	,property_id
	,room_class_id
	,tenant_id
	,is_roh
	,description
	,smoking_allowed
	,bed_ids 
	,suite
)'

SELECT @Sql = REPLACE(@SqlTemplate, '{Criteria}','') --NO criteria

EXECUTE spLoadData_Sidehatch
	@SourceSystemId			= @SourceSystemId
	,@SourceSystemLogId		= @SourceSystemLogId
	,@SourceSystemLogDescription	= 'Insert #room_types'
	,@Sql				= @Sql
	,@InsertSql			= @InsertSql
	,@AdditionalParameters		= @AdditionalParameters
	,@RemoveBrackets		= 1
	,@IsError			= @IsError OUT
	,@ErrorCode			= @ErrorCode OUT
	,@RowCount			= @RowCount OUT
	,@ErrorMessage			= @ErrorMessage OUT
IF @IsError = 1 GOTO Error

-----------------------------------------------
/* Begin inserts into permanent opera tables */
-----------------------------------------------
IF EXISTS (SELECT 1 FROM #transaction_item_revenue_aggregate)
BEGIN
	SELECT @Description = 'Beginning Agilysys_Stay_V1.transaction_item_revenue_aggregate section'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	UPDATE Agilysys_Stay_V1.transaction_item_revenue_aggregate
	SET	category		= #transaction_item_revenue_aggregate_AggregatedPerDayDimensions.category
		,sub_category		= #transaction_item_revenue_aggregate_AggregatedPerDayDimensions.sub_category
		,net_amount		= #transaction_item_revenue_aggregate_AggregatedPerDayDimensions.net_amount
		,tax			= #transaction_item_revenue_aggregate_AggregatedPerDayDimensions.tax
		,gross_amount		= #transaction_item_revenue_aggregate_AggregatedPerDayDimensions.gross_amount
	FROM Agilysys_Stay_V1.transaction_item_revenue_aggregate (NoLock)
		INNER JOIN #transaction_item_revenue_aggregate_AggregatedPerDayDimensions	ON	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.property_id = transaction_item_revenue_aggregate.property_id
												AND	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.[date] = transaction_item_revenue_aggregate.[date]
												AND	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.[user_name] = transaction_item_revenue_aggregate.[user_name]
												AND	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.category = transaction_item_revenue_aggregate.category
												AND	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.sub_category = transaction_item_revenue_aggregate.sub_category
												AND	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.ledger_name = transaction_item_revenue_aggregate.ledger_name
	WHERE EXISTS
	(
		SELECT	 #transaction_item_revenue_aggregate_AggregatedPerDayDimensions.category
			 ,#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.sub_category
			 ,#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.net_amount
			 ,#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.tax
			 ,#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.gross_amount
		EXCEPT
		SELECT	Agilysys_Stay_V1.transaction_item_revenue_aggregate.category
			,Agilysys_Stay_V1.transaction_item_revenue_aggregate.sub_category
			,Agilysys_Stay_V1.transaction_item_revenue_aggregate.net_amount
			,Agilysys_Stay_V1.transaction_item_revenue_aggregate.tax
			,Agilysys_Stay_V1.transaction_item_revenue_aggregate.gross_amount
	)
	
	SELECT @Description = 'Update Agilysys_Stay_V1.transaction_item_revenue_aggregate section with #transaction_item_revenue_aggregate'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
	
	INSERT Agilysys_Stay_V1.transaction_item_revenue_aggregate
	(
       [date]	
       ,tenant_id	
       ,property_id	
       ,category	
       ,sub_category	
       ,ledger_name	
       ,net_amount	
       ,tax		
       ,gross_amount		
       ,[user_name]	
	,SourceSystemId
	,CreatedOn
	,ModifiedOn
	)
	SELECT	[date]	
		,tenant_id	
		,property_id	
		,category	
		,sub_category	
		,ledger_name	
		,net_amount	
		,tax		
		,gross_amount		
		,[user_name]	
		,@SourceSystemId
		,GetDate()
		,GetDate()
	FROM #transaction_item_revenue_aggregate_AggregatedPerDayDimensions
	WHERE NOT EXISTS 
	(
		SELECT 1
		FROM	Agilysys_Stay_V1.transaction_item_revenue_aggregate
		WHERE	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.property_id = transaction_item_revenue_aggregate.property_id
		AND	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.[date] = transaction_item_revenue_aggregate.[date]
		AND	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.[user_name] = transaction_item_revenue_aggregate.[user_name]
		AND	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.category = transaction_item_revenue_aggregate.category
		AND	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.sub_category = transaction_item_revenue_aggregate.sub_category
		AND	#transaction_item_revenue_aggregate_AggregatedPerDayDimensions.ledger_name = transaction_item_revenue_aggregate.ledger_name
		AND	Agilysys_Stay_V1.transaction_item_revenue_aggregate.SourceSystemId = @SourceSystemId
	)
	
	SELECT @Description = 'Insert #transaction_item_revenue_aggregate into Agilysys_Stay_V1.transaction_item_revenue_aggregate'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #properties)
BEGIN
	SELECT @Description = 'Beginning Agilysys_Stay_V1.properties section'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	UPDATE Agilysys_Stay_V1.properties
	SET	check_in_time			= #properties.check_in_time			
		,checkout_time			= #properties.checkout_time			
		,create_time			= #properties.create_time			
		,is_deleted			= #properties.is_deleted			
		,tenant_id			= #properties.tenant_id			
		,time_zone			= #properties.time_zone			
		,update_time			= #properties.update_time			
		,accounting_style_required	= #properties.accounting_style_required	
		,production_property		= #properties.production_property		
		,first_room_stay_at		= #properties.first_room_stay_at		
		,first_reservation_created_at	= #properties.first_reservation_created_at	
		,first_room_charge_at		= #properties.first_room_charge_at		
		,recent_room_stay_at		= #properties.recent_room_stay_at		
		,recent_room_charge_at		= #properties.recent_room_charge_at		
		,recent_reservation_created_at	= #properties.recent_reservation_created_at	
		,tenant_name			= #properties.tenant_name			
		,property_name			= #properties.property_name			
		,tenant_code			= #properties.tenant_code			
		,property_code			= #properties.property_code			
		,[language]			= #properties.[language]			
		,country			= #properties.country			
		,currency_code			= #properties.currency_code			
		,long_date_format		= #properties.long_date_format		
		,short_date_format		= #properties.short_date_format		
		,time_format			= #properties.time_format			
		,clock_type			= #properties.clock_type			
		,locale_code			= #properties.locale_code			
		,content_date_format		= #properties.content_date_format		
		,content_time_format		= #properties.content_time_format		
	FROM Agilysys_Stay_V1.properties (NoLock)
		INNER JOIN #properties	ON properties.id = #properties.id	
	WHERE EXISTS
	(
		SELECT	 #properties.check_in_time			
			 ,#properties.checkout_time			
			 ,#properties.create_time			
			 ,#properties.is_deleted			
			 ,#properties.tenant_id			
			 ,#properties.time_zone			
			 ,#properties.update_time			
			 ,#properties.accounting_style_required	
			 ,#properties.production_property		
			 ,#properties.first_room_stay_at		
			 ,#properties.first_reservation_created_at	
			 ,#properties.first_room_charge_at		
			 ,#properties.recent_room_stay_at		
			 ,#properties.recent_room_charge_at		
			 ,#properties.recent_reservation_created_at	
			 ,#properties.tenant_name			
			 ,#properties.property_name			
			 ,#properties.tenant_code			
			 ,#properties.property_code			
			 ,#properties.[language]			
			 ,#properties.country			
			 ,#properties.currency_code			
			 ,#properties.long_date_format		
			 ,#properties.short_date_format		
			 ,#properties.time_format			
			 ,#properties.clock_type			
			 ,#properties.locale_code			
			 ,#properties.content_date_format		
			 ,#properties.content_time_format		
		EXCEPT
		SELECT	 Agilysys_Stay_V1.properties.check_in_time			
			 ,Agilysys_Stay_V1.properties.checkout_time			
			 ,Agilysys_Stay_V1.properties.create_time			
			 ,Agilysys_Stay_V1.properties.is_deleted			
			 ,Agilysys_Stay_V1.properties.tenant_id			
			 ,Agilysys_Stay_V1.properties.time_zone			
			 ,Agilysys_Stay_V1.properties.update_time			
			 ,Agilysys_Stay_V1.properties.accounting_style_required	
			 ,Agilysys_Stay_V1.properties.production_property		
			 ,Agilysys_Stay_V1.properties.first_room_stay_at		
			 ,Agilysys_Stay_V1.properties.first_reservation_created_at	
			 ,Agilysys_Stay_V1.properties.first_room_charge_at		
			 ,Agilysys_Stay_V1.properties.recent_room_stay_at		
			 ,Agilysys_Stay_V1.properties.recent_room_charge_at		
			 ,Agilysys_Stay_V1.properties.recent_reservation_created_at	
			 ,Agilysys_Stay_V1.properties.tenant_name			
			 ,Agilysys_Stay_V1.properties.property_name			
			 ,Agilysys_Stay_V1.properties.tenant_code			
			 ,Agilysys_Stay_V1.properties.property_code			
			 ,Agilysys_Stay_V1.properties.[language]			
			 ,Agilysys_Stay_V1.properties.country			
			 ,Agilysys_Stay_V1.properties.currency_code			
			 ,Agilysys_Stay_V1.properties.long_date_format		
			 ,Agilysys_Stay_V1.properties.short_date_format		
			 ,Agilysys_Stay_V1.properties.time_format			
			 ,Agilysys_Stay_V1.properties.clock_type			
			 ,Agilysys_Stay_V1.properties.locale_code			
			 ,Agilysys_Stay_V1.properties.content_date_format		
			 ,Agilysys_Stay_V1.properties.content_time_format
	)
	
	SELECT @Description = 'Update Agilysys_Stay_V1.properties section with #properties'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	INSERT Agilysys_Stay_V1.properties
	(
		id				
		,check_in_time			
		,checkout_time			
		,create_time			
		,is_deleted			
		,tenant_id			
		,time_zone			
		,update_time			
		,accounting_style_required	
		,production_property		
		,first_room_stay_at		
		,first_reservation_created_at	
		,first_room_charge_at		
		,recent_room_stay_at		
		,recent_room_charge_at		
		,recent_reservation_created_at	
		,tenant_name			
		,property_name			
		,tenant_code			
		,property_code			
		,[language]			
		,country			
		,currency_code			
		,long_date_format		
		,short_date_format		
		,time_format			
		,clock_type			
		,locale_code			
		,content_date_format		
		,content_time_format
		,SourceSystemId
		,CreatedOn
		,ModifiedOn
	)
	SELECT	id				
		,check_in_time			
		,checkout_time			
		,create_time			
		,is_deleted			
		,tenant_id			
		,time_zone			
		,update_time			
		,accounting_style_required	
		,production_property		
		,first_room_stay_at		
		,first_reservation_created_at	
		,first_room_charge_at		
		,recent_room_stay_at		
		,recent_room_charge_at		
		,recent_reservation_created_at	
		,tenant_name			
		,property_name			
		,tenant_code			
		,property_code			
		,[language]			
		,country			
		,currency_code			
		,long_date_format		
		,short_date_format		
		,time_format			
		,clock_type			
		,locale_code			
		,content_date_format		
		,content_time_format		
		,@SourceSystemId
		,GetDate()
		,GetDate()
	FROM #properties
	WHERE NOT EXISTS 
	(
		SELECT 1
		FROM	Agilysys_Stay_V1.properties
		WHERE	properties.id = #properties.id
		AND	Agilysys_Stay_V1.properties.SourceSystemId = @SourceSystemId
	)
	
	SELECT @Description = 'Insert #properties into Agilysys_Stay_V1.properties'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #reservations)
BEGIN
	SELECT @Description = 'Beginning Agilysys_Stay_V1.reseravtions section'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	UPDATE Agilysys_Stay_V1.reservations
	SET	do_not_move_room						= #reservations	.do_not_move_room		
		,cancellation_time_utc						= #reservations.cancellation_time_utc				
		,account_id							= #reservations.account_id					
		,allocation_id							= #reservations.allocation_id					
		,arrival_date							= #reservations.arrival_date					
		,cancellation_date						= #reservations.cancellation_date				
		,confirmation_code						= #reservations.confirmation_code				
		,create_time							= #reservations.create_time					
		,departure_date							= #reservations.departure_date					
		,early_arrival							= #reservations.early_arrival					
		,number_of_adults						= #reservations.number_of_adults				
		,number_of_children						= #reservations.number_of_children				
		,primary_guest_first_name					= #reservations.primary_guest_first_name			
		,primary_guest_last_name					= #reservations.primary_guest_last_name			
		,reservation_alias						= #reservations.reservation_alias				
		,[status]							= #reservations.[status]					
		,tenant_id							= #reservations.tenant_id					
		,guest_type_id							= #reservations.guest_type_id					
		,market_segment_id						= #reservations.market_segment_id				
		,source_of_business_id						= #reservations.source_of_business_id				
		,update_time							= #reservations.update_time					
		,company_id							= #reservations.company_id					
		,group_id							= #reservations.group_id					
		,vip_status_id							= #reservations.vip_status_id					
		,non_registered_guest						= #reservations.non_registered_guest				
		,walk_in							= #reservations.walk_in					
		,cancellation_policy_id						= #reservations.cancellation_policy_id				
		,deposit_policy_id						= #reservations.deposit_policy_id				
		,cancellation_policy_overridden_by				= #reservations.cancellation_policy_overridden_by		
		,cancellation_policy_overridden_amount				= #reservations.cancellation_policy_overridden_amount		
		,cancellation_policy_overridden_percentage			= #reservations.cancellation_policy_overridden_percentage	
		,overridden_cancellation_policy_id				= #reservations.overridden_cancellation_policy_id		
		,estimated_time_of_arrival					= #reservations.estimated_time_of_arrival			
		,estimated_time_of_departure					= #reservations.estimated_time_of_departure			
		,suppress_rate							= #reservations.suppress_rate					
		,booker_id							= #reservations.booker_id					
		,booked_by							= #reservations.booked_by					
		,primary_guest_id						= #reservations.primary_guest_id				
		,cancellation_code						= #reservations.cancellation_code				
		,cancellation_reason						= #reservations.cancellation_reason				
		,cancelled_by							= #reservations.cancelled_by					
		,agent_ids							= #reservations.agent_ids					
		,early_check_in_time						= #reservations.early_check_in_time				
		,late_checkout_time						= #reservations.late_checkout_time				
		,web_check_in							= #reservations.web_check_in					
		,no_of_documents						= #reservations.no_of_documents				
		,share_id							= #reservations.share_id					
		,no_of_pets							= #reservations.no_of_pets					
		,web_check_out							= #reservations.web_check_out					
		,room_ready_sms_enabled						= #reservations.room_ready_sms_enabled				
		,web_check_in_sms_enabled					= #reservations.web_check_in_sms_enabled			
		,web_check_out_sms_enabled					= #reservations.web_check_out_sms_enabled			
		,room_feature_preference_names					= #reservations.room_feature_preference_names			
		,number_of_guests						= #reservations.number_of_guests				
		,guest_preference_ids						= #reservations.guest_preference_ids				
		,housekeeping_pattern_id					= #reservations.housekeeping_pattern_id			
		,red_eye_arrival_guest_arrival_date				= #reservations.red_eye_arrival_guest_arrival_date		
		,red_eye_arrival_estimated_time_of_arrival			= #reservations.red_eye_arrival_estimated_time_of_arrival	
		,red_eye_arrival_status						= #reservations.red_eye_arrival_status				
		,checkin_at							= #reservations.checkin_at					
		,checkin_by							= #reservations.checkin_by					
		,checkout_at							= #reservations.checkout_at					
		,checkout_by							= #reservations.checkout_by					
		,do_not_move_reason_description					= #reservations.do_not_move_reason_description			
		,do_not_move_reason_date_time					= #reservations.do_not_move_reason_date_time			
		,do_not_move_reason_updated_by					= #reservations.do_not_move_reason_updated_by			
		,do_not_move_reason_id						= #reservations.do_not_move_reason_id				
		,deposit_policy_amount						= #reservations.deposit_policy_amount				
		,deposit_policy_tax						= #reservations.deposit_policy_tax				
		,number_of_age_category1					= #reservations.number_of_age_category1			
		,number_of_age_category2					= #reservations.number_of_age_category2			
		,deposit_total_due						= #reservations.deposit_total_due				
		,_export_ts							= #reservations._export_ts					
		,source_interface_id						= #reservations.source_interface_id				
		,auto_check_in							= #reservations.auto_check_in					
		,digital_key_status						= #reservations.digital_key_status				
		,physical_key_status						= #reservations.physical_key_status				
		,disclose_room_type						= #reservations.disclose_room_type				
		,check_in_type							= #reservations.check_in_type					
		,check_out_type							= #reservations.check_out_type					
		,check_in							= #reservations.check_in					
		,check_out							= #reservations.check_out					
		,old_room_type_id						= #reservations.old_room_type_id				
		,old_pms_confirmation_code					= #reservations.old_pms_confirmation_code			
		,comp_overridden						= #reservations.comp_overridden				
		,comp_overridden_user						= #reservations.comp_overridden_user				
		,player_id							= #reservations.player_id					
		,commission_percentage						= #reservations.commission_percentage				
		,moved_status							= #reservations.moved_status					
		,override_policy_amount						= #reservations.override_policy_amount				
		,original_policy_amount						= #reservations.original_policy_amount				
		,cancellation_fee_amount					= #reservations.cancellation_fee_amount			
		,cancellation_amount_charged					= #reservations.cancellation_amount_charged			
		,cancellation_policy_overridden_datetime			= #reservations.cancellation_policy_overridden_datetime	
		,cancellation_policy_override_reason				= #reservations.cancellation_policy_override_reason		
		,original_cancellation_policy					= #reservations.original_cancellation_policy			
		,guest_requested_ada_room_type					= #reservations.guest_requested_ada_room_type			
		,guest_requested_connecting_room_type				= #reservations.guest_requested_connecting_room_type		
		,ada_room_assigned						= #reservations.ada_room_assigned				
		,connecting_room_assigned					= #reservations.connecting_room_assigned			
		,room_assignment_result						= #reservations.room_assignment_result				
		,existing_user_name						= #reservations.existing_user_name				
		,overriding_user_name						= #reservations.overriding_user_name				
		,created_date_time						= #reservations.created_date_time				
		,_export_create_ts						= #reservations._export_create_ts				
		,_export_update_ts						= #reservations._export_update_ts				
		,number_of_age_category3					= #reservations.number_of_age_category3			
		,number_of_age_category4					= #reservations.number_of_age_category4			
		,number_of_age_category5					= #reservations.number_of_age_category5			
		,number_of_age_category6					= #reservations.number_of_age_category6			
		,number_of_age_category7					= #reservations.number_of_age_category7			
		,number_of_age_category8					= #reservations.number_of_age_category8			
	FROM Agilysys_Stay_V1.reservations (NoLock)
		INNER JOIN #reservations	ON reservations.id = #reservations.id	
						AND reservations.property_id = #reservations.property_id
	WHERE EXISTS
	(
		SELECT	#reservations.do_not_move_room		
			,#reservations.cancellation_time_utc				
			,#reservations.account_id					
			,#reservations.allocation_id					
			,#reservations.arrival_date					
			,#reservations.cancellation_date				
			,#reservations.confirmation_code				
			,#reservations.create_time					
			,#reservations.departure_date					
			,#reservations.early_arrival					
			,#reservations.number_of_adults				
			,#reservations.number_of_children				
			,#reservations.primary_guest_first_name			
			,#reservations.primary_guest_last_name			
			,#reservations.reservation_alias				
			,#reservations.[status]					
			,#reservations.tenant_id					
			,#reservations.guest_type_id					
			,#reservations.market_segment_id				
			,#reservations.source_of_business_id				
			,#reservations.update_time					
			,#reservations.company_id					
			,#reservations.group_id					
			,#reservations.vip_status_id					
			,#reservations.non_registered_guest				
			,#reservations.walk_in					
			,#reservations.cancellation_policy_id				
			,#reservations.deposit_policy_id				
			,#reservations.cancellation_policy_overridden_by		
			,#reservations.cancellation_policy_overridden_amount		
			,#reservations.cancellation_policy_overridden_percentage	
			,#reservations.overridden_cancellation_policy_id		
			,#reservations.estimated_time_of_arrival			
			,#reservations.estimated_time_of_departure			
			,#reservations.suppress_rate					
			,#reservations.booker_id					
			,#reservations.booked_by					
			,#reservations.primary_guest_id				
			,#reservations.cancellation_code				
			,#reservations.cancellation_reason				
			,#reservations.cancelled_by					
			,#reservations.agent_ids					
			,#reservations.early_check_in_time				
			,#reservations.late_checkout_time				
			,#reservations.web_check_in					
			,#reservations.no_of_documents				
			,#reservations.share_id					
			,#reservations.no_of_pets					
			,#reservations.web_check_out					
			,#reservations.room_ready_sms_enabled				
			,#reservations.web_check_in_sms_enabled			
			,#reservations.web_check_out_sms_enabled			
			,#reservations.room_feature_preference_names			
			,#reservations.number_of_guests				
			,#reservations.guest_preference_ids				
			,#reservations.housekeeping_pattern_id			
			,#reservations.red_eye_arrival_guest_arrival_date		
			,#reservations.red_eye_arrival_estimated_time_of_arrival	
			,#reservations.red_eye_arrival_status				
			,#reservations.checkin_at					
			,#reservations.checkin_by					
			,#reservations.checkout_at					
			,#reservations.checkout_by					
			,#reservations.do_not_move_reason_description			
			,#reservations.do_not_move_reason_date_time			
			,#reservations.do_not_move_reason_updated_by			
			,#reservations.do_not_move_reason_id				
			,#reservations.deposit_policy_amount				
			,#reservations.deposit_policy_tax				
			,#reservations.number_of_age_category1			
			,#reservations.number_of_age_category2			
			,#reservations.deposit_total_due				
			,#reservations._export_ts					
			,#reservations.source_interface_id				
			,#reservations.auto_check_in					
			,#reservations.digital_key_status				
			,#reservations.physical_key_status				
			,#reservations.disclose_room_type				
			,#reservations.check_in_type					
			,#reservations.check_out_type					
			,#reservations.check_in					
			,#reservations.check_out					
			,#reservations.old_room_type_id				
			,#reservations.old_pms_confirmation_code			
			,#reservations.comp_overridden				
			,#reservations.comp_overridden_user				
			,#reservations.player_id					
			,#reservations.commission_percentage				
			,#reservations.moved_status					
			,#reservations.override_policy_amount				
			,#reservations.original_policy_amount				
			,#reservations.cancellation_fee_amount			
			,#reservations.cancellation_amount_charged			
			,#reservations.cancellation_policy_overridden_datetime	
			,#reservations.cancellation_policy_override_reason		
			,#reservations.original_cancellation_policy			
			,#reservations.guest_requested_ada_room_type			
			,#reservations.guest_requested_connecting_room_type		
			,#reservations.ada_room_assigned				
			,#reservations.connecting_room_assigned			
			,#reservations.room_assignment_result				
			,#reservations.existing_user_name				
			,#reservations.overriding_user_name				
			,#reservations.created_date_time				
			,#reservations._export_create_ts				
			,#reservations._export_update_ts				
			,#reservations.number_of_age_category3			
			,#reservations.number_of_age_category4			
			,#reservations.number_of_age_category5			
			,#reservations.number_of_age_category6			
			,#reservations.number_of_age_category7			
			,#reservations.number_of_age_category8			
		EXCEPT
		SELECT	 Agilysys_Stay_V1.reservations.do_not_move_room		
			,Agilysys_Stay_V1.reservations.cancellation_time_utc				
			,Agilysys_Stay_V1.reservations.account_id					
			,Agilysys_Stay_V1.reservations.allocation_id					
			,Agilysys_Stay_V1.reservations.arrival_date					
			,Agilysys_Stay_V1.reservations.cancellation_date				
			,Agilysys_Stay_V1.reservations.confirmation_code				
			,Agilysys_Stay_V1.reservations.create_time					
			,Agilysys_Stay_V1.reservations.departure_date					
			,Agilysys_Stay_V1.reservations.early_arrival					
			,Agilysys_Stay_V1.reservations.number_of_adults				
			,Agilysys_Stay_V1.reservations.number_of_children				
			,Agilysys_Stay_V1.reservations.primary_guest_first_name			
			,Agilysys_Stay_V1.reservations.primary_guest_last_name			
			,Agilysys_Stay_V1.reservations.reservation_alias				
			,Agilysys_Stay_V1.reservations.[status]					
			,Agilysys_Stay_V1.reservations.tenant_id					
			,Agilysys_Stay_V1.reservations.guest_type_id					
			,Agilysys_Stay_V1.reservations.market_segment_id				
			,Agilysys_Stay_V1.reservations.source_of_business_id				
			,Agilysys_Stay_V1.reservations.update_time					
			,Agilysys_Stay_V1.reservations.company_id					
			,Agilysys_Stay_V1.reservations.group_id					
			,Agilysys_Stay_V1.reservations.vip_status_id					
			,Agilysys_Stay_V1.reservations.non_registered_guest				
			,Agilysys_Stay_V1.reservations.walk_in					
			,Agilysys_Stay_V1.reservations.cancellation_policy_id				
			,Agilysys_Stay_V1.reservations.deposit_policy_id				
			,Agilysys_Stay_V1.reservations.cancellation_policy_overridden_by		
			,Agilysys_Stay_V1.reservations.cancellation_policy_overridden_amount		
			,Agilysys_Stay_V1.reservations.cancellation_policy_overridden_percentage	
			,Agilysys_Stay_V1.reservations.overridden_cancellation_policy_id		
			,Agilysys_Stay_V1.reservations.estimated_time_of_arrival			
			,Agilysys_Stay_V1.reservations.estimated_time_of_departure			
			,Agilysys_Stay_V1.reservations.suppress_rate					
			,Agilysys_Stay_V1.reservations.booker_id					
			,Agilysys_Stay_V1.reservations.booked_by					
			,Agilysys_Stay_V1.reservations.primary_guest_id				
			,Agilysys_Stay_V1.reservations.cancellation_code				
			,Agilysys_Stay_V1.reservations.cancellation_reason				
			,Agilysys_Stay_V1.reservations.cancelled_by					
			,Agilysys_Stay_V1.reservations.agent_ids					
			,Agilysys_Stay_V1.reservations.early_check_in_time				
			,Agilysys_Stay_V1.reservations.late_checkout_time				
			,Agilysys_Stay_V1.reservations.web_check_in					
			,Agilysys_Stay_V1.reservations.no_of_documents				
			,Agilysys_Stay_V1.reservations.share_id					
			,Agilysys_Stay_V1.reservations.no_of_pets					
			,Agilysys_Stay_V1.reservations.web_check_out					
			,Agilysys_Stay_V1.reservations.room_ready_sms_enabled				
			,Agilysys_Stay_V1.reservations.web_check_in_sms_enabled			
			,Agilysys_Stay_V1.reservations.web_check_out_sms_enabled			
			,Agilysys_Stay_V1.reservations.room_feature_preference_names			
			,Agilysys_Stay_V1.reservations.number_of_guests				
			,Agilysys_Stay_V1.reservations.guest_preference_ids				
			,Agilysys_Stay_V1.reservations.housekeeping_pattern_id			
			,Agilysys_Stay_V1.reservations.red_eye_arrival_guest_arrival_date		
			,Agilysys_Stay_V1.reservations.red_eye_arrival_estimated_time_of_arrival	
			,Agilysys_Stay_V1.reservations.red_eye_arrival_status				
			,Agilysys_Stay_V1.reservations.checkin_at					
			,Agilysys_Stay_V1.reservations.checkin_by					
			,Agilysys_Stay_V1.reservations.checkout_at					
			,Agilysys_Stay_V1.reservations.checkout_by					
			,Agilysys_Stay_V1.reservations.do_not_move_reason_description			
			,Agilysys_Stay_V1.reservations.do_not_move_reason_date_time			
			,Agilysys_Stay_V1.reservations.do_not_move_reason_updated_by			
			,Agilysys_Stay_V1.reservations.do_not_move_reason_id				
			,Agilysys_Stay_V1.reservations.deposit_policy_amount				
			,Agilysys_Stay_V1.reservations.deposit_policy_tax				
			,Agilysys_Stay_V1.reservations.number_of_age_category1			
			,Agilysys_Stay_V1.reservations.number_of_age_category2			
			,Agilysys_Stay_V1.reservations.deposit_total_due				
			,Agilysys_Stay_V1.reservations._export_ts					
			,Agilysys_Stay_V1.reservations.source_interface_id				
			,Agilysys_Stay_V1.reservations.auto_check_in					
			,Agilysys_Stay_V1.reservations.digital_key_status				
			,Agilysys_Stay_V1.reservations.physical_key_status				
			,Agilysys_Stay_V1.reservations.disclose_room_type				
			,Agilysys_Stay_V1.reservations.check_in_type					
			,Agilysys_Stay_V1.reservations.check_out_type					
			,Agilysys_Stay_V1.reservations.check_in					
			,Agilysys_Stay_V1.reservations.check_out					
			,Agilysys_Stay_V1.reservations.old_room_type_id				
			,Agilysys_Stay_V1.reservations.old_pms_confirmation_code			
			,Agilysys_Stay_V1.reservations.comp_overridden				
			,Agilysys_Stay_V1.reservations.comp_overridden_user				
			,Agilysys_Stay_V1.reservations.player_id					
			,Agilysys_Stay_V1.reservations.commission_percentage				
			,Agilysys_Stay_V1.reservations.moved_status					
			,Agilysys_Stay_V1.reservations.override_policy_amount				
			,Agilysys_Stay_V1.reservations.original_policy_amount				
			,Agilysys_Stay_V1.reservations.cancellation_fee_amount			
			,Agilysys_Stay_V1.reservations.cancellation_amount_charged			
			,Agilysys_Stay_V1.reservations.cancellation_policy_overridden_datetime	
			,Agilysys_Stay_V1.reservations.cancellation_policy_override_reason		
			,Agilysys_Stay_V1.reservations.original_cancellation_policy			
			,Agilysys_Stay_V1.reservations.guest_requested_ada_room_type			
			,Agilysys_Stay_V1.reservations.guest_requested_connecting_room_type		
			,Agilysys_Stay_V1.reservations.ada_room_assigned				
			,Agilysys_Stay_V1.reservations.connecting_room_assigned			
			,Agilysys_Stay_V1.reservations.room_assignment_result				
			,Agilysys_Stay_V1.reservations.existing_user_name				
			,Agilysys_Stay_V1.reservations.overriding_user_name				
			,Agilysys_Stay_V1.reservations.created_date_time				
			,Agilysys_Stay_V1.reservations._export_create_ts				
			,Agilysys_Stay_V1.reservations._export_update_ts				
			,Agilysys_Stay_V1.reservations.number_of_age_category3			
			,Agilysys_Stay_V1.reservations.number_of_age_category4			
			,Agilysys_Stay_V1.reservations.number_of_age_category5			
			,Agilysys_Stay_V1.reservations.number_of_age_category6			
			,Agilysys_Stay_V1.reservations.number_of_age_category7			
			,Agilysys_Stay_V1.reservations.number_of_age_category8			
	)
	
	SELECT @Description = 'Update Agilysys_Stay_V1.reservations section with #reservations'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	INSERT Agilysys_Stay_V1.reservations
	(
		do_not_move_room				
		,cancellation_time_utc				
		,id						
		,account_id					
		,allocation_id					
		,arrival_date					
		,cancellation_date				
		,confirmation_code				
		,create_time					
		,departure_date					
		,early_arrival					
		,number_of_adults				
		,number_of_children				
		,primary_guest_first_name			
		,primary_guest_last_name			
		,property_id					
		,reservation_alias				
		,[status]					
		,tenant_id					
		,guest_type_id					
		,market_segment_id				
		,source_of_business_id				
		,update_time					
		,company_id					
		,group_id					
		,vip_status_id					
		,non_registered_guest				
		,walk_in					
		,cancellation_policy_id				
		,deposit_policy_id				
		,cancellation_policy_overridden_by		
		,cancellation_policy_overridden_amount		
		,cancellation_policy_overridden_percentage	
		,overridden_cancellation_policy_id		
		,estimated_time_of_arrival			
		,estimated_time_of_departure			
		,suppress_rate					
		,booker_id					
		,booked_by					
		,primary_guest_id				
		,cancellation_code				
		,cancellation_reason				
		,cancelled_by					
		,agent_ids					
		,early_check_in_time				
		,late_checkout_time				
		,web_check_in					
		,no_of_documents				
		,share_id					
		,no_of_pets					
		,web_check_out					
		,room_ready_sms_enabled				
		,web_check_in_sms_enabled			
		,web_check_out_sms_enabled			
		,room_feature_preference_names			
		,number_of_guests				
		,guest_preference_ids				
		,housekeeping_pattern_id			
		,red_eye_arrival_guest_arrival_date		
		,red_eye_arrival_estimated_time_of_arrival	
		,red_eye_arrival_status				
		,checkin_at					
		,checkin_by					
		,checkout_at					
		,checkout_by					
		,do_not_move_reason_description			
		,do_not_move_reason_date_time			
		,do_not_move_reason_updated_by			
		,do_not_move_reason_id				
		,deposit_policy_amount				
		,deposit_policy_tax				
		,number_of_age_category1			
		,number_of_age_category2			
		,deposit_total_due				
		,_export_ts					
		,source_interface_id				
		,auto_check_in					
		,digital_key_status				
		,physical_key_status				
		,disclose_room_type				
		,check_in_type					
		,check_out_type					
		,check_in					
		,check_out					
		,old_room_type_id				
		,old_pms_confirmation_code			
		,comp_overridden				
		,comp_overridden_user				
		,player_id					
		,commission_percentage				
		,moved_status					
		,override_policy_amount				
		,original_policy_amount				
		,cancellation_fee_amount			
		,cancellation_amount_charged			
		,cancellation_policy_overridden_datetime	
		,cancellation_policy_override_reason		
		,original_cancellation_policy			
		,guest_requested_ada_room_type			
		,guest_requested_connecting_room_type		
		,ada_room_assigned				
		,connecting_room_assigned			
		,room_assignment_result				
		,existing_user_name				
		,overriding_user_name				
		,created_date_time				
		,_export_create_ts				
		,_export_update_ts				
		,number_of_age_category3			
		,number_of_age_category4			
		,number_of_age_category5			
		,number_of_age_category6			
		,number_of_age_category7			
		,number_of_age_category8			
		,SourceSystemId
		,CreatedOn
		,ModifiedOn
	)
	SELECT		

		do_not_move_room				
		,cancellation_time_utc				
		,id						
		,account_id					
		,allocation_id					
		,arrival_date					
		,cancellation_date				
		,confirmation_code				
		,create_time					
		,departure_date					
		,early_arrival					
		,number_of_adults				
		,number_of_children				
		,primary_guest_first_name			
		,primary_guest_last_name			
		,property_id					
		,reservation_alias				
		,[status]					
		,tenant_id					
		,guest_type_id					
		,market_segment_id				
		,source_of_business_id				
		,update_time					
		,company_id					
		,group_id					
		,vip_status_id					
		,non_registered_guest				
		,walk_in					
		,cancellation_policy_id				
		,deposit_policy_id				
		,cancellation_policy_overridden_by		
		,cancellation_policy_overridden_amount		
		,cancellation_policy_overridden_percentage	
		,overridden_cancellation_policy_id		
		,estimated_time_of_arrival			
		,estimated_time_of_departure			
		,suppress_rate					
		,booker_id					
		,booked_by					
		,primary_guest_id				
		,cancellation_code				
		,cancellation_reason				
		,cancelled_by					
		,agent_ids					
		,early_check_in_time				
		,late_checkout_time				
		,web_check_in					
		,no_of_documents				
		,share_id					
		,no_of_pets					
		,web_check_out					
		,room_ready_sms_enabled				
		,web_check_in_sms_enabled			
		,web_check_out_sms_enabled			
		,room_feature_preference_names			
		,number_of_guests				
		,guest_preference_ids				
		,housekeeping_pattern_id			
		,red_eye_arrival_guest_arrival_date		
		,red_eye_arrival_estimated_time_of_arrival	
		,red_eye_arrival_status				
		,checkin_at					
		,checkin_by					
		,checkout_at					
		,checkout_by					
		,do_not_move_reason_description			
		,do_not_move_reason_date_time			
		,do_not_move_reason_updated_by			
		,do_not_move_reason_id				
		,deposit_policy_amount				
		,deposit_policy_tax				
		,number_of_age_category1			
		,number_of_age_category2			
		,deposit_total_due				
		,_export_ts					
		,source_interface_id				
		,auto_check_in					
		,digital_key_status				
		,physical_key_status				
		,disclose_room_type				
		,check_in_type					
		,check_out_type					
		,check_in					
		,check_out					
		,old_room_type_id				
		,old_pms_confirmation_code			
		,comp_overridden				
		,comp_overridden_user				
		,player_id					
		,commission_percentage				
		,moved_status					
		,override_policy_amount				
		,original_policy_amount				
		,cancellation_fee_amount			
		,cancellation_amount_charged			
		,cancellation_policy_overridden_datetime	
		,cancellation_policy_override_reason		
		,original_cancellation_policy			
		,guest_requested_ada_room_type			
		,guest_requested_connecting_room_type		
		,ada_room_assigned				
		,connecting_room_assigned			
		,room_assignment_result				
		,existing_user_name				
		,overriding_user_name				
		,created_date_time				
		,_export_create_ts				
		,_export_update_ts				
		,number_of_age_category3			
		,number_of_age_category4			
		,number_of_age_category5			
		,number_of_age_category6			
		,number_of_age_category7			
		,number_of_age_category8	
		,@SourceSystemId
		,GetDate()
		,GetDate()
	FROM #reservations
	WHERE NOT EXISTS 
	(
		SELECT 1
		FROM	Agilysys_Stay_V1.reservations
		WHERE	reservations.id = #reservations.id	
		AND	reservations.property_id = #reservations.property_id
		AND	reservations.SourceSystemId = @SourceSystemId
	)
	
	SELECT @Description = 'Insert #reservations into Agilysys_Stay_V1.reservations'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END










IF EXISTS (SELECT 1 FROM #guests)
BEGIN
	SELECT @Description = 'Beginning Agilysys_Stay_V1.guests section'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	UPDATE Agilysys_Stay_V1.guests
	SET	anonymized							 = #guests.anonymized		
		,anonymized_message						 = #guests.anonymized_message	
		,create_time							 = #guests.create_time		
		,update_time							 = #guests.update_time		
		,archived							 = #guests.archived		
		,external_profile_id						 = #guests.external_profile_id	
		,first_name							 = #guests.first_name		
		,last_name							 = #guests.last_name		
		,anniversary							 = #guests.anniversary		
		,birth_date							 = #guests.birth_date		
		,middle_initial							 = #guests.middle_initial		
		,suffix								 = #guests.suffix			
		,title								 = #guests.title			
		,company_title							 = #guests.company_title		
		,pronunciation							 = #guests.pronunciation		
		,gender								 = #guests.gender			
		,[language]							 = #guests.[language]		
		,alias								 = #guests.alias			
		,company_name							 = #guests.company_name		
		,[type]								 = #guests.[type]			
		,player_id							 = #guests.player_id		
		,cms_type							 = #guests.cms_type		
		,card_id_available						 = #guests.card_id_available	
		,gps_id								 = #guests.gps_id			
		,opt_in_for_marketing						 = #guests.opt_in_for_marketing	
		,merge_remnant							 = #guests.merge_remnant		
	FROM Agilysys_Stay_V1.guests (NoLock)
		INNER JOIN #guests	ON	guests.tenant_id = #guests.tenant_id
	WHERE EXISTS
	(
		SELECT	
			#guests.code			
			,#guests.id			
			,#guests.anonymized		
			,#guests.anonymized_message	
			,#guests.create_time		
			,#guests.update_time		
			,#guests.archived		
			,#guests.external_profile_id	
			,#guests.first_name		
			,#guests.last_name		
			,#guests.anniversary		
			,#guests.birth_date		
			,#guests.middle_initial		
			,#guests.suffix			
			,#guests.title			
			,#guests.company_title		
			,#guests.pronunciation		
			,#guests.gender			
			,#guests.[language]		
			,#guests.alias			
			,#guests.company_name		
			,#guests.[type]			
			,#guests.player_id		
			,#guests.cms_type		
			,#guests.card_id_available	
			,#guests.gps_id			
			,#guests.opt_in_for_marketing	
			,#guests.merge_remnant				
		EXCEPT
		SELECT	 Agilysys_Stay_V1.guests.code			
			,Agilysys_Stay_V1.guests.id			
			,Agilysys_Stay_V1.guests.anonymized		
			,Agilysys_Stay_V1.guests.anonymized_message	
			,Agilysys_Stay_V1.guests.create_time		
			,Agilysys_Stay_V1.guests.update_time		
			,Agilysys_Stay_V1.guests.archived		
			,Agilysys_Stay_V1.guests.external_profile_id	
			,Agilysys_Stay_V1.guests.first_name		
			,Agilysys_Stay_V1.guests.last_name		
			,Agilysys_Stay_V1.guests.anniversary		
			,Agilysys_Stay_V1.guests.birth_date		
			,Agilysys_Stay_V1.guests.middle_initial		
			,Agilysys_Stay_V1.guests.suffix			
			,Agilysys_Stay_V1.guests.title			
			,Agilysys_Stay_V1.guests.company_title		
			,Agilysys_Stay_V1.guests.pronunciation		
			,Agilysys_Stay_V1.guests.gender			
			,Agilysys_Stay_V1.guests.[language]		
			,Agilysys_Stay_V1.guests.alias			
			,Agilysys_Stay_V1.guests.company_name		
			,Agilysys_Stay_V1.guests.[type]			
			,Agilysys_Stay_V1.guests.player_id		
			,Agilysys_Stay_V1.guests.cms_type		
			,Agilysys_Stay_V1.guests.card_id_available	
			,Agilysys_Stay_V1.guests.gps_id			
			,Agilysys_Stay_V1.guests.opt_in_for_marketing	
			,Agilysys_Stay_V1.guests.merge_remnant			
	)
	
	SELECT @Description = 'Update Agilysys_Stay_V1.guests section with #guests'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	INSERT Agilysys_Stay_V1.guests
	(
		code			
		,id			
		,tenant_id		
		,anonymized		
		,anonymized_message	
		,create_time		
		,update_time		
		,archived		
		,external_profile_id	
		,first_name		
		,last_name		
		,anniversary		
		,birth_date		
		,middle_initial		
		,suffix			
		,title			
		,company_title		
		,pronunciation		
		,gender			
		,[language]		
		,alias			
		,company_name		
		,[type]			
		,player_id		
		,cms_type		
		,card_id_available	
		,gps_id			
		,opt_in_for_marketing	
		,merge_remnant		
		,SourceSystemId
		,CreatedOn
		,ModifiedOn
	)
	SELECT		
		code			
		,id			
		,tenant_id		
		,anonymized		
		,anonymized_message	
		,create_time		
		,update_time		
		,archived		
		,external_profile_id	
		,first_name		
		,last_name		
		,anniversary		
		,birth_date		
		,middle_initial		
		,suffix			
		,title			
		,company_title		
		,pronunciation		
		,gender			
		,[language]		
		,alias			
		,company_name		
		,[type]			
		,player_id		
		,cms_type		
		,card_id_available	
		,gps_id			
		,opt_in_for_marketing	
		,merge_remnant		
		,@SourceSystemId
		,GetDate()
		,GetDate()
	FROM #guests
	WHERE NOT EXISTS 
	(
		SELECT 1
		FROM	Agilysys_Stay_V1.guests
		WHERE	guests.tenant_id = #guests.tenant_id
		AND	guests.SourceSystemId = @SourceSystemId
	)
	
	SELECT @Description = 'Insert #guests into Agilysys_Stay_V1.guests'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #groups)
BEGIN
	SELECT @Description = 'Beginning Agilysys_Stay_V1.groups section'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	UPDATE Agilysys_Stay_V1.groups
	SET	account_id					= #groups.account_id				
		,adults_included				= #groups.adults_included			
		,allocation_id					= #groups.allocation_id				
		,booking_status					= #groups.booking_status				
		,cancellation_policy_id				= #groups.cancellation_policy_id			
		,children_included				= #groups.children_included			
		,create_time					= #groups.create_time				
		,deposit_policy_id				= #groups.deposit_policy_id			
		,end_date					= #groups.end_date				
		,extra_adult_charge				= #groups.extra_adult_charge			
		,extra_children_charge				= #groups.extra_children_charge			
		,group_code					= #groups.group_code				
		,group_name					= #groups.group_name				
		,guest_type_id					= #groups.guest_type_id				
		,market_segment_id				= #groups.market_segment_id			
		,profile_id					= #groups.profile_id				
		,source_of_business_id				= #groups.source_of_business_id			
		,[start_date]					= #groups.[start_date]				
		,tax_exempt					= #groups.tax_exempt				
		,tenant_id					= #groups.tenant_id				
		,update_time					= #groups.update_time				
		,rate_plan_id					= #groups.rate_plan_id				
		,shoulder_end_date				= #groups.shoulder_end_date			
		,shoulder_start_date				= #groups.shoulder_start_date			
		,transaction_item_id				= #groups.transaction_item_id			
		,confirmation_code				= #groups.confirmation_code			
		,released					= #groups.released				
		,profile_type					= #groups.profile_type				
		,[description]					= #groups.[description]				
		,rolling_release_enabled			= #groups.rolling_release_enabled		
		,auto_release_enabled				= #groups.auto_release_enabled			
		,cut_off_date					= #groups.cut_off_date				
		,departure_date					= #groups.departure_date				
		,housing_restricted				= #groups.housing_restricted			
		,room_blocks_for_shoulder_dates			= #groups.room_blocks_for_shoulder_dates		
		,allocate_blocks_for_shoulder_dates		= #groups.allocate_blocks_for_shoulder_dates	
		,overridden_arc_rule_id				= #groups.overridden_arc_rule_id			
		,wholesaler					= #groups.wholesaler				
	FROM Agilysys_Stay_V1.groups (NoLock)
		INNER JOIN #groups	ON groups.id = #groups.id	
					AND groups.property_id = #groups.property_id
	WHERE EXISTS
	(
		SELECT	#groups.account_id				
			,#groups.adults_included			
			,#groups.allocation_id				
			,#groups.booking_status			
			,#groups.cancellation_policy_id		
			,#groups.children_included			
			,#groups.create_time				
			,#groups.deposit_policy_id			
			,#groups.end_date				
			,#groups.extra_adult_charge			
			,#groups.extra_children_charge			
			,#groups.group_code				
			,#groups.group_name				
			,#groups.guest_type_id				
			,#groups.market_segment_id			
			,#groups.profile_id				
			,#groups.source_of_business_id			
			,#groups.[start_date]				
			,#groups.tax_exempt				
			,#groups.tenant_id				
			,#groups.update_time				
			,#groups.rate_plan_id				
			,#groups.shoulder_end_date			
			,#groups.shoulder_start_date			
			,#groups.transaction_item_id			
			,#groups.confirmation_code			
			,#groups.released				
			,#groups.profile_type				
			,#groups.[description]				
			,#groups.rolling_release_enabled		
			,#groups.auto_release_enabled			
			,#groups.cut_off_date				
			,#groups.departure_date			
			,#groups.housing_restricted			
			,#groups.room_blocks_for_shoulder_dates	
			,#groups.allocate_blocks_for_shoulder_dates	
			,#groups.overridden_arc_rule_id		
			,#groups.wholesaler				
		EXCEPT
		SELECT	Agilysys_Stay_V1.groups.account_id				
			,Agilysys_Stay_V1.groups.adults_included			
			,Agilysys_Stay_V1.groups.allocation_id				
			,Agilysys_Stay_V1.groups.booking_status			
			,Agilysys_Stay_V1.groups.cancellation_policy_id		
			,Agilysys_Stay_V1.groups.children_included			
			,Agilysys_Stay_V1.groups.create_time				
			,Agilysys_Stay_V1.groups.deposit_policy_id			
			,Agilysys_Stay_V1.groups.end_date				
			,Agilysys_Stay_V1.groups.extra_adult_charge			
			,Agilysys_Stay_V1.groups.extra_children_charge			
			,Agilysys_Stay_V1.groups.group_code				
			,Agilysys_Stay_V1.groups.group_name				
			,Agilysys_Stay_V1.groups.guest_type_id				
			,Agilysys_Stay_V1.groups.market_segment_id			
			,Agilysys_Stay_V1.groups.profile_id				
			,Agilysys_Stay_V1.groups.source_of_business_id			
			,Agilysys_Stay_V1.groups.[start_date]				
			,Agilysys_Stay_V1.groups.tax_exempt				
			,Agilysys_Stay_V1.groups.tenant_id				
			,Agilysys_Stay_V1.groups.update_time				
			,Agilysys_Stay_V1.groups.rate_plan_id				
			,Agilysys_Stay_V1.groups.shoulder_end_date			
			,Agilysys_Stay_V1.groups.shoulder_start_date			
			,Agilysys_Stay_V1.groups.transaction_item_id			
			,Agilysys_Stay_V1.groups.confirmation_code			
			,Agilysys_Stay_V1.groups.released				
			,Agilysys_Stay_V1.groups.profile_type				
			,Agilysys_Stay_V1.groups.[description]				
			,Agilysys_Stay_V1.groups.rolling_release_enabled		
			,Agilysys_Stay_V1.groups.auto_release_enabled			
			,Agilysys_Stay_V1.groups.cut_off_date				
			,Agilysys_Stay_V1.groups.departure_date			
			,Agilysys_Stay_V1.groups.housing_restricted			
			,Agilysys_Stay_V1.groups.room_blocks_for_shoulder_dates	
			,Agilysys_Stay_V1.groups.allocate_blocks_for_shoulder_dates	
			,Agilysys_Stay_V1.groups.overridden_arc_rule_id		
			,Agilysys_Stay_V1.groups.wholesaler
	)
	
	SELECT @Description = 'Update Agilysys_Stay_V1.groups section with #groups'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	INSERT Agilysys_Stay_V1.groups
	(
		id					
		,account_id				
		,adults_included			
		,allocation_id				
		,booking_status				
		,cancellation_policy_id			
		,children_included			
		,create_time				
		,deposit_policy_id			
		,end_date				
		,extra_adult_charge			
		,extra_children_charge			
		,group_code				
		,group_name				
		,guest_type_id				
		,market_segment_id			
		,profile_id				
		,property_id				
		,source_of_business_id			
		,[start_date]				
		,tax_exempt				
		,tenant_id				
		,update_time				
		,rate_plan_id				
		,shoulder_end_date			
		,shoulder_start_date			
		,transaction_item_id			
		,confirmation_code			
		,released				
		,profile_type				
		,[description]				
		,rolling_release_enabled		
		,auto_release_enabled			
		,cut_off_date				
		,departure_date				
		,housing_restricted			
		,room_blocks_for_shoulder_dates		
		,allocate_blocks_for_shoulder_dates	
		,overridden_arc_rule_id			
		,wholesaler					
		,SourceSystemId
		,CreatedOn
		,ModifiedOn
	)
	SELECT		
		id					
		,account_id				
		,adults_included			
		,allocation_id				
		,booking_status				
		,cancellation_policy_id			
		,children_included			
		,create_time				
		,deposit_policy_id			
		,end_date				
		,extra_adult_charge			
		,extra_children_charge			
		,group_code				
		,group_name				
		,guest_type_id				
		,market_segment_id			
		,profile_id				
		,property_id				
		,source_of_business_id			
		,[start_date]				
		,tax_exempt				
		,tenant_id				
		,update_time				
		,rate_plan_id				
		,shoulder_end_date			
		,shoulder_start_date			
		,transaction_item_id			
		,confirmation_code			
		,released				
		,profile_type				
		,[description]				
		,rolling_release_enabled		
		,auto_release_enabled			
		,cut_off_date				
		,departure_date				
		,housing_restricted			
		,room_blocks_for_shoulder_dates		
		,allocate_blocks_for_shoulder_dates	
		,overridden_arc_rule_id			
		,wholesaler
		,@SourceSystemId
		,GetDate()
		,GetDate()
	FROM #groups
	WHERE NOT EXISTS 
	(
		SELECT 1
		FROM	Agilysys_Stay_V1.groups
		WHERE	groups.id = #groups.id	
		AND	groups.property_id = #groups.property_id
		AND	groups.SourceSystemId = @SourceSystemId
	)
	
	SELECT @Description = 'Insert #groups into Agilysys_Stay_V1.groups'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #rooms)
BEGIN
	SELECT @Description = 'Beginning Agilysys_Stay_V1.rooms section'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	UPDATE Agilysys_Stay_V1.rooms
	SET	is_ada				= #rooms.is_ada				
		,last_sell			= #rooms.last_sell			
		,reset_value			= #rooms.reset_value			
		,rack_number			= #rooms.rack_number			
		,room_number			= #rooms.room_number			
		,room_type_id			= #rooms.room_type_id			
		,building_id			= #rooms.building_id			
		,floor_id			= #rooms.floor_id			
		,create_time			= #rooms.create_time			
		,tenant_id			= #rooms.tenant_id			
		,update_time			= #rooms.update_time			
		,total_days_occupied		= #rooms.total_days_occupied		
		,housekeeping_room_condition	= #rooms.housekeeping_room_condition	
		,occupancy_status		= #rooms.occupancy_status		
		,[start_date]			= #rooms.[start_date]			
		,end_date			= #rooms.end_date			
		,suite				= #rooms.suite				
		,[description]			= #rooms.[description]			
		,connecting_room_ids		= #rooms.connecting_room_ids		
		,no_of_associated_rooms		= #rooms.no_of_associated_rooms		
	FROM Agilysys_Stay_V1.rooms (NoLock)
		INNER JOIN #rooms	ON rooms.id = #rooms.id	
					AND rooms.property_id = #rooms.property_id
	WHERE EXISTS
	(
		SELECT	#rooms.is_ada				
			,#rooms.last_sell			
			,#rooms.reset_value			
			,#rooms.rack_number			
			,#rooms.room_number			
			,#rooms.room_type_id			
			,#rooms.building_id			
			,#rooms.floor_id			
			,#rooms.create_time			
			,#rooms.tenant_id			
			,#rooms.update_time			
			,#rooms.total_days_occupied		
			,#rooms.housekeeping_room_condition	
			,#rooms.occupancy_status		
			,#rooms.[start_date]			
			,#rooms.end_date			
			,#rooms.suite				
			,#rooms.[description]			
			,#rooms.connecting_room_ids		
			,#rooms.no_of_associated_rooms		
		EXCEPT
		SELECT	Agilysys_Stay_V1.rooms.is_ada				
			,Agilysys_Stay_V1.rooms.last_sell			
			,Agilysys_Stay_V1.rooms.reset_value			
			,Agilysys_Stay_V1.rooms.rack_number			
			,Agilysys_Stay_V1.rooms.room_number			
			,Agilysys_Stay_V1.rooms.room_type_id			
			,Agilysys_Stay_V1.rooms.building_id			
			,Agilysys_Stay_V1.rooms.floor_id			
			,Agilysys_Stay_V1.rooms.create_time			
			,Agilysys_Stay_V1.rooms.tenant_id			
			,Agilysys_Stay_V1.rooms.update_time			
			,Agilysys_Stay_V1.rooms.total_days_occupied		
			,Agilysys_Stay_V1.rooms.housekeeping_room_condition	
			,Agilysys_Stay_V1.rooms.occupancy_status		
			,Agilysys_Stay_V1.rooms.[start_date]			
			,Agilysys_Stay_V1.rooms.end_date			
			,Agilysys_Stay_V1.rooms.suite				
			,Agilysys_Stay_V1.rooms.[description]			
			,Agilysys_Stay_V1.rooms.connecting_room_ids		
			,Agilysys_Stay_V1.rooms.no_of_associated_rooms					
	)
	
	SELECT @Description = 'Update Agilysys_Stay_V1.rooms section with #rooms'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	INSERT Agilysys_Stay_V1.rooms
	(
		id				
		,is_ada				
		,last_sell			
		,reset_value			
		,rack_number			
		,room_number			
		,room_type_id			
		,building_id			
		,floor_id			
		,create_time			
		,property_id			
		,tenant_id			
		,update_time			
		,total_days_occupied		
		,housekeeping_room_condition	
		,occupancy_status		
		,[start_date]			
		,end_date			
		,suite				
		,[description]			
		,connecting_room_ids		
		,no_of_associated_rooms			
		,SourceSystemId
		,CreatedOn
		,ModifiedOn
	)
	SELECT	id				
		,is_ada				
		,last_sell			
		,reset_value			
		,rack_number			
		,room_number			
		,room_type_id			
		,building_id			
		,floor_id			
		,create_time			
		,property_id			
		,tenant_id			
		,update_time			
		,total_days_occupied		
		,housekeeping_room_condition	
		,occupancy_status		
		,[start_date]			
		,end_date			
		,suite				
		,[description]			
		,connecting_room_ids		
		,no_of_associated_rooms	
		,@SourceSystemId
		,GetDate()
		,GetDate()
	FROM #rooms
	WHERE NOT EXISTS 
	(
		SELECT 1
		FROM	Agilysys_Stay_V1.rooms
		WHERE	rooms.id = #rooms.id	
		AND	rooms.property_id = #rooms.property_id
		AND	rooms.SourceSystemId = @SourceSystemId
	)
	
	SELECT @Description = 'Insert #rooms into Agilysys_Stay_V1.rooms'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #room_classes)
BEGIN
	SELECT @Description = 'Beginning Agilysys_Stay_V1.room_classes section'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	UPDATE Agilysys_Stay_V1.room_classes
	SET	[name]		= #room_classes.[name]			
		,active		= #room_classes.active			
		,tenant_id	= #room_classes.tenant_id		
		,[rank]		= #room_classes.[rank]			
	FROM Agilysys_Stay_V1.room_classes (NoLock)
		INNER JOIN #room_classes	ON room_classes.id = #room_classes.id	
						AND room_classes.property_id = #room_classes.property_id
	WHERE EXISTS
	(
		SELECT	#room_classes.[name]		
			,#room_classes.active		
			,#room_classes.tenant_id	
			,#room_classes.[rank]		
			
		EXCEPT
		SELECT	Agilysys_Stay_V1.room_classes.[name]	
			,Agilysys_Stay_V1.room_classes.active	
			,Agilysys_Stay_V1.room_classes.tenant_id
			,Agilysys_Stay_V1.room_classes.[rank]	
	)
	
	SELECT @Description = 'Update Agilysys_Stay_V1.room_classes section with #room_classes'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	INSERT Agilysys_Stay_V1.room_classes
	(
		id			
		,[name]			
		,active			
		,tenant_id		
		,property_id		
		,[rank]			
		,SourceSystemId
		,CreatedOn
		,ModifiedOn
	)
	SELECT	
		id			
		,[name]			
		,active			
		,tenant_id		
		,property_id		
		,[rank]			
		,@SourceSystemId
		,GetDate()
		,GetDate()
	FROM #room_classes
	WHERE NOT EXISTS 
	(
		SELECT 1
		FROM	Agilysys_Stay_V1.room_classes
		WHERE	room_classes.id = #room_classes.id	
		AND	room_classes.property_id = #room_classes.property_id
		AND	room_classes.SourceSystemId = @SourceSystemId
	)
	
	SELECT @Description = 'Insert #room_classes into Agilysys_Stay_V1.room_classes'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #room_types)
BEGIN
	SELECT @Description = 'Beginning Agilysys_Stay_V1.#room_types section'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	UPDATE Agilysys_Stay_V1.room_types
	SET	[name]				= #room_types.[name]				
		,type_code			= #room_types.type_code			
		,housekeeping_pattern_id	= #room_types.housekeeping_pattern_id	
		,is_ada				= #room_types.is_ada				
		,is_virtual			= #room_types.is_virtual			
		,max_guests			= #room_types.max_guests			
		,max_pets			= #room_types.max_pets			
		,non_bedded			= #room_types.non_bedded			
		,default_building_id		= #room_types.default_building_id		
		,pets				= #room_types.pets				
		,room_class_id			= #room_types.room_class_id			
		,tenant_id			= #room_types.tenant_id			
		,is_roh				= #room_types.is_roh				
		,[description]			= #room_types.[description]			
		,smoking_allowed		= #room_types.smoking_allowed		
		,bed_ids			= #room_types.bed_ids					
		,suite				= #room_types.suite						
	FROM Agilysys_Stay_V1.room_types (NoLock)
		INNER JOIN #room_types	ON room_types.id = #room_types.id	
					AND room_types.property_id = #room_types.property_id
	WHERE EXISTS
	(
		SELECT	#room_types.[name]				
			,#room_types.type_code			
			,#room_types.housekeeping_pattern_id	
			,#room_types.is_ada				
			,#room_types.is_virtual			
			,#room_types.max_guests			
			,#room_types.max_pets			
			,#room_types.non_bedded			
			,#room_types.default_building_id		
			,#room_types.pets				
			,#room_types.room_class_id			
			,#room_types.tenant_id			
			,#room_types.is_roh				
			,#room_types.[description]			
			,#room_types.smoking_allowed		
			,#room_types.bed_ids					
			,#room_types.suite					
		EXCEPT
		SELECT	Agilysys_Stay_V1.room_types.[name]				
			,Agilysys_Stay_V1.room_types.type_code			
			,Agilysys_Stay_V1.room_types.housekeeping_pattern_id	
			,Agilysys_Stay_V1.room_types.is_ada				
			,Agilysys_Stay_V1.room_types.is_virtual			
			,Agilysys_Stay_V1.room_types.max_guests			
			,Agilysys_Stay_V1.room_types.max_pets			
			,Agilysys_Stay_V1.room_types.non_bedded			
			,Agilysys_Stay_V1.room_types.default_building_id		
			,Agilysys_Stay_V1.room_types.pets				
			,Agilysys_Stay_V1.room_types.room_class_id			
			,Agilysys_Stay_V1.room_types.tenant_id			
			,Agilysys_Stay_V1.room_types.is_roh				
			,Agilysys_Stay_V1.room_types.[description]			
			,Agilysys_Stay_V1.room_types.smoking_allowed		
			,Agilysys_Stay_V1.room_types.bed_ids					
			,Agilysys_Stay_V1.room_types.suite	
	)
	
	SELECT @Description = 'Update Agilysys_Stay_V1.room_types section with #room_types'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR

	INSERT Agilysys_Stay_V1.room_types
	(
		id				
		,[name]				
		,type_code			
		,housekeeping_pattern_id	
		,is_ada				
		,is_virtual			
		,max_guests			
		,max_pets			
		,non_bedded			
		,default_building_id		
		,pets				
		,property_id			
		,room_class_id			
		,tenant_id			
		,is_roh				
		,[description]			
		,smoking_allowed		
		,bed_ids			
		,suite						
		,SourceSystemId
		,CreatedOn
		,ModifiedOn
	)
	SELECT	
		id				
		,[name]				
		,type_code			
		,housekeeping_pattern_id	
		,is_ada				
		,is_virtual			
		,max_guests			
		,max_pets			
		,non_bedded			
		,default_building_id		
		,pets				
		,property_id			
		,room_class_id			
		,tenant_id			
		,is_roh				
		,[description]			
		,smoking_allowed		
		,bed_ids			
		,suite	
		,@SourceSystemId
		,GetDate()
		,GetDate()
	FROM #room_types
	WHERE NOT EXISTS 
	(
		SELECT 1
		FROM	Agilysys_Stay_V1.room_types
		WHERE	room_types.id = #room_types.id	
		AND	room_types.property_id = #room_types.property_id
		AND	room_types.SourceSystemId = @SourceSystemId
	)
	
	SELECT @Description = 'Insert #room_types into Agilysys_Stay_V1.room_types'
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

-------------------------------
/* Update Source System Keys */
-------------------------------
IF EXISTS (SELECT 1 FROM #transaction_item_revenue_aggregate)
BEGIN
	SELECT @Key_transaction_item_revenue_aggregate = ISNULL((SELECT MAX(#transaction_item_revenue_aggregate.[date]) FROM #transaction_item_revenue_aggregate), @Key_transaction_item_revenue_aggregate)

	EXECUTE spLoadData_SetKey @SourceSystemId = @SourceSystemId, @TableName = 'transaction_item_revenue_aggregate', @ColumnName = 'Date', @Key = Null, @KeyString = Null, @KeyDateTime = @Key_transaction_item_revenue_aggregate
	
	SELECT @Description = 'Update DateTime key for ' + CONVERT(NVARCHAR(1000), 'transaction_item_revenue_aggregate')
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #properties)
BEGIN
	SELECT @Key_properties = ISNULL((SELECT MAX(#properties.update_time) FROM #properties), @Key_properties)

	EXECUTE spLoadData_SetKey @SourceSystemId = @SourceSystemId, @TableName = 'properties', @ColumnName = 'create_time', @Key = Null, @KeyString = Null, @KeyDateTime = @Key_properties
	
	SELECT @Description = 'Update DateTime key for ' + CONVERT(NVARCHAR(1000), 'properties')
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #reservations)
BEGIN
	SELECT @Key_reservations = ISNULL((SELECT MAX(#reservations.update_time) FROM #reservations), @Key_properties)

	EXECUTE spLoadData_SetKey @SourceSystemId = @SourceSystemId, @TableName = 'reservations', @ColumnName = 'create_time', @Key = Null, @KeyString = Null, @KeyDateTime = @Key_reservations
	
	SELECT @Description = 'Update DateTime key for ' + CONVERT(NVARCHAR(1000), 'reservations')
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #guests)
BEGIN
	SELECT @Key_reservations = ISNULL((SELECT MAX(#guests.update_time) FROM #guests), @Key_properties)

	EXECUTE spLoadData_SetKey @SourceSystemId = @SourceSystemId, @TableName = 'guests', @ColumnName = 'create_time', @Key = Null, @KeyString = Null, @KeyDateTime = @Key_reservations
	
	SELECT @Description = 'Update DateTime key for ' + CONVERT(NVARCHAR(1000), 'guests')
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #groups)
BEGIN
	SELECT @Key_groups = ISNULL((SELECT MAX(#groups.update_time) FROM #groups), @Key_groups)

	EXECUTE spLoadData_SetKey @SourceSystemId = @SourceSystemId, @TableName = 'groups', @ColumnName = 'update_time', @Key = Null, @KeyString = Null, @KeyDateTime = @Key_groups
	
	SELECT @Description = 'Update DateTime key for ' + CONVERT(NVARCHAR(1000), 'groups')
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

IF EXISTS (SELECT 1 FROM #rooms)
BEGIN
	SELECT @Key_rooms = ISNULL((SELECT MAX(#rooms.update_time) FROM #rooms), @Key_rooms)

	EXECUTE spLoadData_SetKey @SourceSystemId = @SourceSystemId, @TableName = 'rooms', @ColumnName = 'create_time', @Key = Null, @KeyString = Null, @KeyDateTime = @Key_rooms
	
	SELECT @Description = 'Update DateTime key for ' + CONVERT(NVARCHAR(1000), 'rooms')
		,@RowCount = @@ROWCOUNT, @ErrorCode = @@ERROR, @StartDate = @StartDate
	EXECUTE [dbo].[spLoadData_CreateSourceSystemLogEvent] @SourceSystemLogId = @SourceSystemLogId, @RowCount = @RowCount, @ErrorCode = @ErrorCode
		,@ErrorCodeReturn = @ErrorCode OUT, @ErrorMessage = @ErrorMessage, @ErrorMessageReturn = @ErrorMessage OUT, @StartDate = @StartDate OUT
		,@Description = @Description, @DescriptionReturn = @Description OUT
	IF @ErrorCodeReturn <> 0 GOTO ERROR
END

DROP TABLE #transaction_item_revenue_aggregate
DROP TABLE #properties
DROP TABLE #reservations
DROP TABLE #groups
DROP TABLE #rooms
DROP TABLE #room_classes
DROP TABLE #room_types

NOERROR:
	RETURN 0
ERROR:
	SELECT @ErrorMessage = 'ERROR:  ' + @ErrorMessage
	RAISERROR(@ErrorMessage, 11, -1)

END
GO

