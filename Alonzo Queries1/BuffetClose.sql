select count(*) as TotalBuffets from tawards ta
where prizeid='24008' and IsOpenItem=1 and GamingDt<= convert(varchar(10),getdate()-1, 101)


select count(*) as TotalBuffets from tawards ta
where prizeid='24008' and IsOpenItem=1 and GamingDt = convert(varchar(10),getdate()-1, 101)

----select top 1000000 * from tawards ta
----where prizeid='10090156' and IsOpenItem=1 and GamingDt<='2019-09-23'

select top 100 * from tprize where prizecode='MVPBuff' -- 24008

select top 100 * from tprize where prizecode='InfiBuff' -- 10156375

4307

select top 5000 IsOpenItem, * from tawards where prizeid=10156375
and GamingDt='2022-01-06' and IsOpenItem=1 and postdtm > '2022-01-06 11:14:20.55 +00:00' 


select top 5000 IsOpenItem, * from tawards where prizeid=24008
and GamingDt='2022-01-06' and IsOpenItem=1 and postdtm > '2022-01-06 10:43:51.66 +00:00' 


-- To close extra buffets Infi
update tawards set IsOpenItem=0 where prizeid=10156375
and GamingDt='2022-01-06' and IsOpenItem=1 and postdtm > '2022-01-06 11:14:20.55 +00:00' 


-- To close extra buffets Pla
update tawards set IsOpenItem=0 where prizeid=24008
and GamingDt='2022-01-06' and IsOpenItem=1 and postdtm > '2022-01-06 10:43:51.66 +00:00' 


--TO CLOSE BUFFET
----update tawards set IsOpenItem=0 where prizeid='24008' and IsOpenItem=1 and GamingDt<= convert(varchar(10),getdate()-1, 101)

---update tawards set IsOpenItem=0 where prizeid='24008' and IsOpenItem=1 and GamingDt<= convert(varchar(10),getdate()-1, 101)



---select top 10 * from temp where login='15219'


----select top 100 * from tprize where prizecode='C19GFBCB00'  -- 10090156

select top 100 * from tretired where oldacct=20509547


select top 1000 * from viewawardsviejas
where trancode in ('EXPPRMO','ADJPRMO')
order by Gamingdt desc

EXPPRMO
ADJPRMO



select top 100 * from ttrancode where tranname like '%adjust%'

select convert(varchar(10),getdate()-1, 101)