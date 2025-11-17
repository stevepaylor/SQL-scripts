select top 100 * from viewawardsviejas
where prizecode='InfiBuff' and IsOpenItem=1


select top 1000 * from viewawardsviejas
where prizecode='InfiBuff' and GamingDt='2021-08-06' and TranCode<>'SETLMGMT'



select top 1000 * from viewawardsviejas
where prizecode='MVPBuff' and GamingDt='2021-08-06' and TranCode<>'SETLMGMT'


select top 500 * from tAwards
where GamingDt='2021-08-06' and prizeid=10156375
and DeptID<>7

update tAwards set DeptID=7
where GamingDt='2021-08-06' and prizeid=10156375 and DeptID<>7

select top 10 * from tprize where prizecode='InfiBuff'

select top 100 * from tDept
