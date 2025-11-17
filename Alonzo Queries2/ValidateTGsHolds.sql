select top 10000 TheorHoldPc, gamecode, GameName, * from tlocn tl inner join tLocnAction tla
on tl.LocnId = tla.LocnId
inner join tgame tg on tla.GameId = tg.GameId
where deptid<>11 ----and LocnCode='VJC-VBJ203'
and tg.IsInactive=0 and tl.IsInactive=0 and GameCode<>'****'
order by tg.GameCode asc