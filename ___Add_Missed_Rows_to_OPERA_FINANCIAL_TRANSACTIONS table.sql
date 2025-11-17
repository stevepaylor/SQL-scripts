USE [iQ-Gaming]
GO

-------------------------------------------------------------------------------------------------------------------------
-- Step 1
-- Get new rows since last load from the table in Oracle and insert it into a local staging table accepting the default 
-- datatype conversions (in order to keep the size of the SELECT statement small).  In the next step the datetype will be 
-- CAST to the datatype of the permanent table for each row.
----------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Opera_5_0.FINANCIAL_TRANSACTIONS_stage_2023 ;

DECLARE @startDate char(19) = '2023-01-01 00:00:00' ;
DECLARE @endDate char(19) = '2023-12-31 23:59:59' ;

PRINT '@startDate = ' + @startDate ;
PRINT '@endDate = ' + @endDate ;

SELECT * 
INTO Opera_5_0.FINANCIAL_TRANSACTIONS_stage_2023 
FROM OPERA..OPERA.FINANCIAL_TRANSACTIONS_VIEW 
WHERE INSERT_DATE BETWEEN @startDate AND @endDate
ORDER BY TRX_NO ;

---------------------------------------------------------------------------------------------------------------------------
-- Step 2
-- Add Primary Key on TRX_NO
----------------------------------------------------------------------------------------------------------------------------

SET ANSI_PADDING ON
GO

ALTER TABLE [Opera_5_0].[FINANCIAL_TRANSACTIONS_stage_2023] ADD  CONSTRAINT [PK_FINANCIAL_TRANSACTIONS_stage_2023] PRIMARY KEY CLUSTERED 
(
	[TRX_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

---------------------------------------------------------------------------------------------------------------------------
-- Step 3
-- Load the staging table (DELTA) into the permanent table by LEFT JOINing it to the permanent table and selectiong only
-- the rows that don't exist already in the permanent table.  This causes primary key violation error if a row was selected 
-- in Step 1. 
----------------------------------------------------------------------------------------------------------------------------

MERGE Opera_5_0.FINANCIAL_TRANSACTIONS AS tgt
USING Opera_5_0.FINANCIAL_TRANSACTIONS_stage_2023 AS stg
ON tgt.TRX_NO = stg.TRX_NO

WHEN NOT MATCHED 
AND stg.RESV_NAME_ID IS NOT NULL
THEN INSERT 
( 
  TRX_NO
, TRX_DATE
, TRX_CODE
, RESV_NAME_ID
, RESORT
, DEP_LED_DEBIT
, DEP_LED_CREDIT
, GUEST_ACCOUNT_DEBIT
, GUEST_ACCOUNT_CREDIT
, PACKAGE_DEBIT
, PACKAGE_CREDIT
, AR_LED_DEBIT
, INTERNAL_DB_PAYMENTS
, AR_LED_CREDIT
, REVENUE_AMT
, TRX_AMOUNT
, NET_AMOUNT
, GROSS_AMOUNT
, NON_REVENUE_AMOUNT
, INH_CREDIT
, INH_DEBIT
, CASHIER_DEBIT
, CASHIER_CREDIT
, POSTED_AMOUNT
, PRICE_PER_UNIT
, QUANTITY
, EXCHANGE_RATE
, EURO_EXCHANGE_RATE
, MARKET_CODE
, SOURCE_CODE
, ROOM_CLASS
, INVOICE_TYPE
, TAX_INCLUSIVE_YN
, RECPT_NO
, RECPT_TYPE
, CHEQUE_NUMBER
, AR_TRANSFER_DATE
, FT_SUBTYPE
, TC_GROUP
, TC_SUBGROUP
, TRX_NO_ADDED_BY
, TRX_NO_AGAINST_PACKAGE
, AR_NUMBER
, BUSINESS_DATE
, ROOM
, CASHIER_ID
, FOLIO_VIEW
, REMARK
, REFERENCE
, CREDIT_CARD_ID
, NAME_ID
, RATE_CODE
, TRAN_ACTION_ID
, ROUTING_INSTRN_ID
, FROM_RESV_ID
, PRODUCT
, AR_STATE
, FOLIO_NO
, INVOICE_NO
, TRNS_ACTIVITY_DATE
, TRNS_FROM_ACCT
, TRNS_TO_ACCT
, BILL_NO
, REVISION_NO
, TARGET_RESORT
, FOLIO_TYPE
, COMPRESSED_YN
, ARRANGEMENT_ID
, ARRANGEMENT_CODE
, ARRANGEMENT_TYPE
, TRANSACTION_DESCRIPTION
, IND_ADJUSTMENT_YN
, REASON_CODE
, UPDATE_USER
, UPDATE_DATE
, INSERT_USER
, INSERT_DATE
, DEFERRED_YN
, TAX_GENERATED_YN
, TA_COMMISSIONABLE_YN
, FIXED_CHARGES_YN
, TAX_ELEMENTS
, INVOICE_CLOSE_DATE
, PASSERBY_NAME
, ROOM_TYPE
, CASHIER_NAME
, CC_CODE
, TC_TRANSACTION_TYPE
, TRX_CODE_TYPE
, TRX_TYPE
, TRX_TYPE_DESCRIPTION
, TRX_TYPE_SORT
, TB_AMOUNT_NET
, TB_AMOUNT_GROSS
, IS_DEBIT_01
, IS_CREDIT_01
, IS_INTERNAL_YN
, AUTHORIZER_ID
, APPROVAL_CODE
, APPROVAL_DATE
, APPROVAL_STATUS
, APPROVAL_STATUS_DESC
, APP_USER
, DISPLAY_YN
, LINK_TRX_NO
, SUMM_REF_CODE
, ACTUAL_POSTING_DATE_TIME
, FOREX_TYPE
, FOREX_COMM_PERC
, FOREX_COMM_AMOUNT
, ACTUAL_EXCHANGE_RATE
, ARTICLE_ID
, ARTICLE_CODE
, COMP_YN
, FIN_DML_SEQ_NO
, CC_TYPE
, COMP_LINK_TRX_NO
, COMP_LINK_TRX_CODE
, ACC_TYPE_FLAG
, FISCAL_BILL_NO
, PACKAGE_ALLOWANCE
, ORG_AR_LED_DEBIT
, SETTLEMENT_FLAG
, POSTING_DATE
, TRX_CODE_ADDED_BY
, ADV_GENERATE_ADJUSTMENT
, ADV_GENERATE_TRX_CODE
, MEMBERSHIP_ID
, PARALLEL_GUEST_CREDIT
, PARALLEL_GUEST_DEBIT
, PARALLEL_CURRENCY
, EXCHANGE_DIFFERENCE_YN
, INSTALLMENTS
, NUMBER_DIALED
, COVERS
, TZ_INSERT_DATE
, ASB_FLAG
, PROFIT_LOSS_FLAG
, IS_INTERNAL_PKG_TAX_YN
, IS_EXCL_PROFIT_LOSS_YN
, POSTIT_YN
, POSTIT_NO
, CHANGE_DUE
, AUTO_SETTLE_YN
, POSTING_TYPE
, IND_CASH
, DEP_TAX_TRANSFERED_YN
, ORIGINAL_RESV_NAME_ID
, DEFERRED_TAXES_YN
, POSTING_RHYTHM
, AUTO_CREDITBILL_YN
, BONUS_CHECK_ID
, FBA_CERTIFICATE_NUMBER
, OWNER_LED_DEBIT
, OWNER_LED_CREDIT
, ASB_TAX_FLAG
, ASB_ONLY_POST_TAXES_ONCE_YN
, CLOSURE_NO
, DEP_POSTING_FLAG
, PACKAGE_ARRANGEMENT_CODE
, CORRECTION_YN
, ROUTED_YN
, REVERSE_PAYMENT_TRX_NO
, ADVANCE_BILL_YN
, ADVANCE_BILL_REVERSED_YN
, GP_AWARD_CODE
, GP_AWARD_CANCEL_CODE
, ORG_POSTED_AMOUNT
, INC_TAX_DEDUCTED_YN
, DEP_NET_AMOUNT
, DEP_GROSS_AMOUNT
, INTERNAL_YN
, DEP_NET_TAX_AMT
, CC_REFUND_POSTING
, ELECTRONIC_VOUCHER_NO
, NAME_TAX_TYPE
, TRX_NO_ADJUST
, ROOM_NTS_EFFECTIVE
, THRESHOLD_DIVERSION_ID
, THRESHOLD_ENTITY_TYPE
, THRESHOLD_ENTITY_QTY
, THRESHOLD_TREATMENT_FLAG
, TRX_CODE_TYPE_ADDED_BY
, IS_ROOM_01
, IS_FOOD_01
, IS_OTHER_01
, IS_REVENUE_01
, IS_NON_REVENUE_01
, IS_PACKAGE_01
, IS_TAX_01
, IS_ROOM_GENERATE_01
, IS_FOOD_GENERATE_01
, IS_OTHER_GENERATE_01
, IS_NON_REVENUE_GENERATE_01
, ROOM_REVENUE
, FOOD_REVENUE
, OTHER_REVENUE
, TOTAL_REVENUE
, NON_REVENUE
, ROOM_REVENUE_TAX
, FOOD_REVENUE_TAX
, OTHER_REVENUE_TAX
, TOTAL_REVENUE_TAX
, NON_REVENUE_TAX
, PROPERTY_BILL_PREFIX
, DEPOSIT_TRANSACTION_ID
, ASSOCIATED_TRX_NO
, TRX_SERVICE_TYPE
, ACCOUNTING_CODE
, QUANTITY_CODE
)
VALUES
(
   CAST(stg.TRX_NO as int)
,  CAST(stg.TRX_DATE as datetime2(7))
,  CAST(stg.TRX_CODE as varchar(20))
,  CAST(CAST(stg.RESV_NAME_ID as decimal(18,0)) as varchar(10))
,  CAST(stg.RESORT as varchar(20))
,  CAST(stg.DEP_LED_DEBIT as numeric(38,12))
,  CAST(stg.DEP_LED_CREDIT as numeric(38,12))
,  CAST(stg.GUEST_ACCOUNT_DEBIT as numeric(38,12))
,  CAST(stg.GUEST_ACCOUNT_CREDIT as numeric(38,12))
,  CAST(stg.PACKAGE_DEBIT as numeric(38,12))
,  CAST(stg.PACKAGE_CREDIT as numeric(38,12))
,  CAST(stg.AR_LED_DEBIT as numeric(38,12))
,  CAST(stg.INTERNAL_DB_PAYMENTS as numeric(38,12))
,  CAST(stg.AR_LED_CREDIT as numeric(38,12))
,  CAST(stg.REVENUE_AMT as numeric(38,12))
,  CAST(stg.TRX_AMOUNT as numeric(38,12))
,  CAST(stg.NET_AMOUNT as numeric(38,12))
,  CAST(stg.GROSS_AMOUNT as numeric(38,12))
,  CAST(stg.NON_REVENUE_AMOUNT as numeric(38,12))
,  CAST(stg.INH_CREDIT as numeric(38,12))
,  CAST(stg.INH_DEBIT as numeric(38,12))
,  CAST(stg.CASHIER_DEBIT as numeric(38,12))
,  CAST(stg.CASHIER_CREDIT as numeric(38,12))
,  CAST(stg.POSTED_AMOUNT as numeric(38,12))
,  CAST(stg.PRICE_PER_UNIT as numeric(38,12))
,  CAST(stg.QUANTITY as numeric(12,0))
,  CAST(stg.EXCHANGE_RATE as numeric(38,12))
,  CAST(stg.EURO_EXCHANGE_RATE as numeric(38,12))
,  CAST(stg.MARKET_CODE as varchar(20))
,  CAST(stg.SOURCE_CODE as varchar(20))
,  CAST(stg.ROOM_CLASS as varchar(20))
,  CAST(stg.INVOICE_TYPE as char(2))
,  CAST(stg.TAX_INCLUSIVE_YN as char(1))
,  CAST(stg.RECPT_NO as numeric(38,12))
,  CAST(stg.RECPT_TYPE as varchar(20))
,  CAST(stg.CHEQUE_NUMBER as varchar(200))
,  CAST(stg.AR_TRANSFER_DATE as datetime2(7))
,  CAST(stg.FT_SUBTYPE as char(5))
,  CAST(stg.TC_GROUP as varchar(20))
,  CAST(stg.TC_SUBGROUP as varchar(20))
,  CAST(stg.TRX_NO_ADDED_BY as numeric(38,12))
,  CAST(stg.TRX_NO_AGAINST_PACKAGE as numeric(38,12))
,  CAST(stg.AR_NUMBER as numeric(38,12))
,  CAST(stg.BUSINESS_DATE as datetime2(7))
,  CAST(stg.ROOM as varchar(20))
,  CAST(stg.CASHIER_ID as numeric(38,12))
,  CAST(stg.FOLIO_VIEW as numeric(9,0))
,  CAST(stg.REMARK as varchar(2000))
,  CAST(stg.REFERENCE as varchar(2000))
,  CAST(stg.CREDIT_CARD_ID as numeric(38,12))
,  CAST(stg.NAME_ID as numeric(38,12))
,  CAST(stg.RATE_CODE as varchar(20))
,  CAST(stg.TRAN_ACTION_ID as numeric(38,12))
,  CAST(stg.ROUTING_INSTRN_ID as numeric(38,12))
,  CAST(stg.FROM_RESV_ID as numeric(38,12))
,  CAST(stg.PRODUCT as varchar(20))
,  CAST(stg.AR_STATE as char(2))
,  CAST(stg.FOLIO_NO as numeric(38,12))
,  CAST(stg.INVOICE_NO as numeric(38,12))
,  CAST(stg.TRNS_ACTIVITY_DATE as datetime2(7))
,  CAST(stg.TRNS_FROM_ACCT as numeric(38,12))
,  CAST(stg.TRNS_TO_ACCT as numeric(38,12))
,  CAST(stg.BILL_NO as numeric(38,12))
,  CAST(stg.REVISION_NO as numeric(38,12))
,  CAST(stg.TARGET_RESORT as varchar(20))
,  CAST(stg.FOLIO_TYPE as varchar(100))
,  CAST(stg.COMPRESSED_YN as char(1))
,  CAST(stg.ARRANGEMENT_ID as numeric(38,12))
,  CAST(stg.ARRANGEMENT_CODE as varchar(20))
,  CAST(stg.ARRANGEMENT_TYPE as varchar(20))
,  CAST(stg.TRANSACTION_DESCRIPTION as varchar(2000))
,  CAST(stg.IND_ADJUSTMENT_YN as char(1))
,  CAST(stg.REASON_CODE as varchar(20))
,  CAST(stg.UPDATE_USER as numeric(38,12))
,  CAST(stg.UPDATE_DATE as datetime2(7))
,  CAST(stg.INSERT_USER as numeric(38,12))
,  CAST(stg.INSERT_DATE as datetime2(7))
,  CAST(stg.DEFERRED_YN as char(1))
,  CAST(stg.TAX_GENERATED_YN as char(1))
,  CAST(stg.TA_COMMISSIONABLE_YN as char(1))
,  CAST(stg.FIXED_CHARGES_YN as char(1))
,  CAST(stg.TAX_ELEMENTS as varchar(300))
,  CAST(stg.INVOICE_CLOSE_DATE as datetime2(7))
,  CAST(stg.PASSERBY_NAME as varchar(2000))
,  CAST(stg.ROOM_TYPE as varchar(2000))
,  CAST(stg.CASHIER_NAME as varchar(2000))
,  CAST(stg.CC_CODE as varchar(20))
,  CAST(stg.TC_TRANSACTION_TYPE as char(5))
,  CAST(stg.TRX_CODE_TYPE as char(2))
,  CAST(stg.TRX_TYPE as varchar(11))
,  CAST(stg.TRX_TYPE_DESCRIPTION as varchar(2000))
,  CAST(stg.TRX_TYPE_SORT as numeric(38,12))
,  CAST(stg.TB_AMOUNT_NET as numeric(38,12))
,  CAST(stg.TB_AMOUNT_GROSS as numeric(38,12))
,  CAST(stg.IS_DEBIT_01 as numeric(38,12))
,  CAST(stg.IS_CREDIT_01 as numeric(38,12))
,  CAST(stg.IS_INTERNAL_YN as char(1))
,  CAST(stg.AUTHORIZER_ID as numeric(38,12))
,  CAST(stg.APPROVAL_CODE as varchar(20))
,  CAST(stg.APPROVAL_DATE as datetime2(7))
,  CAST(stg.APPROVAL_STATUS as varchar(20))
,  CAST(stg.APPROVAL_STATUS_DESC as varchar(2000))
,  CAST(stg.APP_USER as varchar(40))
,  CAST(stg.DISPLAY_YN as char(1))
,  CAST(stg.LINK_TRX_NO as numeric(38,12))
,  CAST(stg.SUMM_REF_CODE as varchar(2000))
,  CAST(stg.ACTUAL_POSTING_DATE_TIME as varchar(75))
,  CAST(stg.FOREX_TYPE as char(1))
,  CAST(stg.FOREX_COMM_PERC as numeric(38,12))
,  CAST(stg.FOREX_COMM_AMOUNT as numeric(38,12))
,  CAST(stg.ACTUAL_EXCHANGE_RATE as numeric(38,12))
,  CAST(stg.ARTICLE_ID as numeric(38,12))
,  CAST(stg.ARTICLE_CODE as varchar(2000))
,  CAST(stg.COMP_YN as char(1))
,  CAST(stg.FIN_DML_SEQ_NO as numeric(38,12))
,  CAST(stg.CC_TYPE as char(2))
,  CAST(stg.COMP_LINK_TRX_NO as numeric(38,12))
,  CAST(stg.COMP_LINK_TRX_CODE as varchar(20))
,  CAST(stg.ACC_TYPE_FLAG as char(1))
,  CAST(stg.FISCAL_BILL_NO as varchar(40))
,  CAST(stg.PACKAGE_ALLOWANCE as numeric(38,12))
,  CAST(stg.ORG_AR_LED_DEBIT as numeric(38,12))
,  CAST(stg.SETTLEMENT_FLAG as char(1))
,  CAST(stg.POSTING_DATE as datetime2(7))
,  CAST(stg.TRX_CODE_ADDED_BY as varchar(20))
,  CAST(stg.ADV_GENERATE_ADJUSTMENT as varchar(10))
,  CAST(stg.ADV_GENERATE_TRX_CODE as varchar(20))
,  CAST(stg.MEMBERSHIP_ID as numeric(38,12))
,  CAST(stg.PARALLEL_GUEST_CREDIT as numeric(38,12))
,  CAST(stg.PARALLEL_GUEST_DEBIT as numeric(38,12))
,  CAST(stg.PARALLEL_CURRENCY as varchar(20))
,  CAST(stg.EXCHANGE_DIFFERENCE_YN as char(1))
,  CAST(stg.INSTALLMENTS as numeric(38,12))
,  CAST(stg.NUMBER_DIALED as varchar(40))
,  CAST(stg.COVERS as varchar(10))
,  CAST(stg.TZ_INSERT_DATE as datetime2(7))
,  CAST(stg.ASB_FLAG as char(1))
,  CAST(stg.PROFIT_LOSS_FLAG as char(1))
,  CAST(stg.IS_INTERNAL_PKG_TAX_YN as varchar(2000))
,  CAST(stg.IS_EXCL_PROFIT_LOSS_YN as char(1))
,  CAST(stg.POSTIT_YN as char(1))
,  CAST(stg.POSTIT_NO as numeric(38,12))
,  CAST(stg.CHANGE_DUE as numeric(38,12))
,  CAST(stg.AUTO_SETTLE_YN as char(1))
,  CAST(stg.POSTING_TYPE as varchar(20))
,  CAST(stg.IND_CASH as char(1))
,  CAST(stg.DEP_TAX_TRANSFERED_YN as char(1))
,  CAST(stg.ORIGINAL_RESV_NAME_ID as numeric(38,12))
,  CAST(stg.DEFERRED_TAXES_YN as char(1))
,  CAST(stg.POSTING_RHYTHM as varchar(20))
,  CAST(stg.AUTO_CREDITBILL_YN as char(1))
,  CAST(stg.BONUS_CHECK_ID as numeric(38,12))
,  CAST(stg.FBA_CERTIFICATE_NUMBER as varchar(20))
,  CAST(stg.OWNER_LED_DEBIT as numeric(38,12))
,  CAST(stg.OWNER_LED_CREDIT as numeric(38,12))
,  CAST(stg.ASB_TAX_FLAG as varchar(20))
,  CAST(stg.ASB_ONLY_POST_TAXES_ONCE_YN as char(1))
,  CAST(stg.CLOSURE_NO as numeric(38,12))
,  CAST(stg.DEP_POSTING_FLAG as char(1))
,  CAST(stg.PACKAGE_ARRANGEMENT_CODE as varchar(20))
,  CAST(stg.CORRECTION_YN as char(1))
,  CAST(stg.ROUTED_YN as char(1))
,  CAST(stg.REVERSE_PAYMENT_TRX_NO as numeric(38,12))
,  CAST(stg.ADVANCE_BILL_YN as char(1))
,  CAST(stg.ADVANCE_BILL_REVERSED_YN as char(1))
,  CAST(stg.GP_AWARD_CODE as varchar(20))
,  CAST(stg.GP_AWARD_CANCEL_CODE as varchar(20))
,  CAST(stg.ORG_POSTED_AMOUNT as numeric(38,12))
,  CAST(stg.INC_TAX_DEDUCTED_YN as char(1))
,  CAST(stg.DEP_NET_AMOUNT as numeric(38,12))
,  CAST(stg.DEP_GROSS_AMOUNT as numeric(38,12))
,  CAST(stg.INTERNAL_YN as char(1))
,  CAST(stg.DEP_NET_TAX_AMT as numeric(38,12))
,  CAST(stg.CC_REFUND_POSTING as varchar(30))
,  CAST(stg.ELECTRONIC_VOUCHER_NO as numeric(38,12))
,  CAST(stg.NAME_TAX_TYPE as varchar(20))
,  CAST(stg.TRX_NO_ADJUST as numeric(38,12))
,  CAST(stg.ROOM_NTS_EFFECTIVE as numeric(38,12))
,  CAST(stg.THRESHOLD_DIVERSION_ID as numeric(38,12))
,  CAST(stg.THRESHOLD_ENTITY_TYPE as varchar(30))
,  CAST(stg.THRESHOLD_ENTITY_QTY as numeric(38,12))
,  CAST(stg.THRESHOLD_TREATMENT_FLAG as varchar(30))
,  CAST(stg.TRX_CODE_TYPE_ADDED_BY as char(2))
,  CAST(stg.IS_ROOM_01 as numeric(38,12))
,  CAST(stg.IS_FOOD_01 as numeric(38,12))
,  CAST(stg.IS_OTHER_01 as numeric(38,12))
,  CAST(stg.IS_REVENUE_01 as numeric(38,12))
,  CAST(stg.IS_NON_REVENUE_01 as numeric(38,12))
,  CAST(stg.IS_PACKAGE_01 as numeric(38,12))
,  CAST(stg.IS_TAX_01 as numeric(38,12))
,  CAST(stg.IS_ROOM_GENERATE_01 as numeric(38,12))
,  CAST(stg.IS_FOOD_GENERATE_01 as numeric(38,12))
,  CAST(stg.IS_OTHER_GENERATE_01 as numeric(38,12))
,  CAST(stg.IS_NON_REVENUE_GENERATE_01 as numeric(38,12))
,  CAST(stg.ROOM_REVENUE as numeric(38,12))
,  CAST(stg.FOOD_REVENUE as numeric(38,12))
,  CAST(stg.OTHER_REVENUE as numeric(38,12))
,  CAST(stg.TOTAL_REVENUE as numeric(38,12))
,  CAST(stg.NON_REVENUE as numeric(38,12))
,  CAST(stg.ROOM_REVENUE_TAX as numeric(38,12))
,  CAST(stg.FOOD_REVENUE_TAX as numeric(38,12))
,  CAST(stg.OTHER_REVENUE_TAX as numeric(38,12))
,  CAST(stg.TOTAL_REVENUE_TAX as numeric(38,12))
,  CAST(stg.NON_REVENUE_TAX as numeric(38,12))
,  CAST(stg.PROPERTY_BILL_PREFIX as varchar(30))
,  CAST(stg.DEPOSIT_TRANSACTION_ID as varchar(40))
,  CAST(stg.ASSOCIATED_TRX_NO as numeric(38,12))
,  CAST(stg.TRX_SERVICE_TYPE as varchar(20))
,  CAST(stg.ACCOUNTING_CODE as varchar(40))
,  CAST(stg.QUANTITY_CODE as varchar(40))
) ;