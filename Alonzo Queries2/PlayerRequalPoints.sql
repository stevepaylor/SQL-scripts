select sum(basePTS)  from tPlayerPoints
where playerid=285998 and GamingDt>='2018-11-01'
and BucketGroupId=1

GO

select sum(basePTS)  from tPlayerPoints
where playerid=285998 and GamingDt>='2018-11-01'
and BucketGroupId<>1


select top 10 * from tplayercard where acct=10029502 -- 5985


-- 
select sum(basePTS)  from tPlayerPoints tp inner join tplayercard tpc on tp.playerid = tpc.playerid
where acct=10204116 and GamingDt>='2019-11-01'
and BucketGroupId<>1
