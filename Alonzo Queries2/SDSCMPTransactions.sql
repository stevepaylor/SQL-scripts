select top 100 datepart (hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM))) 'HOURDTM', 
DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM) 'ReceivedDTM',
* from tSlotGatewayReceive pl
order by SlotGatewayReceiveId desc


-- by hours
select datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM))) 'HOURDTM', 
count(*)
 from tSlotGatewayReceive pl
where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)>='2020-05-18 00:00:00.00 +00:00'
group by datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)))
order by datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM))) asc




-- by hours
select convert(varchar(10), DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)) 'DDDTM', datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM))) 'HHDTM', 
count(*)
 from tSlotGatewayReceive pl
where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)>='2020-05-18 00:00:00.00 +00:00'
group by convert(varchar(10), DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)), datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)))
order by convert(varchar(10), DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)) asc, datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM))) asc

select top 100 * from tSlotGatewayReceive
order by 1 desc




select datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM))) 'HOURDTM', 
count(*)
 from tSlotGatewayReceive pl
where DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM) between '2020-03-07 00:00:00.00 +00:00' and '2020-03-07 23:59:59.00 +00:00'
group by datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM)))
order by datepart(hh,(DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pl.ReceivedDTM))) asc