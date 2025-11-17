select gamingdt, acct, FirstName, LastName, ClubStatus, sum(NetPromo1) as TotalPromoAwarded, Player_ADT_Category from cmktdb13cpr.[CMP13].dbo.viewAwardsViejas va
inner join cmktdb13cpr.[CMP13].dbo.viewPlayersViejas vp on va.PlayerID = vp.PlayerId
left join player.tab_player_dim pd on vp.playerid = pd.player_id
where  
 gamingdt=@Date and TranCode='AUTHPRMO' and IsVoid=0
group by  gamingdt,   acct, FirstName, LastName, ClubStatus, Player_ADT_Category
having  sum(NetPromo1)>=500
order by  sum(NetPromo1) desc




Acct,
First Name,
Last Name,
Tier,
Host,
Date Authorized,
Authorizer – Name and Employee ID,
Prizecode,
Prizename,
Amount,
Printed Remarks

Prizecodes like ‘SvcRc%’


select gamingdt, acct, vp.firstName, vp.LastName, Clubstatus, te.FirstName as HostFirstName, te.LastName as HostLastName, 
te2.FirstName as AuthFirstName, te2.LastName as AuthLastName, te2.Login as AuthEMPID, PrizeCode, Prizename,
va.AuthAward, BonusPromo1, va.Ref1, va.Ref2, TranCode
from tawards va inner join tprize tp on va.prizeid = tp.prizeid
inner join tTranCode tc on va.TranCodeId = tc.TranCodeId
inner join viewPlayersViejas vp on va.PlayerID = vp.PlayerId
left join temp te on vp.HostEmpID = te.EmpId
inner join temp te2 on va.AuthEmpID = te2.empid 
where prizecode like 'SvcRc%' and gamingdt='2020-12-20'
and TranCode<>'SETLMGMT'


select top 100 * from tawards
