select GamingDt, count(*) from viewAwardsViejas
where PrizeCode='MVPBuff' and TranCode='AUTHMGMT'
and GamingDt='05/01/2019'
group by GamingDt

select  GamingDt, count(*) from tAwards av
where prizeid=24008 and TranCodeId=17 and GamingDt>'01/01/2017'
and empid=838
group by GamingDt
having count(*)<2000
order by GamingDt asc


select  GamingDt, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), aw.POSTDTM) as POSTDTM,  * from tAwards aw
where prizeid=24008 and TranCodeId=17 and GamingDt='05/01/2018'
group by GamingDt

select top 100 * from tprize where prizecode='MVPBuff'
select top 100 * from tTranCode where TranCode='AUTHMGMT'
