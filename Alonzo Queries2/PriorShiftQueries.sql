select top 100 datediff(d, Gamingdt, PostDTM ), login, te.FirstName as EmpFirstName, te.LastName as EmpLastName, * from viewAwardsViejas va inner join temp te on va.EmpID = te.EmpId
where datediff(d, Gamingdt, PostDTM )>1 and
TranCode='AuthPRMO'
and GamingDt>='2019-03-10'


select securitycode, * from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where SecurityCode in ('AllowPriorShift') and tr.IsInactive=0


select securitycode, * from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCSCSC'

--- Templates with more than 1 EMP
select securitycode, * from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where SecurityCode in ( 'AllowOnePriorShift') and tr.IsInactive=0
and rolecode in 
(select rolecode from tEmpCasinoRole tecr
inner join tEmp te on tecr.EmpId = te.EmpId
inner join trole tr on tecr.RoleId = tr.RoleId
where te.IsInactive = 0 and tr.IsInactive =0 and tecr.RoleId<>1 and rolecode not in ('ByPass', 'HTLRAI')
group by RoleCode, RoleDescription
having count(*)>0
)


--- Templates with more than 1 EMP
select securitycode, * from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where SecurityCode in ( 'AllowPriorShift') and tr.IsInactive=0
and rolecode in 
(select rolecode from tEmpCasinoRole tecr
inner join tEmp te on tecr.EmpId = te.EmpId
inner join trole tr on tecr.RoleId = tr.RoleId
where te.IsInactive = 0 and tr.IsInactive =0 and tecr.RoleId<>1 and rolecode not in ('ByPass', 'HTLRAI')
group by RoleCode, RoleDescription
having count(*)>0
)





GO

select rolecode, RoleDescription, count(*) from tEmpCasinoRole tecr
inner join tEmp te on tecr.EmpId = te.EmpId
inner join trole tr on tecr.RoleId = tr.RoleId
where te.IsInactive = 0 and tr.IsInactive =0 and tecr.RoleId<>1 and rolecode not in ('ByPass', 'HTLRAI')
group by RoleCode, RoleDescription


select rolecode from tEmpCasinoRole tecr
inner join tEmp te on tecr.EmpId = te.EmpId
inner join trole tr on tecr.RoleId = tr.RoleId
where te.IsInactive = 0 and tr.IsInactive =0 and tecr.RoleId<>1 and rolecode not in ('ByPass', 'HTLRAI')
group by RoleCode, RoleDescription
having count(*)>0


select top 100 * from taudit
where NodeName='ITD013TW'
order by auditid desc