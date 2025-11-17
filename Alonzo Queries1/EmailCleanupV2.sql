select top 10000 IsClubHold, EseriesProfileId, * from tplayer
where IsClubHold=1 and EseriesProfileId=1



update tplayer set EseriesProfileId=0 where  IsClubHold=1 and EseriesProfileId=1


select top 100000 * from tPlayerEmail tp inner join tContactType tct
on tp.ContactTypeId = tct.ContactTypeId
where tp.ContactTypeID=2


select top 100000 * from tPlayerEmail tp inner join tContactType tct
on tp.ContactTypeId = tct.ContactTypeId
where tp.ContactTypeID=2


select top 100 * from tContactType
where isemail=1

select ContactType, tp.ContactTypeId, count(*) as Count from tPlayerEmail tp inner join tContactType tct
on tp.ContactTypeId = tct.ContactTypeId
group by ContactType, tp.ContactTypeId

update tPlayerEmail set ContactTypeId=1 where ContactTypeId in (2,3)
and playerid not in (select playerid from tPlayerEmail where ContactTypeId=1)



select top 1000000 * from tPlayerEmail where ContactTypeId in (1) and EmailAddress like'%VIEJAS.COM'
and playerid in (select playerid from tPlayerEmail where ContactTypeId in (2,3) )

select top 1000000 * from tPlayerEmail where playerid=10761801

delete from tPlayerEmail where ContactTypeId in (2,3) and EmailAddress like'%VIEJAS.COM'

delete from tPlayerEmail where ContactTypeId in (1) and EmailAddress like'%VIEJAS.COM'
and playerid in (select playerid from tPlayerEmail where ContactTypeId in (2,3) )


select * from tplayeremail where playerid in 
(select playerid from tPlayerEmail where contacttypeid in (2,3))
and ContactTypeId=1--- and EmailAddress like '%viejas%'








where tp.ContactTypeID=2


select top 1