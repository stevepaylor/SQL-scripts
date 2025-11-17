select top 10 * from tplayer
---update tplayer set PreferredCasinoId=3
where playerid = (select playerid from tplayercard where acct=12697242)