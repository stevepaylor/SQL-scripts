SELECT
cdd.extra_text,
CASE WHEN LEN(cdd.extra_text)> 8 THEN
Replace(STUFF(cdd.extra_text, CHARINDEX('209', cdd.extra_text), LEN('209'), ''),'''','')
ELSE cdd.extra_text
END AS Acct,
---left(csd.transaction_data_tag,8) as Acct,
csd.transaction_data_id,
profit_center_id,
profit_center_name,
check_number,
void_state,
sales_gross_amount as Sales_Gross_Amount_Total,
num_covers,
csd.discount_amount as discount_amount_Total,
dd.discount_name as discount_name,
tax_amount as tax_amount_Total,
csd.tender_amount as tender_amount_Total,
gratuity_amount as gratuity_amount_Total,
csd.tip_amount as tip_amount_Total,
ctd.tender_amount as tender_amount_byTender,
ctd.change_amount as change_amount_byTender,
ctd.received_amount as received_amount_byTender,
ctd.breakage_amount as breakege_amount_byTender,
ctd.tip_amount as tip_amount_byTender,
ctd.additional_tender_data,
tender_sequence_Id as Tender_Sequence,
bpdT.start_date_time as TenderedStartTime,
convert(varchar(10),bpdT.start_date_time,21) as TenderedStartDate,
bpdT.end_date_time as TenderedEndTime,
bpdP.start_date_time as PostedStartTime,
convert(varchar(10),bpdP.start_date_time,21) as PostedStartDate,
bpdP.end_date_time as PostedEndTime,
ed.Emp_Name as ServerName,
edC.Emp_Name as CashierName,
tender_sequence_id,
refund_flag,
tender_name,
meal_period_name
into #Checks 
FROM [AGINDB01pr].[ig_business].[dbo].[Check_Sales_Detail] csd
left join [AGINDB01pr].[ig_business].[dbo].[Check_Discount_Detail] cdd on csd.transaction_data_id = cdd.transaction_data_id and discount_sequence_id=0
inner join [AGINDB01pr].[ig_dimension].[dbo].Business_Period_Dimension bpdT on csd.tendered_business_period_dim_id = bpdT.business_period_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Business_Period_Dimension bpdP on csd.posted_business_period_dim_id = bpdP.business_period_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Profit_Center_Dimension pc on pc.profit_center_dim_id = csd.profit_center_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Employee_Dimension ed on ed.emp_dim_id = csd.server_emp_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Employee_Dimension edC on edC.emp_dim_id = csd.cashier_emp_dim_id
inner join [AGINDB01pr].[ig_business].[dbo].[Check_Tender_Detail] ctd on csd.transaction_data_id = ctd.transaction_data_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Tender_Dimension td on ctd.tender_dim_id = td.tender_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Meal_Period_Dimension mp on csd.meal_period_dim_id = mp.meal_period_dim_id
left join [AGINDB01pr].[ig_dimension].[dbo].Discount_Dimension dd on cdd.discount_dim_id = dd.discount_dim_id
---left join  [vDW].[tableau].[player_dim] vp on vp.player_account_number = Acct

---where csd.transaction_data_id='9369703'
where bpdP.start_date_time >='01/01/2021'

select * from  #Checks --62388

select * from  #Checks  where acct<>''   --  20130 have an account numver

---Drop Table #Checks 