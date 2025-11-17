select gamingdt, gameid, sum(CasinoWin) as CasinoWin, sum(TheorWin) as TheoWin from  tslotRating
where GamingDt>'08/01/2019' and gameid=24
group by GamingDt, gameid
order by GamingDt asc

select locnid, sum(casinoWin) from tslotRating
where GamingDt>'08/01/2019' and gameid=24
group by  locnid
order by sum(casinoWin) asc



select gamingdt, tr.gameid, TheorWin, CasinoWin, tg1.GameName as WrongGame, tg2.GameName as CorrectGame, * from  tslotRating tr inner join tLocn lc on tr.LocnID = lc.LOcnID
inner join tLocnAction tla on lc.locnID = tla.LocnId
inner join tgame tg1 on tr.GameID = tg1.GameId
inner join tgame tg2 on tla.GameID = tg2.GameId

where GamingDt='08/01/2019' and tr.gameid=24 and tr.GameID<>tla.GameId and Playerid=34645



group by GamingDt, gameid
order by GamingDt asc


select top 100 * from tLocnAction



select top 100 * from tslotRating where LocnID=10012791

select top 100 * from tslotRating where LocnID=10007946


select top 100 * from tlocn where locnid=10012791

select top 100 * from tLocnAction where locnid=10012791

select top 100 * from tLocnAction where locnid=10007946

select top 100 * from tgame where gameid in (15, 24, 37)

