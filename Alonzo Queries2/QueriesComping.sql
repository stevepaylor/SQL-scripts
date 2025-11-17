Select top 1000000 Gamingdt, Trancode, va.Prizecode, PrizeName, va.AuthAward, va.BonusPromo1, Ref2, acct, vp.FirstName, vp.LastName, ClubStatus, te.Login, te.FirstName as EMPFirstName, te.LastName as EmpLastName, te.IsHost from viewAwardsViejas va inner join viewPlayersViejas vp on va.playerid = vp.playerid
inner join temp te on va.EmpID = te.EmpId
inner join tprize tp on tp.PrizeCode = va.PrizeCode
where 
---va.EMPID='10000377' and GamingDt>='2018-01-01' and isVoid=0 
GamingDt>='2016-03-20' and isVoid=0 and va.PrizeCode not in ('MVPBuff','SC001') and login not in ('SDS','14336', '15557','15411', 'ebsusr', 'casino')
and Trancode not in ('REDEEM') and NOT (va.AuthAward=0 and va.BonusPromo1=0)
and trancode in ('AUTHPRMO', 'AUTHCOMP', 'AUTHALT','AUTHMGMT')
and Acct=10003273
---order by TranId desc
b

select top 100 * from tprize


Select distinct Trancode from viewAwardsViejas va inner join viewPlayersViejas vp on va.playerid = vp.playerid
inner join temp te on va.EmpID = te.EmpId
where va.EMPID='10000377' and GamingDt>='2018-01-01' and isVoid=0 
---where GamingDt>='2018-01-01' and isVoid=0 
and Trancode not in ('REDEEM') and NOT (AuthAward=0 and BonusPromo1=0)
and trancode in ('AUTHPRMO', 'AUTHCOMP', ''
---order by TranId desc

---select top 100 * from temp where login='15713' -- 10000377

Select top 100000 Gamingdt, Trancode, Prizecode, AuthAward, BonusPromo1, Ref2, acct, FirstName, LastName, ClubStatus from viewAwardsViejas va inner join viewPlayersViejas vp on va.playerid = vp.playerid
where 
---EMPID='10000377' and 
GamingDt>='2018-01-01' and isVoid=0 
and PRizeCode='ECash-FPC'
and Trancode not in ('REDEEM') and NOT (AuthAward=0 and BonusPromo1=0)
order by TranId desc


Select sum(AuthAward), acct, FirstName, LastName, ClubStatus from viewAwardsViejas va inner join viewPlayersViejas vp on va.playerid = vp.playerid
where 
---EMPID='10000377' and 
GamingDt>='2018-01-01' and isVoid=0 
and PRizeCode='ECash-FPC'
and Trancode not in ('REDEEM') and NOT (AuthAward=0 and BonusPromo1=0)
group by acct, FirstName, LastName, ClubStatus 
order by sum(AuthAward) desc






ECash-FPC