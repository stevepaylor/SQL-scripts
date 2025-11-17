select top 1000 prizecode, datepart(hh, PostDTM), * from viewAwardsViejas
where GamingDt='2022-04-08' and Trancode='AUTHMGMT' ---and Outlet='39'
order by tranid desc


select datepart(hh, PostDTM) as Hour, count(*) as NumberGuests, sum(AuthAward) as TotalAwarded from viewAwardsViejas
where GamingDt='2022-04-08' ---and Trancode='AUTHCOMP' -----and Outlet='39'
group by datepart(hh, PostDTM)

---order by tranid desc



select top 1000 * from tStorage where KeyType='POS'

select top 100 * from temp where login like 'P%'

select top 100 * from tplayercard where playerid=217103