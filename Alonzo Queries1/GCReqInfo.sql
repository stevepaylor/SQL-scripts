SELECT
cdd.extra_text,
CASE WHEN LEN(cdd.extra_text)> 8 THEN
Replace(STUFF(cdd.extra_text, CHARINDEX('209', cdd.extra_text), LEN('209'), ''),'''','')
WHEN extra_text is null THEN cad.folio_number
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
where year(bpdP.start_date_time)=2022
and ( discount_name like '%platinum%' or discount_name like '%Infinity%')


select * from #Checks 
where tender_Sequence=0

and check_number=2440671
---where discount_name 
--like '%platinum%' or discount_name like '%Infinity%'

/*

---select * from #Checks left join  [vDW].[tableau].[player_dim] vp on vp.player_account_number = Acct

---select * from #Checks 

---   THIS TAKES A LONG TIME
select * 
into #Results1
from #Checks left join  [vDW].[tableau].[player_daily_fact] vp on 
CAST(vp.player_account_number as varchar(50)) = CAST(Acct as varchar(50))
and TenderedStartDate = convert(varchar(10), gaming_date,120)
*/

select gaming_days, * from #Results1
where gaming_days<>1 and  tender_Sequence=0

Select * INTO #players from [vDW].[tableau].[player_daily_fact] where convert(varchar(10), gaming_date,120) >= (Select Min(TenderedStartDate) from #Checks)


select * 
into #Results 
from #Checks left join  #players vp on 
CAST(vp.player_account_number as varchar(50)) = Acct
and TenderedStartDate = convert(varchar(10), gaming_date,120)


select * from #Results


select top 1000000  acct, player_first_name, player_last_name, player_club_level,  check_number as CheckNumber, TenderedStartDate, servername, cashiername, gaming_days, profit_center_name, profit_center_id,
Sales_Gross_Amount_Total, discount_amount_Total, discount_name
from  #Results 
 where tender_Sequence=0 and TenderedStartDate<='2022-02-07' and profit_center_id=46

where ACCT in

('12616738')

--(
--'10138889',
--'10150795',
--'10058456',
--'20098068',
--'20202713',
--'21092065',
--'21044354',
--'12293945',
--'12500083',
--'21079523',
--'12616738',
--'21258025'
--)
and profit_center_name='Grove Steakhouse' and Tender_Sequence=0
order by transaction_data_id, check_number asc

Drop Table #Checks 
Drop Table #Results 
Drop Table #players 
