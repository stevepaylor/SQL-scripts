select acct, sum(bet) from tslotrating tr inner join tplayercard tpc on tr.playerid = tpc.playerid
where GameID=25
and GamingDt>='2019-05-01' and GamingDt<='2019-05-30'
group by acct 
order by sum(bet) desc


select top 100 * from tGame