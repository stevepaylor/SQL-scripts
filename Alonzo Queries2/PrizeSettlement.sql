select Gamingdt, count(*) from viewawardsviejas
where trancode like'SETL%' and GamingDt>'2018-12-15'
group by Gamingdt
order by GamingDt asc


select Gamingdt, trancode, count(*) from viewawardsviejas
where trancode like'SETL%' and GamingDt>'2018-12-15'
group by Gamingdt,  trancode
order by GamingDt asc


select Gamingdt, prizecode, count(*) from viewawardsviejas
where trancode like'SETL%' and GamingDt>'2018-12-15' and prizecode like '%SNW%'
group by Gamingdt,  prizecode
order by GamingDt asc


select prizecode, count(*) from viewAwardsViejas
where IsOpenItem=1 and prizecode like '%SNW%' and IsVoid=0
group by prizecode

select top 100 * from viewAwardsViejas va left join viewPlayersViejas vpv on va.PlayerID = vpv.playerid where prizecode='P18KGL1SNW'
and IsOpenItem=1 and IsVoid=0


1293101


select top 100 * from tplayer where playerid=10456689


select top 10 * from temp where lastname like '%muri%'

select top 10 * from tprize where prizeid='10052213'


where playerid='227657' and CompBal<>0
order by TranID desc

select top 10 * from tplayercard where acct='10139850'

select max(playerlastdate_12month) from player_daily_fact
where acct=10301871