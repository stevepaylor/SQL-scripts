
/****** Script for SelectTopNRows command from SSMS  ******/
/****** Script for SelectTopNRows command from SSMS  ******/
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
csd.tendered_date_time as TenderedDateTime,
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

----select * from [AGINDB01pr].[ig_business].[dbo].[Check_Sales_Detail] 


---where csd.transaction_data_id='9369703'
where bpdP.start_date_time between '2021-07-01' and '2021-08-31'

GO 

select  * into #ChecksQLX from vw_IQP_Sales 
where accountingdate between '2021-07-01' and '2021-08-31'

select * from #ChecksQLX 

select * from #Checks where tender_sequence=0   ---   3530
select * from #Checks where tender_sequence=0 and acct<>''  ---   1670

select c.TenderedDateTime as TenderedDateTime, convert(varchar(10),c.TenderedStartTime,23) as TripDTFormat,  check_number , c.Acct as cAcct, folio_number , tpc.playerid as PlayerIDFromCMP,  cq.playerid as PlayerIDFromQLX, c.transaction_data_id
INTO #TableResults
from  #Checks c inner join #ChecksQLX cq on c.transaction_data_id = cq.TransactionID
left join cmktdb13cpr.cmp13.dbo.tplayercard tpc on c.Acct = tpc.acct
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='542'
---and
---convert(varchar(10),c.TenderedDateTime,23) not in 
---(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='542'))

order  by discount_amount_Total desc

--- matching to credit cards
select top 10000 TenderedDateTime, csd.check_number, cad.tender_amount, cdd.discount_amount,  csd1.tip_amount/cad.tender_amount as TipPercentage,account_name, ed.emp_name 
INTO #TableResults542
from #TableResults csd 
  left join [AGINDB01pr].[ig_business].[dbo].[Check_Sales_Detail] csd1 on csd1.transaction_data_id = csd.transaction_data_id
  left join [AGINDB01pr].[ig_business].[dbo].[Check_Account_Detail] cad on csd.transaction_data_id = cad.transaction_data_id ---and cad.tender_sequence_id=0
  left join [AGINDB01pr].[ig_business].[dbo].[Check_Tender_Detail] ctd on csd.transaction_data_id = ctd.transaction_data_id
  left join [AGINDB01pr].[ig_dimension].[dbo].Tender_Dimension td on ctd.tender_dim_id = td.tender_dim_id
  left join [AGINDB01pr].[ig_business].[dbo].[Check_Discount_Detail] cdd on csd.transaction_data_id = cdd.transaction_data_id--- and discount_sequence_id=0
  left join [AGINDB01pr].[ig_dimension].[dbo].Discount_Dimension dd on cdd.discount_dim_id = dd.discount_dim_id
  inner join [AGINDB01pr].[ig_dimension].[dbo].Employee_Dimension ed on ed.emp_dim_id = csd1.server_emp_dim_id
  inner join [AGINDB01pr].[ig_dimension].[dbo].Employee_Dimension edC on edC.emp_dim_id = csd1.cashier_emp_dim_id

where tender_name<>'Cash' and ed.emp_name='Lungulow, Denise'
order by cdd.discount_amount desc


select * from #TableResults542 ---where emp_name='Lungulow, Denise'
order by account_name

select sum(tender_amount) as TotalTender, sum(discount_amount) as TotalDiscount, emp_name, count(*) as TotalCount
from #TableResults542
group by emp_name
order by count(*) desc

--DROP TABLE #TableResults542



-- 542   203 discounts
select c.TenderedStartTime, convert(varchar(10),c.TenderedStartTime,23) as TripDTFormat,  check_number, c.Acct, folio_number, tpc.playerid as PlayerIDFromCMP,  cq.playerid as PlayerIDFromQLX, * from  #Checks c inner join #ChecksQLX cq on c.transaction_data_id = cq.TransactionID
left join cmktdb13cpr.cmp13.dbo.tplayercard tpc on c.Acct = tpc.acct
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='542' and
convert(varchar(10),c.TenderedStartTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='542'))
order  by c.TenderedStartTime desc



-- 542   203 discounts -- TO GC
select c.TenderedDateTime,   check_number, c.Acct, profit_center_name, discount_name, Sales_Gross_Amount_Total, discount_amount_Total, servername, cashierName from  #Checks c
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='542' and
convert(varchar(10),c.TenderedDateTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='542'))
order  by c.TenderedDateTime desc


-- 5523   -- TO GC
select c.TenderedDateTime,   check_number, c.Acct, profit_center_name, discount_name, Sales_Gross_Amount_Total, discount_amount_Total, servername, cashierName from  #Checks c
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='5523' and
convert(varchar(10),c.TenderedDateTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='5523'))
order  by c.TenderedDateTime desc


-- 915    -- TO GC
select c.TenderedDateTime,   check_number, c.Acct, profit_center_name, discount_name, Sales_Gross_Amount_Total, discount_amount_Total, servername, cashierName from  #Checks c
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='915' and
convert(varchar(10),c.TenderedDateTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='915'))
order  by c.TenderedDateTime desc


-- 10208653    -- 
select c.TenderedDateTime,   check_number, c.Acct, profit_center_name, discount_name, Sales_Gross_Amount_Total, discount_amount_Total, servername, cashierName from  #Checks c
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and c.acct='10208653' and
convert(varchar(10),c.TenderedDateTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='10208653'))
order  by c.TenderedDateTime desc







-- 5523   203 discounts
select convert(varchar(10),c.TenderedStartTime,23) as TripDTFormat,  check_number, c.Acct, profit_center_name, discount_name, Sales_Gross_Amount_Total, discount_amount_Total, servername, cashierName from  #Checks c
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='5523' and
convert(varchar(10),c.TenderedStartTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='5523'))
order  by c.TenderedStartTime desc


-- 5523   203 discounts
select convert(varchar(10),c.TenderedStartTime,23) as TripDTFormat,  check_number, c.Acct, profit_center_name, discount_name, Sales_Gross_Amount_Total, discount_amount_Total, servername, cashierName from  #Checks c
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='915' and
convert(varchar(10),c.TenderedStartTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='915'))
order  by c.TenderedStartTime desc




-- 5523   106 discounts
select orderdatetime, c.TenderedStartTime, convert(varchar(10),c.TenderedStartTime,23) as TripDTFormat,  check_number, c.Acct, folio_number, tpc.playerid as PlayerIDFromCMP,  cq.playerid as PlayerIDFromQLX, * from  #Checks c inner join #ChecksQLX cq on c.transaction_data_id = cq.TransactionID
left join cmktdb13cpr.cmp13.dbo.tplayercard tpc on c.Acct = tpc.acct
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='5523' and
convert(varchar(10),c.TenderedStartTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='5523'))
order  by c.orderdatetime desc

-- 915   300 discounts
select c.TenderedStartTime, convert(varchar(10),c.TenderedStartTime,23) as TripDTFormat,  check_number, c.Acct, folio_number, tpc.playerid as PlayerIDFromCMP,  cq.playerid as PlayerIDFromQLX, * from  #Checks c inner join #ChecksQLX cq on c.transaction_data_id = cq.TransactionID
left join cmktdb13cpr.cmp13.dbo.tplayercard tpc on c.Acct = tpc.acct
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='915' and
convert(varchar(10),c.TenderedStartTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='915'))
order  by c.TenderedStartTime desc


-- 2629   13 discounts
select c.TenderedStartTime, convert(varchar(10),c.TenderedStartTime,23) as TripDTFormat,  check_number, c.Acct, folio_number, tpc.playerid as PlayerIDFromCMP,  cq.playerid as PlayerIDFromQLX, * from  #Checks c inner join #ChecksQLX cq on c.transaction_data_id = cq.TransactionID
left join cmktdb13cpr.cmp13.dbo.tplayercard tpc on c.Acct = tpc.acct
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='2629' and
convert(varchar(10),c.TenderedStartTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='2629'))
order  by c.TenderedStartTime desc


-- 2188    89 discounts
select c.TenderedStartTime, convert(varchar(10),c.TenderedStartTime,23) as TripDTFormat,  check_number, c.Acct, folio_number, tpc.playerid as PlayerIDFromCMP,  cq.playerid as PlayerIDFromQLX, * from  #Checks c inner join #ChecksQLX cq on c.transaction_data_id = cq.TransactionID
left join cmktdb13cpr.cmp13.dbo.tplayercard tpc on c.Acct = tpc.acct
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6  and c.acct='2188' and
convert(varchar(10),c.TenderedStartTime,23) not in 
(select  tripdt from cmktdb13cpr.cmp13.dbo.ttrip where playerid =(select playerid from cmktdb13cpr.cmp13.dbo.tplayercard where acct='2188'))
order  by c.TenderedStartTime desc



---
select c.TenderedStartTime, convert(varchar(10),c.TenderedStartTime,23) as TripDTFormat,  check_number, c.Acct, folio_number, tpc.playerid as PlayerIDFromCMP,  cq.playerid as PlayerIDFromQLX, * from  #Checks c inner join #ChecksQLX cq on c.transaction_data_id = cq.TransactionID
left join cmktdb13cpr.cmp13.dbo.tplayercard tpc on c.Acct = tpc.acct
where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6 
order  by c.TenderedStartTime desc

select acct, count(*) as TotalTransactions   from  #Checks c 
group by acct
order by count(*) desc

where Tender_Sequence = 0 and profit_center_id not in (16, 7) and c.acct<>'' and c.folio_number is NULL
and len(c.acct)<6 
order  by c.TenderedStartTime desc







select acct, count(*)
from #Checks
group by acct
order by count(*) desc


drop table #Checks 
drop table  #ChecksQLX

15850183

select top 100 * from [AGINDB01pr].[ig_business].[dbo].[Check_Account_Detail]
where transaction_data_id=15850183



select top 100 * from [AGINDB01pr].[ig_business].[dbo].[Check_Tender_Detail] 
where transaction_data_id=15850183


[AGINDB01pr].[ig_business].[dbo].[Check_Tender_Detail] 