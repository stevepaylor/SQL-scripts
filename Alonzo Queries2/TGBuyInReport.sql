Select 
AreaName,
locnCode, 
locnName,
sum(CashBuyIn) as CashBuyIn,
sum(CreditBuyIn) as CreditBuyIn,
sum(PromoBuyIn) as PromoBuyIn,
sum(ECreditBuyIn) as ECreditBuyIn,
sum(ECashBuyIn) as ECashBuyIn
 from tTableRating tr
inner join tLocn tl on tr.LocnID = tl.LocnId
inner join tArea ta on tr.AreaID = ta.AreaId
where GamingDt='2021-04-28' and IsVoid=0
group by AreaName, LocnCode, locnName

select top 100 * fr



Select 
* 
 from tTableRating tr
inner join tLocn tl on tr.LocnID = tl.LocnId
inner join tArea ta on tr.AreaID = ta.AreaId
where GamingDt='2021-04-26' and IsVoid=0
group by LocnCode


select top 100 * from trole
where RoleDescription like '%Host%'
