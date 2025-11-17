[usp_PPGetPlayerDetailsV2] 12214004

select max(playerlastdate_12month)-91 from tableau.player_daily_fact where player_account_number='12214004'),101) )
select convert(varchar(10),(select max(playerlastdate_12month)-91 from tableau.player_daily_fact where player_account_number='12214004'),101) 
select convert(varchar(10),(select max(playerlastdate_12month) from tableau.player_daily_fact where player_account_number='12214004'),101) 


--- 36595.90   FPC   01/13/2019  and 04/14/2019

select top 100 * from tplayercard where acct=12214004

select top 100 [award_FPawarded_Total], * from tableau.player_daily_fact 
where player_id=286132  and gaming_date between '01/13/2019' and '04/14/2019'
order by gaming_date desc

select sum([award_FPawarded_Total]) from tableau.player_daily_fact --36595.90
where player_id=286132  and gaming_date between '01/13/2019' and '04/14/2019'
---order by gaming_date desc


select top 10000 BonusPromo1, prizecode, * from CMKTDB13cPR.cmp13.[dbo].[viewAwardsViejas]
where playerid=286132 and gamingdt>='01/13/2019' and  Trancode='AUTHPRMO'
and DATEDIFF(d, gamingdt,postdtm)>1


select top 10000 BonusPromo1, prizecode, te.FirstName as EMFirstName, Te.LastName as EMLastName,* from CMKTDB13cPR.cmp13.[dbo].[viewAwardsViejas] va inner join CMKTDB13cPR.cmp13.[dbo].temp te on va.empid = te.empid
where gamingdt>='04/01/2019' and  Trancode='AUTHPRMO' and te.empid<>'10000744'
and DATEDIFF(d, gamingdt,postdtm)>1



select Count(*), te.FirstName as EMFirstName, Te.LastName as EMLastName,te.empid, login from CMKTDB13cPR.cmp13.[dbo].[viewAwardsViejas] va inner join CMKTDB13cPR.cmp13.[dbo].temp te on va.empid = te.empid
where gamingdt>='01/01/2019' and  Trancode='AUTHPRMO' and te.empid<>'10000744'
and DATEDIFF(d, gamingdt,postdtm)>1
group by  te.FirstName, Te.LastName,te.empid, login
order by count(*) desc






select gamingdt, sum(BonusPromo1),
SUM(CASE WHEN a.PrizeCode = 'CSHWDPR' THEN a.AwardUsed ELSE 0 END) + SUM(CASE WHEN a.PrizeCode <> 'CSHDEPCR' THEN (a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr) ELSE 0 END ) as award_FPAwarded_Total
from CMKTDB13cPR.cmp13.[dbo].[viewAwardsViejas] a   --  32755.00
where playerid=286132 and gamingdt>='01/13/2019' ---and BonusPromo1<>0
group by gamingdt
order by gamingdt desc



--36595.90   from PP