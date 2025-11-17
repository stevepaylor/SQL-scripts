USE [StayDWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP VIEW IF EXISTS [dbo].[vw_comp_offer_details_Original] ;
GO

CREATE VIEW [dbo].[vw_comp_offer_details_Original] AS
SELECT * FROM OPENQUERY(Stay_PostgreSQL,'
SELECT cod.id, cod.reservation_id, cod.offer_id, cod.player_id, cod.card_id, cod.offer_date, cod.offer_type, co.offer_code, co.offer_name, cod.resolution, cod.offer_status, cod.error
FROM stay_prod.public.comp_offer_details cod
LEFT JOIN stay_prod.public.comp_offers co ON cod.offer_id=co.id
WHERE offer_date > ''2024-03-17''
')
GO

DROP VIEW IF EXISTS [dbo].[vw_comp_offer_details] ;
GO

CREATE VIEW [dbo].[vw_comp_offer_details] AS
SELECT 
  cod.id
, cod.reservation_id
, cod.offer_id
, cod.player_id
, cod.card_id
, cod.offer_date
, cod.offer_type
, co.offer_code
, co.offer_name
, cod.resolution
, cod.offer_status
, cod.error

FROM dbo.comp_offer_details cod
LEFT JOIN dbo.comp_offers co 
ON cod.offer_id=co.id

WHERE offer_date > '2024-03-17'
GO

DROP VIEW IF EXISTS [dbo].[vw_Line_items_Original] ;
GO

CREATE VIEW [dbo].[vw_Line_items_Original] AS
SELECT * FROM OPENQUERY(Stay_PostgreSQL,'
SELECT 
  li.id 
, li.account_id 
, ac.name ac_name
, ac.account_type
, rv.arrival_date
, rv.departure_date
, rv.cancellation_date
, rv.checkin_at
, rv.checkout_at
, rv.early_arrival
, rv.early_check_in_time
, rv.late_checkout_time
, CAST(rv.player_id as varchar(200)) as player_id
, CAST(rv.primary_guest_first_name as varchar(200)) as primary_guest_first_name
, CAST(rv.primary_guest_last_name as varchar(200)) as primary_guest_last_name
, cod.offer_date
, cod.offer_type
, co.offer_code
, co.offer_name
, cod.resolution
, cod.offer_status
, li.amount 
, li.category_id 
, cg.name cg_name
, cg.code as cg_code
, li.display_date 
, li.folio_id 
, f.name f_name
, li.accounting_item_id 
, ai.type ai_type
, ai.general_ledger_code
, ai.name ai_name
, ai.code as ai_code
, li.ledger_id 
, li.property_id 
, li.quantity 
, li.room_revenue 
, li.subcategory_id 
, sc.name sc_name
, sc.code as sc_code
, li.tenant_id 
, li.user_id 
, li.ledger_lines_ledger_transaction_id 
, lt.destination_ledger_id
, lt.type lt_type
, li.folio_lines_ledger_transaction_id 
, li.tax_reference_id 
, li.adjustment_reference_id 
, li.call_type 
, li.correction_reference_id 
, li.description 
, li.free_allowance_amount 
, li.gateway_type 
, li.gift_card 
, li.invalid 
, li.meal_period_id 
, li.rate_change_comment 
, li.reason 
, li.recurring_charge_id 
, li.reference 
, li.refund_reference_id 
, li.reservation_id 
, li.reverse_tax_total_charge_amount 
, li.reverse_tax 
, li.room_charge_posting_type 
, li.source_id 
, li.transfer_reference_id 
, li.pantry_item 
, li.comp_id 
, c.reason c_reason
, c.discount_type c_discount_type
, li.check_number 
, li.exclude_tax 
, li.reference_number 
, li.comp_reference_id 
, li.room_id 
, r.rack_number
, r.room_number
, rt.name rt_name
, rt.type_code as rt_type_code
, rt.is_ada
, rt.max_guests
, rt.smoking_allowed
, li.routed 
, li.source_folio_line_item_id 
, li.payment_method_id 
, li.posting_rule_id 
, li.issuer 
, li.last_four_digits 
, li.payment_interface_id 
, li.revised_adjustment_amount 
, li.is_manage_dispute_adjustment 
, li.corrected_or_adjusted_amount 
, li.deposit_payment_at_booking 
, li.auth_code 
FROM stay_prod.public.reservations rv
LEFT JOIN stay_prod.public.comp_offer_details cod ON rv.id=cod.reservation_id
LEFT JOIN stay_prod.public.comp_offers co ON cod.offer_id=co.id
LEFT JOIN stay_prod.public.line_items li ON rv.id=li.reservation_id
LEFT JOIN stay_prod.public.accounts ac ON li.account_id=ac.id
LEFT JOIN stay_prod.public.categories cg ON li.category_id=cg.id
LEFT JOIN stay_prod.public.folios f ON li.folio_id=f.id
LEFT JOIN stay_prod.public.accounting_items ai ON li.accounting_item_id=ai.id
LEFT JOIN stay_prod.public.subcategories sc ON li.subcategory_id=sc.id
LEFT JOIN stay_prod.public.ledger_transactions lt ON li.ledger_lines_ledger_transaction_id=lt.id
LEFT JOIN stay_prod.public.comps c ON li.comp_id=c.id
LEFT JOIN stay_prod.public.rooms r ON li.room_id=r.id
LEFT JOIN stay_prod.public.room_types rt ON r.room_type_id=rt.id
WHERE rv.arrival_date > ''2024-03-17''
')
GO

DROP VIEW IF EXISTS [dbo].[vw_Line_items] ;
GO

CREATE VIEW [dbo].[vw_Line_items] AS
SELECT 
  li.id 
, li.account_id 
, ac.[name] as ac_name
, ac.account_type
, rv.arrival_date
, rv.departure_date
, rv.cancellation_date
, rv.checkin_at
, rv.checkout_at
, rv.early_arrival
, rv.early_check_in_time
, rv.late_checkout_time
, rv.player_id
, rv.primary_guest_first_name
, rv.primary_guest_last_name
, cod.offer_date
, cod.offer_type
, co.offer_code
, co.offer_name
, cod.resolution
, cod.offer_status
, li.amount 
, li.category_id 
, cg.[name] as cg_name
, cg.code as cg_code
, li.display_date 
, li.folio_id 
, f.[name] as f_name
, li.accounting_item_id 
, ai.[type] as ai_type
, ai.general_ledger_code
, ai.[name] as ai_name
, ai.code as ai_code
, li.ledger_id 
, li.property_id 
, li.quantity 
, li.room_revenue 
, li.subcategory_id 
, sc.[name] as sc_name
, sc.code as sc_code
, li.tenant_id 
, li.[user_id] 
, li.ledger_lines_ledger_transaction_id 
, lt.destination_ledger_id
, lt.[type] as lt_type
, li.folio_lines_ledger_transaction_id 
, li.tax_reference_id 
, li.adjustment_reference_id 
, li.call_type 
, li.correction_reference_id 
, li.[description]
, li.free_allowance_amount 
, li.gateway_type 
, li.gift_card 
, li.invalid 
, li.meal_period_id 
, li.rate_change_comment 
, li.reason as li_reason
, li.recurring_charge_id 
, li.reference 
, li.refund_reference_id 
, li.reservation_id 
, li.reverse_tax_total_charge_amount 
, li.reverse_tax 
, li.room_charge_posting_type 
, li.source_id 
, li.transfer_reference_id 
, li.pantry_item 
, li.comp_id 
, c.reason as c_reason
, c.discount_type
, li.check_number 
, li.exclude_tax 
, li.reference_number 
, li.comp_reference_id 
, li.room_id 
, r.rack_number
, r.room_number
, rt.[name] as rt_name
, rt.type_code
, rt.is_ada
, rt.max_guests
, rt.smoking_allowed
, li.routed 
, li.source_folio_line_item_id 
, li.payment_method_id 
, li.posting_rule_id 
, li.issuer 
, li.last_four_digits 
, li.payment_interface_id 
, li.revised_adjustment_amount 
, li.is_manage_dispute_adjustment 
, li.corrected_or_adjusted_amount 
, li.deposit_payment_at_booking 
, li.auth_code

FROM dbo.reservations rv
LEFT JOIN dbo.comp_offer_details cod 
ON rv.id=cod.reservation_id
LEFT JOIN dbo.comp_offers co 
ON cod.offer_id=co.id
LEFT JOIN dbo.line_items li 
ON rv.id=li.reservation_id
LEFT JOIN dbo.accounts ac 
ON li.account_id=ac.id
LEFT JOIN dbo.categories cg 
ON li.category_id=cg.id
LEFT JOIN dbo.folios f 
ON li.folio_id=f.id
LEFT JOIN dbo.accounting_items ai 
ON li.accounting_item_id=ai.id
LEFT JOIN dbo.subcategories sc 
ON li.subcategory_id=sc.id
LEFT JOIN dbo.ledger_transactions lt 
ON li.ledger_lines_ledger_transaction_id=lt.id
LEFT JOIN dbo.comps c 
ON li.comp_id=c.id
LEFT JOIN dbo.rooms r 
ON li.room_id=r.id
LEFT JOIN dbo.room_types rt 
ON r.room_type_id=rt.id

WHERE rv.arrival_date > '2024-03-17'
GO

DROP VIEW IF EXISTS [dbo].[vw_Reservations_Original] ;
GO

CREATE VIEW [dbo].[vw_Reservations_Original] AS
SELECT * FROM OPENQUERY(Stay_PostgreSQL,'
SELECT 
  CAST(r.id as varchar(200)) as id
, CAST(r.account_id as varchar(200)) as account_id
, CAST(r.allocation_id as varchar(200)) allocation_id
, al.allocation_type
--, al.inventory_block_type
--, al.start_date al_start_dt
--, al.end_date al_end_dt
--, al.reason al_reason
, CAST(r.confirmation_code as varchar(200)) as confirmation_code
, r.arrival_date
, r.departure_date
, r.cancellation_date
, r.create_time
, r.early_arrival
, r.early_check_in_time
, r.late_checkout_time
, r.number_of_adults
, r.number_of_children
, CAST(r.primary_guest_first_name as varchar(200)) as primary_guest_first_name
, CAST(r.primary_guest_last_name as varchar(200)) as primary_guest_last_name
, CAST(r.player_id as varchar(200)) as player_id
, CAST(r.primary_guest_id as varchar(200)) as primary_guest_id
, g.code
, g.cms_type
, CAST(r.property_id as varchar(200)) as property_id
, CAST(r.reservation_alias as varchar(200)) as reservation_alias
, CAST(r.status as varchar(200)) as status
, CAST(r.tenant_id as varchar(200)) as tenant_id
, CAST(r.guest_type_id as varchar(200)) as guest_type_id
, gt.name gt_name
, gt.code gt_code
, CAST(r.market_segment_id as varchar(200)) as market_segment_id
, ms.name ms_name
, ms.code ms_code
, CAST(r.source_of_business_id as varchar(200)) as source_of_business_id
, sb.name sb_name
, sb.code sb_code
, r.update_time
, CAST(r.company_id as varchar(200)) as company_id
, CAST(r.group_id as varchar(200)) as group_id
, gp.booking_status
, gp.group_code
, gp.group_name
, CAST(r.vip_status_id as varchar(200)) as vip_status_id
, vs.code v_code
, vs.name v_name
, r.non_registered_guest
, r.walk_in
, CAST(r.cancellation_policy_id as varchar(200)) as cancellation_policy_id
, cp.code cp_code
, cp.description cp_description
, CAST(r.deposit_policy_id as varchar(200)) as deposit_policy_id
, dp.policy_type
, dp.code dp_code
, dp.name dp_name
, CAST(r.booked_by as varchar(200)) as booked_by
, CAST(r.cancellation_reason as varchar(200)) as cancellation_reason
, CAST(r.cancelled_by as varchar(200)) as cancelled_by
, CAST(array_to_string(r.agent_ids, '' , ''''*'') as varchar(100)) as agent_ids
, r.do_not_move_room
, CAST(r.cancellation_policy_overridden_by as varchar(200)) as cancellation_policy_overridden_by
, r.cancellation_policy_overridden_amount
, r.cancellation_policy_overridden_percentage
, CAST(r.overridden_cancellation_policy_id as varchar(200)) as overridden_cancellation_policy_id
, r.estimated_time_of_arrival
, r.estimated_time_of_departure
, CAST(r.booker_id as varchar(200)) as booker_id
, r.cancellation_time_utc
, r.web_check_in
, r.suppress_rate
, r.no_of_documents
, CAST(r.share_id as varchar(200)) as share_id
, r.no_of_pets
, r.web_check_out
, r.room_ready_sms_enabled
, r.web_check_in_sms_enabled
, r.web_check_out_sms_enabled
, CAST(array_to_string(r.room_feature_preference_names, '' , ''''*'') as varchar(100)) as room_feature_preference_names
, r.number_of_guests
, CAST(array_to_string(r.guest_preference_ids, '' , ''''*'') as varchar(100)) as guest_preference_ids
, CAST(r.housekeeping_pattern_id as varchar(200)) as housekeeping_pattern_id
, r.deposit_policy_amount
, r.deposit_policy_tax
, r.number_of_age_category1
, r.number_of_age_category2
, r.deposit_total_due
, CAST(r.source_interface_id as varchar(200)) as source_interface_id
, CAST(r.old_pms_confirmation_code as varchar(200)) as old_pms_confirmation_code
, r.checkin_at
, CAST(r.checkin_by as varchar(200)) as checkin_by
, r.checkout_at
, CAST(r.checkout_by as varchar(200)) as checkout_by
, CAST(r.do_not_move_reason_description as varchar(200)) as do_not_move_reason_description
, r.do_not_move_reason_date_time
, CAST(r.do_not_move_reason_updated_by as varchar(200)) as do_not_move_reason_updated_by
, CAST(r.do_not_move_reason_id as varchar(200)) as do_not_move_reason_id
, r._export_ts
, r.comp_overridden
, CAST(r.comp_overridden_user as varchar(200)) as comp_overridden_user
, r._export_create_ts
, r._export_update_ts
, r.moved_status
FROM public.reservations r
LEFT JOIN stay_prod.public.allocations al ON r.allocation_id=al.id
LEFT JOIN stay_prod.public.vip_statuses vs ON r.vip_status_id=vs.id
LEFT JOIN stay_prod.public.guests g ON r.primary_guest_id=g.id
LEFT JOIN stay_prod.public.guest_types gt ON r.guest_type_id=gt.id
LEFT JOIN stay_prod.public.market_segments ms ON r.market_segment_id=ms.id
LEFT JOIN stay_prod.public.source_of_businesses sb ON r.source_of_business_id=sb.id
LEFT JOIN stay_prod.public.groups gp ON r.group_id=gp.id
LEFT JOIN stay_prod.public.cancellation_policies cp ON r.cancellation_policy_id=cp.id
LEFT JOIN stay_prod.public.deposit_policies dp ON r.deposit_policy_id=dp.id
WHERE r.arrival_date > ''2024-03-17''
')
GO

DROP VIEW IF EXISTS [dbo].[vw_Reservations] ;
GO

CREATE VIEW [dbo].[vw_Reservations] AS
SELECT 
  r.id
, r.account_id
, r.allocation_id
, al.allocation_type
--, al.inventory_block_type
--, al.start_date al_start_dt
--, al.end_date al_end_dt
--, al.reason al_reason
, r.confirmation_code
, r.arrival_date
, r.departure_date
, r.cancellation_date
, r.create_time
, r.early_arrival
, r.early_check_in_time
, r.late_checkout_time
, r.number_of_adults
, r.number_of_children
, r.primary_guest_first_name
, r.primary_guest_last_name
, r.player_id
, r.primary_guest_id
, g.code
, g.cms_type
, r.property_id
, r.reservation_alias
, r.[status]
, r.tenant_id
, r.guest_type_id
, gt.[name]
, gt.code as gt_code
, r.market_segment_id
, ms.[name] as ms_name
, ms.code as ms_code
, r.source_of_business_id
, sb.[name] as sb_name
, sb.code as sb_code
, r.update_time
, r.company_id
, r.group_id
, gp.booking_status
, gp.group_code
, gp.group_name
, r.vip_status_id
, vs.code as v_code
, vs.[name] as v_name
, r.non_registered_guest
, r.walk_in
, r.cancellation_policy_id
, cp.code as cp_code
, cp.[description]
, r.deposit_policy_id
, dp.policy_type
, dp.code dp_code
, dp.[name] as dp_name
, r.booked_by
, r.cancellation_reason
, r.cancelled_by
, r.agent_ids
, r.do_not_move_room
, r.cancellation_policy_overridden_by
, r.cancellation_policy_overridden_amount
, r.cancellation_policy_overridden_percentage
, r.overridden_cancellation_policy_id
, r.estimated_time_of_arrival
, r.estimated_time_of_departure
, r.booker_id
, r.cancellation_time_utc
, r.web_check_in
, r.suppress_rate
, r.no_of_documents
, r.share_id
, r.no_of_pets
, r.web_check_out
, r.room_ready_sms_enabled
, r.web_check_in_sms_enabled
, r.web_check_out_sms_enabled
, room_feature_preference_names
, r.number_of_guests
, r.guest_preference_ids
, r.housekeeping_pattern_id
, r.deposit_policy_amount
, r.deposit_policy_tax
, r.number_of_age_category1
, r.number_of_age_category2
, r.deposit_total_due
, r.source_interface_id
, r.old_pms_confirmation_code
, r.checkin_at
, r.checkin_by
, r.checkout_at
, r.checkout_by
, r.do_not_move_reason_description
, r.do_not_move_reason_date_time
, r.do_not_move_reason_updated_by
, r.do_not_move_reason_id
, r._export_ts
, r.comp_overridden
, r.comp_overridden_user
, r._export_create_ts
, r._export_update_ts
, r.moved_status

FROM dbo.reservations r
LEFT JOIN dbo.allocations al 
ON r.allocation_id=al.id
LEFT JOIN dbo.vip_statuses vs 
ON r.vip_status_id=vs.id
LEFT JOIN dbo.guests g 
ON r.primary_guest_id=g.id
LEFT JOIN dbo.guest_types gt 
ON r.guest_type_id=gt.id
LEFT JOIN dbo.market_segments ms 
ON r.market_segment_id=ms.id
LEFT JOIN dbo.source_of_businesses sb 
ON r.source_of_business_id=sb.id
LEFT JOIN dbo.groups gp 
ON r.group_id=gp.id
LEFT JOIN dbo.cancellation_policies cp 
ON r.cancellation_policy_id=cp.id
LEFT JOIN dbo.deposit_policies dp 
ON r.deposit_policy_id=dp.id

WHERE r.arrival_date > '2024-03-17'

GO

DROP VIEW IF EXISTS [dbo].[vw_Reservations_VIE_Original] ;
GO

CREATE VIEW [dbo].[vw_Reservations_VIE_Original] AS
SELECT * FROM OPENQUERY(Stay_PostgreSQL,'
SELECT 
  CAST(r.id as varchar(200)) as id
, CAST(r.account_id as varchar(200)) as account_id
, CAST(r.allocation_id as varchar(200)) allocation_id
, al.allocation_type
, al.inventory_block_type
, al.start_date al_start_dt
, al.end_date al_end_dt
, al.reason al_reason
, CAST(r.confirmation_code as varchar(200)) as confirmation_code
, r.arrival_date
, r.departure_date
, r.cancellation_date
, r.create_time
, r.early_arrival
, r.early_check_in_time
, r.late_checkout_time
, r.number_of_adults
, r.number_of_children
, CAST(r.primary_guest_first_name as varchar(200)) as primary_guest_first_name
, CAST(r.primary_guest_last_name as varchar(200)) as primary_guest_last_name
, CAST(r.player_id as varchar(200)) as player_id
, CAST(r.primary_guest_id as varchar(200)) as primary_guest_id
, g.code
, g.cms_type
, CAST(r.property_id as varchar(200)) as property_id
, CAST(r.reservation_alias as varchar(200)) as reservation_alias
, CAST(r.status as varchar(200)) as status
, CAST(r.tenant_id as varchar(200)) as tenant_id
, CAST(r.guest_type_id as varchar(200)) as guest_type_id
, gt.name gt_name
, gt.code gt_code
, CAST(r.market_segment_id as varchar(200)) as market_segment_id
, ms.name ms_name
, ms.code ms_code
, CAST(r.source_of_business_id as varchar(200)) as source_of_business_id
, sb.name sb_name
, sb.code sb_code
, r.update_time
, CAST(r.company_id as varchar(200)) as company_id
, CAST(r.group_id as varchar(200)) as group_id
, gp.booking_status
, gp.group_code
, gp.group_name
, CAST(r.vip_status_id as varchar(200)) as vip_status_id
, vs.code v_code
, vs.name v_name
, r.non_registered_guest
, r.walk_in
, CAST(r.cancellation_policy_id as varchar(200)) as cancellation_policy_id
, cp.code cp_code
, cp.description cp_description
, CAST(r.deposit_policy_id as varchar(200)) as deposit_policy_id
, dp.policy_type
, dp.code dp_code
, dp.name dp_name
, CAST(r.booked_by as varchar(200)) as booked_by
, CAST(r.cancellation_reason as varchar(200)) as cancellation_reason
, CAST(r.cancelled_by as varchar(200)) as cancelled_by
, CAST(array_to_string(r.agent_ids, '' , ''''*'') as varchar(100)) as agent_ids
, r.do_not_move_room
, CAST(r.cancellation_policy_overridden_by as varchar(200)) as cancellation_policy_overridden_by
, r.cancellation_policy_overridden_amount
, r.cancellation_policy_overridden_percentage
, CAST(r.overridden_cancellation_policy_id as varchar(200)) as overridden_cancellation_policy_id
, r.estimated_time_of_arrival
, r.estimated_time_of_departure
, CAST(r.booker_id as varchar(200)) as booker_id
, r.cancellation_time_utc
, r.web_check_in
, r.suppress_rate
, r.no_of_documents
, CAST(r.share_id as varchar(200)) as share_id
, r.no_of_pets
, r.web_check_out
, r.room_ready_sms_enabled
, r.web_check_in_sms_enabled
, r.web_check_out_sms_enabled
, CAST(array_to_string(r.room_feature_preference_names, '' , ''''*'') as varchar(100)) as room_feature_preference_names
, r.number_of_guests
, CAST(array_to_string(r.guest_preference_ids, '' , ''''*'') as varchar(100)) as guest_preference_ids
, CAST(r.housekeeping_pattern_id as varchar(200)) as housekeeping_pattern_id
, r.deposit_policy_amount
, r.deposit_policy_tax
, r.number_of_age_category1
, r.number_of_age_category2
, r.deposit_total_due
, CAST(r.source_interface_id as varchar(200)) as source_interface_id
, CAST(r.old_pms_confirmation_code as varchar(200)) as old_pms_confirmation_code
, r.checkin_at
, CAST(r.checkin_by as varchar(200)) as checkin_by
, r.checkout_at
, CAST(r.checkout_by as varchar(200)) as checkout_by
, CAST(r.do_not_move_reason_description as varchar(200)) as do_not_move_reason_description
, r.do_not_move_reason_date_time
, CAST(r.do_not_move_reason_updated_by as varchar(200)) as do_not_move_reason_updated_by
, CAST(r.do_not_move_reason_id as varchar(200)) as do_not_move_reason_id
, r._export_ts
, r.comp_overridden
, CAST(r.comp_overridden_user as varchar(200)) as comp_overridden_user
, r._export_create_ts
, r._export_update_ts
, r.moved_status

, CAST(li.id AS VARCHAR(200)) li_id
, li.account_id as li_account_id
, ac.name ac_name
, ac.account_type
, CAST(cod.id AS VARCHAR(200)) cod_id
, cod.offer_date
, cod.offer_type
, co.offer_code
, co.offer_name
, cod.resolution
, cod.offer_status
, li.amount 
, li.category_id 
, cg.name cg_name
, cg.code cg_code
, li.display_date 
, li.folio_id 
, f.name f_name
, li.accounting_item_id 
, ai.type ai_type
, ai.general_ledger_code
, ai.name ai_name
, ai.code ai_code
, li.ledger_id 
, li.quantity 
, li.room_revenue 
, li.subcategory_id 
, sc.name sc_name
, sc.code sc_code
, li.user_id 
, li.ledger_lines_ledger_transaction_id 
, lt.destination_ledger_id
, lt.type lt_type
, li.folio_lines_ledger_transaction_id 
, li.tax_reference_id 
, li.adjustment_reference_id 
, li.call_type 
, li.correction_reference_id 
, li.description 
, li.free_allowance_amount 
, li.gateway_type 
, li.gift_card 
, li.invalid 
, li.meal_period_id 
, li.rate_change_comment 
, li.reason 
, li.recurring_charge_id 
, li.reference 
, li.refund_reference_id 
, li.reservation_id 
, li.reverse_tax_total_charge_amount 
, li.reverse_tax 
, li.room_charge_posting_type 
, li.source_id 
, li.transfer_reference_id 
, li.pantry_item 
, li.comp_id 
, cm.reason cm_reason
, cm.discount_type cm_discount_type
, li.check_number 
, li.exclude_tax 
, li.reference_number 
, li.comp_reference_id 
, li.room_id 
, rm.rack_number
, rm.room_number
, rt.name rt_name
, rt.type_code rt_type_code
, rt.is_ada
, rt.max_guests
, rt.smoking_allowed
, li.routed 
, li.source_folio_line_item_id 
, li.payment_method_id 
, li.posting_rule_id 
, li.issuer 
, li.last_four_digits 
, li.payment_interface_id 
, li.revised_adjustment_amount 
, li.is_manage_dispute_adjustment 
, li.corrected_or_adjusted_amount 
, li.deposit_payment_at_booking 
, li.auth_code 

FROM public.reservations r
LEFT JOIN stay_prod.public.allocations al ON r.allocation_id=al.id
LEFT JOIN stay_prod.public.vip_statuses vs ON r.vip_status_id=vs.id
LEFT JOIN stay_prod.public.guests g ON r.primary_guest_id=g.id
LEFT JOIN stay_prod.public.guest_types gt ON r.guest_type_id=gt.id
LEFT JOIN stay_prod.public.market_segments ms ON r.market_segment_id=ms.id
LEFT JOIN stay_prod.public.source_of_businesses sb ON r.source_of_business_id=sb.id
LEFT JOIN stay_prod.public.groups gp ON r.group_id=gp.id
LEFT JOIN stay_prod.public.cancellation_policies cp ON r.cancellation_policy_id=cp.id
LEFT JOIN stay_prod.public.deposit_policies dp ON r.deposit_policy_id=dp.id

LEFT JOIN stay_prod.public.comp_offer_details cod ON r.id=cod.reservation_id
LEFT JOIN stay_prod.public.comp_offers co ON cod.offer_id=co.id
LEFT JOIN stay_prod.public.line_items li ON r.id=li.reservation_id
LEFT JOIN stay_prod.public.accounts ac ON li.account_id=ac.id
LEFT JOIN stay_prod.public.categories cg ON li.category_id=cg.id
LEFT JOIN stay_prod.public.folios f ON li.folio_id=f.id
LEFT JOIN stay_prod.public.accounting_items ai ON li.accounting_item_id=ai.id
LEFT JOIN stay_prod.public.subcategories sc ON li.subcategory_id=sc.id
LEFT JOIN stay_prod.public.ledger_transactions lt ON li.ledger_lines_ledger_transaction_id=lt.id
LEFT JOIN stay_prod.public.comps cm ON li.comp_id=cm.id
LEFT JOIN stay_prod.public.rooms rm ON li.room_id=rm.id
LEFT JOIN stay_prod.public.room_types rt ON rm.room_type_id=rt.id

WHERE r.arrival_date > ''2024-03-17''
')
GO

DROP VIEW IF EXISTS [dbo].[vw_Reservations_VIE] ;
GO

CREATE VIEW [dbo].[vw_Reservations_VIE] AS
SELECT 
  r.id
, r.account_id
, r.allocation_id
, al.allocation_type
, al.inventory_block_type
, al.[start_date] as al_start_dt
, al.end_date as al_end_dt
, al.reason as al_reason
, r.confirmation_code
, r.arrival_date
, r.departure_date
, r.cancellation_date
, r.create_time
, r.early_arrival
, r.early_check_in_time
, r.late_checkout_time
, r.number_of_adults
, r.number_of_children
, r.primary_guest_first_name
, r.primary_guest_last_name
, r.player_id
, r.primary_guest_id
, g.code
, g.cms_type
, r.property_id
, r.reservation_alias
, r.[status]
, r.tenant_id
, r.guest_type_id
, gt.[name] as gt_name
, gt.code as gt_code
, r.market_segment_id
, ms.[name] as ms_name
, ms.code as ms_code
, r.source_of_business_id
, sb.[name] as sb_name
, sb.code as sb_code
, r.update_time
, r.company_id
, r.group_id
, gp.booking_status
, gp.group_code
, gp.group_name
, r.vip_status_id
, vs.code as v_code
, vs.[name] as v_name
, r.non_registered_guest
, r.walk_in
, r.cancellation_policy_id
, cp.code as cp_code
, cp.[description] as cp_description
, r.deposit_policy_id
, dp.policy_type
, dp.code as dp_code
, dp.[name] as dp_name
, r.booked_by
, r.cancellation_reason
, r.cancelled_by
, r.agent_ids
, r.do_not_move_room
, r.cancellation_policy_overridden_by
, r.cancellation_policy_overridden_amount
, r.cancellation_policy_overridden_percentage
, r.overridden_cancellation_policy_id
, r.estimated_time_of_arrival
, r.estimated_time_of_departure
, r.booker_id
, r.cancellation_time_utc
, r.web_check_in
, r.suppress_rate
, r.no_of_documents
, r.share_id
, r.no_of_pets
, r.web_check_out
, r.room_ready_sms_enabled
, r.web_check_in_sms_enabled
, r.web_check_out_sms_enabled
, r.room_feature_preference_names
, r.number_of_guests
, r.guest_preference_ids
, r.housekeeping_pattern_id
, r.deposit_policy_amount
, r.deposit_policy_tax
, r.number_of_age_category1
, r.number_of_age_category2
, r.deposit_total_due
, r.source_interface_id
, r.old_pms_confirmation_code
, r.checkin_at
, r.checkin_by
, r.checkout_at
, r.checkout_by
, r.do_not_move_reason_description
, r.do_not_move_reason_date_time
, r.do_not_move_reason_updated_by
, r.do_not_move_reason_id
, r._export_ts
, r.comp_overridden
, r.comp_overridden_user
, r._export_create_ts
, r._export_update_ts
, r.moved_status

, li.id as li_id
, li.account_id as li_account_id
, ac.[name] as ac_name
, ac.account_type
, cod.id as cod_id
, cod.offer_date
, cod.offer_type
, co.offer_code
, co.offer_name
, cod.resolution
, cod.offer_status
, li.amount 
, li.category_id 
, cg.[name] as cg_name
, cg.code as cg_code
, li.display_date 
, li.folio_id 
, f.[name] as f_name
, li.accounting_item_id 
, ai.[type] as ai_type
, ai.general_ledger_code
, ai.[name] as ai_name
, ai.code as ai_code
, li.ledger_id 
, li.quantity 
, li.room_revenue 
, li.subcategory_id 
, sc.[name] as sc_name
, sc.code as sc_code
, li.[user_id] 
, li.ledger_lines_ledger_transaction_id 
, lt.destination_ledger_id
, lt.[type] as lt_type
, li.folio_lines_ledger_transaction_id 
, li.tax_reference_id 
, li.adjustment_reference_id 
, li.call_type 
, li.correction_reference_id 
, li.[description] 
, li.free_allowance_amount 
, li.gateway_type 
, li.gift_card 
, li.invalid 
, li.meal_period_id 
, li.rate_change_comment 
, li.reason 
, li.recurring_charge_id 
, li.reference 
, li.refund_reference_id 
, li.reservation_id 
, li.reverse_tax_total_charge_amount 
, li.reverse_tax 
, li.room_charge_posting_type 
, li.source_id 
, li.transfer_reference_id 
, li.pantry_item 
, li.comp_id 
, cm.reason cm_reason
, cm.discount_type cm_discount_type
, li.check_number 
, li.exclude_tax 
, li.reference_number 
, li.comp_reference_id 
, li.room_id 
, rm.rack_number
, rm.room_number
, rt.[name] as rt_name
, rt.type_code as rt_type_code
, rt.is_ada
, rt.max_guests
, rt.smoking_allowed
, li.routed 
, li.source_folio_line_item_id 
, li.payment_method_id 
, li.posting_rule_id 
, li.issuer 
, li.last_four_digits 
, li.payment_interface_id 
, li.revised_adjustment_amount 
, li.is_manage_dispute_adjustment 
, li.corrected_or_adjusted_amount 
, li.deposit_payment_at_booking 
, li.auth_code 

FROM dbo.reservations r
LEFT JOIN dbo.allocations al ON r.allocation_id=al.id
LEFT JOIN dbo.vip_statuses vs ON r.vip_status_id=vs.id
LEFT JOIN dbo.guests g ON r.primary_guest_id=g.id
LEFT JOIN dbo.guest_types gt ON r.guest_type_id=gt.id
LEFT JOIN dbo.market_segments ms ON r.market_segment_id=ms.id
LEFT JOIN dbo.source_of_businesses sb ON r.source_of_business_id=sb.id
LEFT JOIN dbo.groups gp ON r.group_id=gp.id
LEFT JOIN dbo.cancellation_policies cp ON r.cancellation_policy_id=cp.id
LEFT JOIN dbo.deposit_policies dp ON r.deposit_policy_id=dp.id

LEFT JOIN dbo.comp_offer_details cod ON r.id=cod.reservation_id
LEFT JOIN dbo.comp_offers co ON cod.offer_id=co.id
LEFT JOIN dbo.line_items li ON r.id=li.reservation_id
LEFT JOIN dbo.accounts ac ON li.account_id=ac.id
LEFT JOIN dbo.categories cg ON li.category_id=cg.id
LEFT JOIN dbo.folios f ON li.folio_id=f.id
LEFT JOIN dbo.accounting_items ai ON li.accounting_item_id=ai.id
LEFT JOIN dbo.subcategories sc ON li.subcategory_id=sc.id
LEFT JOIN dbo.ledger_transactions lt ON li.ledger_lines_ledger_transaction_id=lt.id
LEFT JOIN dbo.comps cm ON li.comp_id=cm.id
LEFT JOIN dbo.rooms rm ON li.room_id=rm.id
LEFT JOIN dbo.room_types rt ON rm.room_type_id=rt.id

WHERE r.arrival_date > '2024-03-17'
GO