select top 100 RedeemPts, AuthAward, * from viewawardsviejas
where playerid='500579' and GamingDt='12/19/2019'
and trancode like 'CSH%' and RedeemPts>0 and (redeempts*0.01) =AuthAward



select top 10000 RedeemPts, AuthAward, * from viewawardsviejas
where GamingDt='12/19/2019'
and trancode like 'CSH%' and RedeemPts>0 and (redeempts*0.01) =AuthAward




select sum(AuthAward) from viewawardsviejas
where GamingDt='12/19/2019'
and trancode like 'CSH%' and RedeemPts>0 and (redeempts*0.01) =AuthAward


select playerid, sum(AuthAward)from viewawardsviejas
where GamingDt='12/19/2019'
and trancode like 'CSH%' and RedeemPts>0 and (redeempts*0.01) =AuthAward
group by playerid
order by sum(AuthAward) desc


select count(*) from tStorage --5793





select top 10 * from tplayercard where acct='20031810'


select top 100 * from tAudit
where shiftdt='12/19/2019' and empid=4


select top 100 * from tAudit ta inner join tauditdtl tad on ta.AuditId = tad.AuditId
where shiftdt='12/19/2019' and trancode='MAINTSTO'



order by auditid



select top 10 * from temp where lastname like 'Nguyen'


select top 100 * from temp where empid=838