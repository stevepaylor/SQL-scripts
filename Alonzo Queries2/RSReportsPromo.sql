Moving forward we will be requesting additional reports to ensure accuracy for our upcoming events.  

Would you be able to send a daily report that displays account number, first name, last name, empID, Emp First Name, Emp Last Name, Date awarded, Prizecode, Prizename 
where the account number is not like ‘999999%’ for the following Promotions, please:

Gift Card Giveaway:
Below prizecodes that are award before 2/21
P21BGD1ATT
P21BGD2ATT
P21BGD3ATT
P21BGD4ATT
P21BGD5ATT


select top 10 * from viewawardsviejas

select top 100 acct, vp.FirstName, vp.LastName, ClubStatus, te2.FirstName as HostFirstName, te2.LastName as HostLastname, te.login, te.FirstName as EmpFirstName, te.LastName as EmpLastName, va.PostDtm, va.PrizeCode, tp.prizename, GamingDt from viewawardsviejas va inner join viewPlayersViejas vp
on va.PlayerID = vp.PlayerId
inner join temp te on va.empid = te.empid
inner join temp te2 on vp.HostEmpID = te2.EmpId
inner join tprize tp on va.PrizeCode = tp.PrizeCode
where acct not like  '999999%'
and GamingDt<='2021-02-21'
and va.PrizeCode in

(
'P21BGD1ATT',
'P21BGD2ATT',
'P21BGD3ATT',
'P21BGD4ATT',
'P21BGD5ATT'
)

UNION ALL

select top 100 acct, vp.FirstName, vp.LastName,  ClubStatus, te2.FirstName as HostFirstName, te2.LastName as HostLastname, te.login, te.FirstName as EmpFirstName, te.LastName as EmpLastName, va.PostDtm, va.PrizeCode, tp.prizename, GamingDt from viewawardsviejas va inner join viewPlayersViejas vp
on va.PlayerID = vp.PlayerId
inner join temp te on va.empid = te.empid
inner join temp te2 on vp.HostEmpID = te2.EmpId
inner join tprize tp on va.PrizeCode = tp.PrizeCode
where acct not like  '999999%'
and GamingDt<='2021-02-28'
and va.PrizeCode in

(
'P21BGA1ATT',
'P21BGA2ATT'
)


Gift Giveaway Bonanza:
Below prizecodes that are awarded before 2/28
P21BGA1ATT
P21BGA2ATT

select top 10 * from viewPlayersViejas