select trancode, gamingdt, count(*) as TotalCount from viewAwardsViejas
where GamingDt>'2020-09-20' and trancode='ADJPTS'
group by trancode,gamingdt
order by gamingdt desc


go


select trancode, gamingdt, count(*) as TotalCount from viewAwardsViejas
where GamingDt>'2020-09-20' and trancode='ADJCOMP'
group by trancode,gamingdt
order by gamingdt desc


G0


select trancode, gamingdt, count(*) as TotalCount from viewAwardsViejas
where GamingDt>'2020-09-20' and trancode='ADJCOMP'
group by trancode,gamingdt
order by gamingdt desc


select trancode, gamingdt, * from viewAwardsViejas
where GamingDt='2020-09-29' and trancode='ADJPTS'

select trancode, gamingdt, * from viewAwardsViejas
where GamingDt='2020-09-29' and trancode='ADJCOMP'




select count(*) from tplayer --- 1.8 mill



EXEC CMP13.dbo.spGetAdjustPointsExpire_Prepare


select top 100 * from Temp_AdjustPointsExpire


select top 100000 * from  Temp_AdjustCompExpire
order by DrValue desc