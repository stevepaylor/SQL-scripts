
--For this report would you be able to add an additional tab to identify players with more than one booking?

--For prizecodes like P2[0-9][A-L] where sum of the prize qty is >= 2 and where prizecodes like E2[0-9][A-L] where sum of the prize qty is > 2
--This would display those for a tournament with 2 or more RSVPs and/or for entertainment (where it defaults to 2) with 3 or more seats RSVP’d. 

--It should display the account number, first name, last name and the assigned host of the player, please.

--Would you also update the report to run daily vs the 2 times per week?



select va.prizecode, prizename, GamingDt, count(*) as TotalRSVP, te.Login as HostEmpID, te.FirstName as HostFirstName, te.LastName as HostLastName, acct, vpv.FirstName, vpv.LastName, ClubStatus, IsVoid, PrizeQty
from [CMKTDB13CPR].[CMP13].dbo.viewAwardsViejas va inner join [CMKTDB13CPR].[CMP13].dbo.tprize tp on va.PrizeCode = tp.PrizeCode
inner join [CMKTDB13CPR].[CMP13].dbo.tPrizeEffectiveDtValidDt tpc on tp.PrizeId = tpc.PrizeID
inner join [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas vpv on va.playerid = vpv.playerid
left join [CMKTDB13CPR].[CMP13].dbo.temp te on te.empid = vpv.HostEmpID

where va.prizecode like 'P21%RS%' 
and PostDtm>=getdate()-45 and isvoid=0
and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ValidThroughDtm) >= GETDATE()
group by 
va.prizecode, prizename, GamingDt, te.Login , te.FirstName , te.LastName, acct, vpv.FirstName, vpv.LastName, ClubStatus, IsVoid, PrizeQty
having count(*)>0
order by PrizeName desc



