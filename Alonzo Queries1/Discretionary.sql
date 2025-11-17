
select top 100 * from viewAwardsViejas va inner join viewPlayersViejas vp on va.playerid = vp.PlayerId
where 
gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
and 

((prizecode like 'FPCComp%' or prizecode = 'ECash-FPC') and BonusPromo1 > 0) 
or (awardcode = 'c'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite') and awardused > '0') 
or (awardcode = 'T' AND TRANCODE = 'SETLMGMT')
or (va.prizecode like 'NNC%' and va.Awardused > 0)



select gamingdt, acct, vp.firstName, vp.LastName, Clubstatus,
te2.FirstName as AuthFirstName, te2.LastName as AuthLastName, te2.Login as AuthEMPID, PrizeCode, Prizename
,va.AuthAward, sum(BonusPromo1)*PrizeQty as TotalBonus1,TranCode
from tawards va inner join tprize tp on va.prizeid = tp.prizeid
inner join tTranCode tc on va.TranCodeId = tc.TranCodeId
inner join viewPlayersViejas vp on va.PlayerID = vp.PlayerId
inner join temp te2 on va.AuthEmpID = te2.empid 
where (gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 23) and CONVERT(VARCHAR(10), GETDATE()-1, 23))
and--- acct= 10038052 and
(
(
(prizecode like 'FPCComp%' or prizecode = 'ECash-FPC') and BonusPromo1 > 0) 
or 
(va.awardcode = 'c'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite') and va.awardused > '0') 
or 
(va.awardcode = 'T' AND TRANCODE = 'SETLMGMT')
or 
(tp.prizecode like 'NNC%' and va.Awardused > 0)
)
group by 
gamingdt, acct, vp.firstName, vp.LastName, Clubstatus,
te2.FirstName, te2.LastName, te2.Login,
va.AuthAward,  TranCode, PrizeCode, Prizename, PrizeQty
having  sum(BonusPromo1) >0

select top 100 * from viewawardsviejas
where playerid=214836 and GamingDt='2021-07-27'


select CONVERT(VARCHAR(10), GETDATE()-31, 23)  from tawards






Sum of Free Play provided on each gaming date 
       ((prizecode like 'FPCComp%' or prizecode = 'ECash-FPC') and BonusPromo1 > 0) 
       or (awardcode = 'c'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite') and awardused > '0') 
       or (awardcode = 'T' AND TRANCODE = 'SETLMGMT')
       or (av.prizecode like 'NNC%' and av.Awardused > 0)
•	Sum of Comps provided on each gaming date
       (av.prizecode in ('MangmtComp','VocGftComp','Cigarettes') and av.awardcode in ('o') and awardused > '0') 
       or (av.prizecode in ('CSpa', 'Spa') and av.awardcode in ('I','B') and awardused > '0') 
       or (av.prizecode in ('OffSiteTks','OnsiteTxs') and av.awardcode in ('E','3') and awardused > '0') 
       or (av.prizecode in ('HostComp','Off_Event','Onst30All','Onst7All','Onst7Buff','Onst7F&B') and av.awardcode = 'F' and awardused > '0') 
       or (av.prizecode = 'CompOffer' and awardused > '0')
       or (av.prizecode = 'Golf'and awardused > '0')
       or (av.prizecode in ('Cigarettes', 'CSpa', 'Onst30Rtl', 'Onst7Rtl') and av.awardcode = 'M'and av.Awardused > 0)
•	Total Discretionary  (Free Play + Comps) – the sum of the above  two fields. 



select gamingdt, 
acct, 
vp.firstName, 
vp.LastName, 
Clubstatus,
te2.FirstName as AuthFirstName, 
te2.LastName as AuthLastName, 
te2.Login as AuthEMPID, 
sum(BonusPromo1*PrizeQty) as TotalBonus1,
va.AwardUsed as AwardUsed
into #temp
from tawards va inner join tprize tp on va.prizeid = tp.prizeid
inner join tTranCode tc on va.TranCodeId = tc.TranCodeId
inner join viewPlayersViejas vp on va.PlayerID = vp.PlayerId
inner join temp te2 on va.AuthEmpID = te2.empid 
inner join tempcasinorole tcr on tcr.empid = te2.empid
inner join trole tr on tcr.roleid = tr.RoleId
where (gamingdt between CONVERT(VARCHAR(10), GETDATE()-31, 23) and CONVERT(VARCHAR(10), GETDATE()-1, 23))
and
((
(prizecode like 'FPCComp%' or prizecode = 'ECash-FPC') and BonusPromo1 > 0) 
or 
(va.awardcode = 'c'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite') and va.awardused > '0') 
or 
(va.awardcode = 'T' AND TRANCODE = 'SETLMGMT')
or 
(tp.prizecode like 'NNC%' and va.Awardused > 0)
)
and isvoid = 'false'
and rolecode = 'ZMKVCA'
group by 
gamingdt, acct, vp.firstName, vp.LastName, Clubstatus,
te2.FirstName, te2.LastName, te2.Login,
va.AuthAward, 
PrizeQty, 
va.AwardUsed


Select gamingdt, 
acct, 
firstName, 
LastName, 
Clubstatus,
AuthFirstName, 
AuthLastName, 
AuthEMPID, 
Sum(TotalBonus1) as FreePlaySlots,
Sum(AwardUsed) as OtherAwards
From #temp
Group by gamingdt, 
acct, 
firstName, 
LastName, 
Clubstatus,
AuthFirstName, 
AuthLastName, 
AuthEMPID

having  sum(TotalBonus1) > 100 or sum(awardused) > 100
Order by GamingDt


DROP  TABLE #temp