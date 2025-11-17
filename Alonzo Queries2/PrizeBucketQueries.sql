select top 10 * from tPrizeBucketConfig

select top 100 prizecode, tp.prizeid, tbc.*, tbt.*, tbh.* from tprize tp left join tPrizeBucketConfig tbc on tp.prizeid = tbc.prizeid
left  join tBucketType tbt on tbc.BucketTypeId = tbt.BucketTypeId
left  join tBucketGroup tbh on tbc.BucketGroupId = tbh.BucketGroupId
where Prizecode like 'S19HT1G%'



select top 1000 * from taudit ta inner join tauditdtl tad on ta.AuditId = tad.AuditId
where Trancode  = 'MAINTPZ' and dataValue like 'S19HT1G%'
order by ta.AuditID desc

select top 10 * from tTranCode
where tranname like '%prize%'


select top 100 * from tprize where prizecode like 'S19HT1G%'


select top 10000  * 
into #PrizesAwarded
from viewAwardsViejas where prizecode like 'S19HT1G%'


select top 1000 prizecode, * from #PrizesAwarded


select top 100 * from tSecurityCode where [Desc] like '%note%'


select top 1000 prizecode, Trancode, count(*) from #PrizesAwarded
group by prizecode, Trancode

select top 10 * from temp where lastname like 'stau%'