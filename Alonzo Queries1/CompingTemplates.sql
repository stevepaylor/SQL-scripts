select top 10000 RoleName, RoleDescription, TranLimit, * from tRoleLimitConfig trc
inner join tRole tr on trc.RoleId = tr.roleid
inner join tTranCode tc on trc.TrancodeId = tc.TranCodeId
where Trancode='AUTHCOMP' and tr.IsInactive=0 and RoleName like 'z%' and trc.IsInactive=0 and TranLimit<>0 ---TranCode='AUTHCOMP' and
and RoleCode in 
(
select rolecode from tEmpCasinoRole tecr
inner join tEmp te on tecr.EmpId = te.EmpId
inner join trole tr on tecr.RoleId = tr.RoleId
where te.IsInactive = 0 and tr.IsInactive =0 and tecr.RoleId<>1 and rolecode not in ('ByPass', 'HTLRAI')
group by RoleCode, RoleDescription
having count(*)>0
)
order by tr.RoleName

--select top 10 * from tRoleLimitConfig

select top 100 * from temp