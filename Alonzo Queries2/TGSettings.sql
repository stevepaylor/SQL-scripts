select top 100 locnCode, LocnName, TheorHoldPC from tlocn tl inner join 
[CMP13].[dbo].[tLocnAction] tla on tl.LocnId = tla.LocnId
where DeptId=13 and tl.IsInactive=0 and LocnType='TA'

--Frequency
select top 100 GameCode, GameName, FreqCode, FreqName, PlaysPerHour, isGameDefault from tGameFreq tf
inner join tFreq tfq on tf.FreqId = tfq.FreqId
inner join tgame tg on tf.GameId = tg.GameId
where tg.IsInactive=0 and tf.IsInactive=0 and tfq.IsInactive=0 and GameCode<>'****' and GameCode<>'BING'


-- Strategy

select top 100 GameCode, GameName, StratName, AdjTheorHoldPc, IsGameDefault from tGameStrat tf
inner join tStrat tfq on tf.StratId = tfq.StratId
inner join tgame tg on tf.GameId = tg.GameId
where tg.IsInactive=0 and tf.IsInactive=0 and tfq.IsInactive=0 and GameCode<>'****' and GameCode<>'BING'