/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  
tdd.tender_dim_id, tdd.tender_sequence_id, tdd.tender_amount, tender_name, check_number, sales_gross_amount, discount_amount, profit_center_name,
tendered_date_time, cs.tender_amount as Total_tendered, cs.tip_amount
FROM [ig_business].[dbo].[Check_Tender_Detail] tdd
inner join [ig_dimension].[dbo].Tender_Dimension t on tdd.tender_dim_id = t.tender_dim_id
inner join [ig_business].[dbo].[Check_Sales_Detail] cs on tdd.transaction_data_id = cs.transaction_data_id
inner join  [ig_dimension].[dbo].Business_Period_Dimension bd on cs.tendered_business_period_dim_id = bd.business_period_dim_id
inner join [ig_dimension].[dbo].Profit_Center_Dimension pc on cs.profit_center_dim_id = pc.profit_center_dim_id
where year(opened_date_time)=2020 and month(opened_date_time)>=10 ---and check_number=1221432













/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
dd.discount_name,
cdd.extra_text,
--CASE WHEN LEN(cdd.extra_text)> 7 THEN
--Replace(STUFF(cdd.extra_text, CHARINDEX('209', cdd.extra_text), LEN('209'), ''),'''','')
--ELSE NULL
--END AS Acct,
csd.transaction_data_tag,
left(csd.transaction_data_tag,8) as Acct,
csd.transaction_data_id,
profit_center_id,
profit_center_name,
check_number,
void_state,
sales_gross_amount as Sales_Gross_Amount_Total,
num_covers,
csd.discount_amount as discount_amount_Total,
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
inner join [AGINDB01pr].[ig_dimension].[dbo].Discount_Dimension dd on dd.discount_dim_id = cdd.discount_dim_id
inner join [AGINDB01pr].[ig_business].[dbo].[Check_Tender_Detail] ctd on csd.transaction_data_id = ctd.transaction_data_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Tender_Dimension td on ctd.tender_dim_id = td.tender_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Meal_Period_Dimension mp on csd.meal_period_dim_id = mp.meal_period_dim_id
---left join  [vDW].[tableau].[player_dim] vp on vp.player_account_number = Acct

---where csd.transaction_data_id='9369703'
where bpdP.start_date_time >='11/20/2020'

select * from #Checks where Sales_Gross_Amount_Total>150


where extra_text like '212381%'


select top 10000 Sales_Gross_Amount_Total*0.4-discount_amount_Total as Discount, * from #Checks--- where discount_name like '%Gold%'
--where discount_name in ('Bronze Tier', 'Silver Tier', 'Silver Tier B', 'Gold Tier', 'Gold Tier Bonus', 'Gold Retail', 'Gold Retail Bonu', 'Platinum Tier', 'Platinum Tier B', 'Platinum RetailB') ---and
where discount_name in ('Gold Tier Bonus', 'Gold Tier') ---and
and Tender_Sequence=0
and tender_name not in ('MyViejas Comp', 'CMP Loyalty') ---and Profit_center_name='The Cafe'
and (Sales_Gross_Amount_Total*0.4<>discount_amount_Total)  and (Sales_Gross_Amount_Total*0.4-discount_amount_Total)>0.002
order by check_number asc



and check_number=4725418


select * from #Checks left join  [vDW].[tableau].[player_daily_fact] vp on vp.player_account_number = Acct and TenderedStartDate = convert(varchar(10), gaming_date,120)

---DROP table #Checks


---select top 10000 * from  #Checks where acct<>''


 --select top 100 * from  [AGINDB01pr].[ig_business].[dbo].[Check_Sales_Detail] csd 
 --where check_number in ('5600076', '5600077')
 --order by transaction_data_id desc



 /****** Script for SelectTopNRows command from SSMS  ******/
SELECT  
menu_item_name,
product_class_name,
dd.discount_name,
cdd.extra_text,
--CASE WHEN LEN(cdd.extra_text)> 7 THEN
--Replace(STUFF(cdd.extra_text, CHARINDEX('209', cdd.extra_text), LEN('209'), ''),'''','')
--ELSE NULL
--END AS Acct,
csd.transaction_data_tag,
left(csd.transaction_data_tag,8) as Acct,
csd.transaction_data_id,
profit_center_id,
profit_center_name,
check_number,
void_state,
sales_gross_amount as Sales_Gross_Amount_Total,
num_covers,
csd.discount_amount as discount_amount_Total,
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


into #Checks2 
  FROM [AGINDB01pr].[ig_business].[dbo].[Check_Item_Detail] cid
  inner join [AGINDB01pr].[ig_dimension].[dbo].Menu_item_Dimension mid on cid.menu_item_dim_id = mid.menu_item_dim_id
  inner join [AGINDB01pr].[ig_business].[dbo].[Check_Sales_Detail] csd on cid.transaction_data_id = csd.transaction_data_id
left join [AGINDB01pr].[ig_business].[dbo].[Check_Discount_Detail] cdd on csd.transaction_data_id = cdd.transaction_data_id and discount_sequence_id=0
inner join [AGINDB01pr].[ig_dimension].[dbo].Business_Period_Dimension bpdT on csd.tendered_business_period_dim_id = bpdT.business_period_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Business_Period_Dimension bpdP on csd.posted_business_period_dim_id = bpdP.business_period_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Profit_Center_Dimension pc on pc.profit_center_dim_id = csd.profit_center_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Employee_Dimension ed on ed.emp_dim_id = csd.server_emp_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Employee_Dimension edC on edC.emp_dim_id = csd.cashier_emp_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Discount_Dimension dd on dd.discount_dim_id = cdd.discount_dim_id
inner join [AGINDB01pr].[ig_business].[dbo].[Check_Tender_Detail] ctd on csd.transaction_data_id = ctd.transaction_data_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Tender_Dimension td on ctd.tender_dim_id = td.tender_dim_id
inner join [AGINDB01pr].[ig_dimension].[dbo].Meal_Period_Dimension mp on csd.meal_period_dim_id = mp.meal_period_dim_id

---where csd.transaction_data_id='9369703'
where bpdP.start_date_time >='11/19/2020'

where check_number='6587919'


select * from #Checks2 where profit_center_name='Slot Floor'

tender_amount_byTender=180

DROP Table #Checks2


where discount_name in ('Silver Tier','Silver Tier B') and Tender_Sequence=0
and tender_name not in ('MyViejas Comp', 'CMP Loyalty')
and (Sales_Gross_Amount_Total*0.3<>discount_amount_Total) and profit_center_name not in ('Viejas Bar @ Bowl','East Lobby Bar', 'Central Bar')
and (product_class_name not like '%Beer%') and (product_class_name not like '%Cocktails%') and (product_class_name not like '%Whiskey%') and discount_amount_Total=0


select distinct check_number from #Checks2 
where ---and tender_name not in ('MyViejas Comp', 'CMP Loyalty')
discount_name in ('Silver Tier','Silver Tier B')
and (product_class_name not like '%Beer%') and (product_class_name not like '%Cocktails%') and (product_class_name not like '%Whiskey%') ---and discount_amount_Total=0
and profit_center_name='The Cafe' and (Sales_Gross_Amount_Total*0.3<>discount_amount_Total)
order by check_number

--SILVER
1855439
4382889
4632890

select distinct check_number from #Checks2 
where ---and tender_name not in ('MyViejas Comp', 'CMP Loyalty')
discount_name in ('Gold Tier Bonus', 'Gold Tier')
and (product_class_name not like '%Beer%') and (product_class_name not like '%Cocktails%') and (product_class_name not like '%Whiskey%') ---and discount_amount_Total=0
and profit_center_name='The Cafe' and (Sales_Gross_Amount_Total*0.4<>discount_amount_Total)
order by check_number

--GOLD
--0 GOLDS

-- Platinum
--  0 
select distinct check_number from #Checks2 
where ---and tender_name not in ('MyViejas Comp', 'CMP Loyalty')
discount_name in ('Platinum Tier', 'Platinum Tier B')
and (product_class_name not like '%Beer%') and (product_class_name not like '%Cocktails%') and (product_class_name not like '%Whiskey%') ---and discount_amount_Total=0
and profit_center_name='The Cafe' and (Sales_Gross_Amount_Total*0.5<>discount_amount_Total)
order by check_number


-- Bronzes
--  0 
select distinct check_number from #Checks2 
where ---and tender_name not in ('MyViejas Comp', 'CMP Loyalty')
discount_name in ('Bronze Tier')
and (product_class_name not like '%Beer%') and (product_class_name not like '%Cocktails%') and (product_class_name not like '%Whiskey%') ---and discount_amount_Total=0
and profit_center_name='The Cafe' and (Sales_Gross_Amount_Total*0.5<>discount_amount_Total)
order by check_number

--4632869

select distinct check_number from #Checks2 
where ---and tender_name not in ('MyViejas Comp', 'CMP Loyalty')
---discount_name in ('Bronze Tier')
(product_class_name not like '%Beer%') and (product_class_name not like '%Cocktails%') and (product_class_name not like '%Whiskey%') ---and discount_amount_Total=0
and discount_amount_Total=0
order by check_number







select distinct discount_name from  #Checks2









4632890
4382889
1855439

---DROP table #Checks2

select top 10 * from  [AGINDB01pr].[ig_dimension].[dbo].Menu_item_Dimension 
where menu_item_name='#2 Tres Enchiladas'