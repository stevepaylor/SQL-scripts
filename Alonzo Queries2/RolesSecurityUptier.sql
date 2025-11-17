---To get Employees on a Role
select top 10000 login, firstname, Lastname, RoleCode, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode not in ('ChangePwd','ByPass')

--- To get Security Codes for a Role
select securitycode from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCSCSCS'

select top 100 * from tSecurityCode
where [Desc] like '%AllowEditClubState%'



--- To get Security Codes for a Role
select securitycode, RoleCode, RoleDescription  from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where SecurityCode='AllowEditClubState' and tr.IsInactive=0