select ta.acct, ClubStatus, DataName, DataValue, login, te.FirstName, te.LastName, ShiftDt 
INTO #Playercards
from taudit ta inner join tauditdtl tad
on ta.auditid = tad.AuditId
inner join viewplayersviejas vpv on ta.acct = vpv.Acct
inner join temp te on ta.EmpId = te.EmpId
where trancode ='PLCARD'
and DataName  in ('ADDITIONTEXT', 'NAME')
and shiftdt>='2021-09-01' ---and shiftdt<='2021-07-31'
and ta.acct=21256578
order by ta.AuditID desc


--Select top 100 * from tTranCode
--where tranname like '%make%'

-- DROP table #Playercards
select * from #Playercards
where DataName='ADDITIONTEXT'
order by ShiftDT asc



-- DROP table #Playercards  BRONZE
select top 1000000 * from #Playercards
where DataName='ADDITIONTEXT'
and ClubStatus='BRONZE' and (DataValue<>'' and DataValue<>'HEROES' and DataValue<>'BRONZE')


-- DROP table #Playercards - SILVER
select top 1000000 * from #Playercards
where DataName='ADDITIONTEXT'
and ClubStatus='SILVER' and (DataValue<>'' and DataValue<>'SILVER 12/31/2021' and DataValue<>'SILVER 06/30/2021' and DataValue<>'BRONZE'  and DataValue<>'HEROES')



-- DROP table #Playercards -- GOLD
select top 1000000 * from #Playercards
where DataName='ADDITIONTEXT'
and ClubStatus='GOLD' and (DataValue<>'' and DataValue<>'GOLD 12/31/2021'  and DataValue<>'GOLD 06/30/2021'  and DataValue<>'SILVER 12/31/2021' and DataValue<>'SILVER 06/30/2021'   and DataValue<>'GOLD 06/30/2021'  and DataValue<>'HEROES' and DataValue<>'BRONZE' and DataValue<>'TRIBAL GOLD')


-- DROP table #Playercards
select top 1000000 * from #Playercards
where DataName='ADDITIONTEXT'
and ClubStatus='PLATINUM' and (DataValue<>'' and DataValue<>'PLATINUM 12/31/21'  and  DataValue<>'PLATINUM 06/30/21' and DataValue<>'SILVER 12/31/2021' and DataValue<>'SILVER 06/30/2021'  and DataValue<>'GOLD 12/31/2021' and  DataValue<>'GOLD 06/30/2021'  and DataValue<>'HEROES' and DataValue<>'BRONZE' and DataValue<>'TRIBAL GOLD')



select top 10000 acct, firstName, lastname, GamingDt as DateWhenNoteAdded, ref1  from tPlayerNote tpn inner join viewPlayersViejas tp
on tpn.PlayerId = tp.PlayerId
where ref1 like '%Team%Member%'

