
--For this report would you be able to add an additional tab to identify players with more than one booking?

--For prizecodes like P2[0-9][A-L] where sum of the prize qty is >= 2 and where prizecodes like E2[0-9][A-L] where sum of the prize qty is > 2
--This would display those for a tournament with 2 or more RSVPs and/or for entertainment (where it defaults to 2) with 3 or more seats RSVP’d. 

--It should display the account number, first name, last name and the assigned host of the player, please.

--Would you also update the report to run daily vs the 2 times per week?



select prizename, HostEmpID, te.LastName as HostLastName, Count(*) as TotalRSVP
,sum(PrizeQty) as TotalRSVPQty
from viewAwardsViejas va inner join tprize tp on va.PrizeCode = tp.PrizeCode
inner join tPrizeEffectiveDtValidDt tpc on tp.PrizeId = tpc.PrizeID
inner join viewPlayersViejas vpv on va.playerid = vpv.playerid
left join temp te on te.empid = vpv.HostEmpID
where va.prizecode like '%_21%RS%' 
and PostDtm>=getdate()-45 and isvoid=0
and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ValidThroughDtm) >= GETDATE()
group by prizename, HostEmpID, te.LastName
order by PrizeName

