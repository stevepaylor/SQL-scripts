select top 100 bet/plays as AverageBet, * from tslotrating

select gamingdt, count(distinct playerid), sum(bet) as Bet, sum(plays) as Plays, AVG(bet/nullif(plays,0)) AverageBet from tslotrating t
group by gamingdt 
having GamingDt>='2020-01-01'
order by t.GamingDt asc


