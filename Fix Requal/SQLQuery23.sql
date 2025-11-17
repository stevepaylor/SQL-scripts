select playerid, GamingDt, BucketGroupId, BasePts from CMP13.dbo.tplayerpoints  --- 
where playerid=(select playerid from CMP13.dbo.tplayercard where acct=20520169) 
--and GamingDt>='2020-07-01' 
and BucketGroupId<>1 
order by GamingDt desc

select sum(BasePts) from CMP13.dbo.tplayerpoints  --- 
where playerid=(select playerid from CMP13.dbo.tplayercard where acct=60062603) and GamingDt>='2020-07-01' 
and BucketGroupId<>1 

select sum(BasePts) from CMP13.dbo.tplayerpoints  --- 66773 Points
where playerid=1426933 and GamingDt>'2020-07-01' and BucketGroupId<>1

select sum(BasePts) from CMP13.dbo.viewMyViejasRequal  --- 66773 Points
where playerid=1426933 and GamingDt>'2020-07-01' --and BucketGroupId<>1

select sum(BasePts) from CMP13.dbo.tplayerpoints  --- 455886 Points
where playerid=1426933 and GamingDt>'2020-04-01' and BucketGroupId<>1


select top 1 * from CMP13.dbo.viewMyViejasRequal
where playerid=1426933 and GamingDt>'2020-07-01'

SELECT DISTINCT PlayerID, 0, GamingDt, BucketGroupId, BasePts FROM CMP13.dbo.tplayerpoints where playerid=1426933 and GamingDt>'2020-07-01'

SELECT PlayerID, IsVoid, GamingDt, DeptID4, BasePts FROM CMP13.dbo.viewMyViejasRequal where playerid=1426933 and GamingDt>'2020-07-01'
SELECT DISTINCT 
  PlayerID
, IsVoid
, GamingDt
, DeptID4
, BasePts 
FROM CMP13.dbo.viewMyViejasRequal
where playerid=1426933 
and GamingDt>'2020-07-01'

order by GamingDt desc


SELECT DISTINCT PlayerID, SUM(BasePts) FROM CMP13.dbo.tplayerpoints where playerid=1426933 and GamingDt>'2020-07-01' GROUP BY PlayerID

SELECT DISTINCT PlayerID, SUM(BasePts) FROM CMP13.dbo.viewMyViejasRequal where playerid=1426933 and GamingDt>'2020-07-01' GROUP BY PlayerID 

------Acct 12239681 / PlayerID 78186    has 29,905 tier points and is currently Silver.  In order to reach Gold he would need 70,095
------Acct 20520169 / PlayerID 1037053  has 21,970 tier points and is currently Silver.  In order to reach Gold he would need 78,030
------Acct 21134166 / PlayerID 10506311 has current tier points of 4,537 but current tier is Silver.  In order to reach Silver 
------------(as she currently qualifies for Bronze) would be 15,463 to next tier upgrade.
------Acct 60062603 / Player ID 1251485 has 0 points and is Bronze.  In order to reach Silver he would need 20,000
------Account 10008327 / Player ID 287455 has 0 points and is Silver.  In order to reach Silver he would need 20,000.
