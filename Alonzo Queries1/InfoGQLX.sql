/****** Script for SelectTopNRows command from SSMS  ******/
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
cdd.extra_text,
CASE WHEN LEN(cdd.extra_text)> 8 THEN
Replace(STUFF(cdd.extra_text, CHARINDEX('209', cdd.extra_text), LEN('209'), ''),'''','')
WHEN extra_text is null THEN 
----Replace(STUFF(cad.folio_number, CHARINDEX('209', cad.folio_number), LEN('209'), ''),'''','')
cad.folio_number
ELSE extra_text
END AS Acct,
cad.folio_number,
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
ctd.tender_sequence_Id as Tender_Sequence,
bpdT.start_date_time as TenderedStartTime,
convert(varchar(10),bpdT.start_date_time,21) as TenderedStartDate,
bpdT.end_date_time as TenderedEndTime,
bpdP.start_date_time as PostedStartTime,
convert(varchar(10),bpdP.start_date_time,21) as PostedStartDate,
bpdP.end_date_time as PostedEndTime,
ed.Emp_Name as ServerName,
edC.Emp_Name as CashierName,
ctd.tender_sequence_id,
refund_flag,
tender_name,
meal_period_name
into #Checks 
FROM [AGINDB01pr].[ig_business].[dbo].[Check_Sales_Detail] csd
left join [AGINDB01pr].[ig_business].[dbo].[Check_Discount_Detail] cdd on csd.transaction_data_id = cdd.transaction_data_id and discount_sequence_id=0
left join [AGINDB01pr].[ig_business].[dbo].[Check_Account_Detail] cad on csd.transaction_data_id = cad.transaction_data_id and cad.tender_sequence_id=0
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

select top 100 * from #Checks
where check_number=5944215



select count(*) from #Checks   --   1066148
select count(distinct transaction_data_id) from #Checks   --   876498

Select Count(*) from #Checks  where acct<>''  ---629536
Select Count(distinct transaction_data_id) from #Checks  where acct<>''  ---451489  (51.51%)

Select count(*) from #Checks c inner join cmktdb13CPR.CMP13.dbo.tplayercard tpc on c.Acct = tpc.acct  -- 614428 ---  
Select count(distinct transaction_data_id) from #Checks c inner join cmktdb13CPR.CMP13.dbo.tplayercard tpc on c.Acct = tpc.acct  -- 436427 (49.79%)


DROP TABLE #Checks


/*


---select * from #Checks left join  [vDW].[tableau].[player_dim] vp on vp.player_account_number = Acct

---select * from #Checks 

---   THIS TAKES A LONG TIME
select * from #Checks left join  [vDW].[tableau].[player_daily_fact] vp on 
CAST(vp.player_account_number as varchar(50)) = CAST(Acct as varchar(50))
and TenderedStartDate = convert(varchar(10), gaming_date,120)
*/

Select * INTO #players from [vDW].[tableau].[player_daily_fact] where convert(varchar(10), gaming_date,120) >= (Select Min(TenderedStartDate) from #Checks)

select * from #Checks left join  #players vp on 
CAST(vp.player_account_number as varchar(50)) = Acct
and TenderedStartDate = convert(varchar(10), gaming_date,120)