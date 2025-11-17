select top 100 * from viewAwardsViejas
where GamingDt='10/12/2020' and TranCode in ('CSHSTLCR','CSHWDCR')
order by TranId desc


select top 100 * from viewAwardsViejas
where GamingDt='10/12/2020' and TranCode in ('CSHSTLCR')
order by TranId desc




select top 10 * from tTranCode where TranCode in ('CSHSTLCR','CSHWDCR')


select convert(varchar(10), DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)) 'DDDTM', datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM))) 'HHDTM', 
count(*) as TotalTransactions
from tSlotGatewayReceive pl
where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)>='2020-05-18 00:00:00.00 +00:00'
group by convert(varchar(10), DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)), datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)))



select convert(varchar(10), DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.PostDtm)) 'DDDTM', datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.PostDtm))) 'HHDTM', 
count(*) as TotalTransactions
from tawards pl inner join tTranCode ttc on pl.trancodeid = ttc.TranCodeId
where TranCode in ('CSHSTLCR') and DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.PostDtm)>='2020-10-01 00:00:00.00 +00:00'
group by convert(varchar(10), DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.PostDtm)), datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.PostDtm)))




