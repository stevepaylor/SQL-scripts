select top 100 * from temp where lastname like 'Johnson'



SELECT count(*) FROM [CMKTDB13CPR].[CMP13].[dbo].[tUpdatedInfo] WITH (NOLOCK) 
where IsProcessed=0

select Count(*), convert(varchar(10), DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 101)
 ---,DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) 'createddtm'
from tplayertag
group by convert(varchar(10), DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 101), convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1),createdBy
having convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1)>='12/01/2018' and createdBy=838
order by convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1) asc



select top 1000000 DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm), 
 datepart("hh", DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) ) as Hour
from tplayertag
where convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1)='01/13/2019'
and createdBy=838



select count(*), convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1),
 datepart("hh", DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) ) as Hour
from tplayertag
where convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1) between '01/10/2019' and  '01/16/2019'
and createdBy=838
group by convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1),
 datepart("hh", DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) ) 
 order by convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1) asc, 
 datepart("hh", DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) ) asc




--group by convert(varchar(10), DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 101), convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1)
having convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1)>='12/01/2018'
order by convert(date, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), createddtm) , 1) asc

select top 10 * from temp where login='casino'

