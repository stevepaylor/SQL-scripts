select top 100 * from taudit ta inner join tAuditDtl tad on ta.AuditId = tad.AuditId
where TranCode='MERGACCT' and Datavalue='21154867'


select top 10 * from tTranCode where TranName like '%merge%'  -- MERGACCT

select top 10 * from temp where lastname like '%hans%'


select RoleName, RoleDescription from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where securitycode='MergeCreditPlayerAccount' and tr.IsInactive=0

and RoleCode in 
(
select rolecode from tEmpCasinoRole tecr
inner join tEmp te on tecr.EmpId = te.EmpId
inner join trole tr on tecr.RoleId = tr.RoleId
where te.IsInactive = 0 and tr.IsInactive =0 and tecr.RoleId<>1 and rolecode not in ('ByPass', 'HTLRAI')
group by RoleCode, RoleDescription
having count(*)>0
)



