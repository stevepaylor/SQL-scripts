select top 100 acct, contactType, PhoneNumber from tplayerphone tpp inner join tContactType ct on tpp.ContactTypeId = ct.ContactTypeId
inner join tplayercard tpc on tpp.PlayerId = tpc.PlayerId
where acct=10006210 and tpp.IsInactive=1



select distinct contactType  from tplayerphone tpp inner join tContactType ct on tpp.ContactTypeId = ct.ContactTypeId
inner join tplayercard tpc on tpp.PlayerId = tpc.PlayerId
where tpp.IsInactive=1


select contactType, count(*) from tplayerphone tpp inner join tContactType ct on tpp.ContactTypeId = ct.ContactTypeId
where tpp.IsInactive=1
group by contactType
order by count(*) desc


select count(*) from tplayerphone



select ContactTypeId, count(*) from tplayerphone
group


