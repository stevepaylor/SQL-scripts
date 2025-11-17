-- TO GET RECORDS that mostl likely did not clear
select top 10000 tp.modifieddtm,datediff(mi,  tp.modifieddtm, getUTCdate()), * from tplayercard tp
where iscardin=1 and datediff(mi,  tp.modifieddtm, getUTCdate() )>10
order by tp.modifieddtm desc

select top 100 tp.modifieddtm, * from tplayercard tp
where iscardin=1 and tp.modifieddtm<='2018-11-28 16:01:37.17 +00:00'
order by tp.modifieddtm asc

update tplayercard set iscardin=0
where iscardin=1 and datediff(mi,  modifieddtm, getUTCdate() )>60



update tplayercard set iscardin=0
where iscardin=1 and acct=10019250


select * from tSlotRating
where playerid=5969

select top 10 * from tplayecard where acct=10019250



select ParameterConfigID, DisplayName, ColumnName from tParameterConfig (nolock) where ParameterConfigID in (2, 682)

select top 100 * from tParameterConfig


select top 10000 * from tplayercard
where iscardin=1 and acct=10019250

select top 100 * from ttablerating
where playerid=390438 and gamingdt='2018-11-19'

select top 100 * from tfreq


select top 100 * from ttrancodes where trancode like 'CHS%'


select top 10 * from ttag where tagcode like '%check%'

update ttag set Isinactive=0 where tagid=8

-- tag id   8
select top 10 *  from tplayertag
where tagid=8

select top 30 * from temp where lastname like '%chav%' --17058


select top 100 * from viewAllRatingsViejas where IsOpenItem=1

select top 10 acct, * from tTableRating tr inner join viewPlayersViejas tpc on tr.playerid = tpc.playerid where  IsOpenItem=1

update tTableRating set IsOpenItem=0 where IsOpenItem=1

select top 100 * from tplayercard where acct=10054592

update tplayercard set iscardin=0 where acct=10054592