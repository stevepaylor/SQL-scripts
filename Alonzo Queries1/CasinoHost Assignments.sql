select top 10 * from temp where lastname like '%trinidad%' --14460


select top 100 firstName, LastName,  from temp where IsHost=1 and isinactive=0


select login, LastName, count(*) from tPlayerCasinoHost tpc inner join temp te on tpc.PrimaryHostEmpId = te.EmpId
group by login, LastName
