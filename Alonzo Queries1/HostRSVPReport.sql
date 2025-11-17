select va.prizecode, prizename, GamingDt, te.Login as HostEmpID, te.FirstName as HostFirstName, te.LastName as HostLastName from viewAwardsViejas va inner join tprize tp on va.PrizeCode = tp.PrizeCode
inner join viewPlayersViejas vpv on va.playerid = vpv.playerid
inner join temp te on te.empid = vpv.HostEmpID
where va.prizecode like '%_20%RSV%'
and PostDtm>=getdate()-45

----select top 100 * from tprize
