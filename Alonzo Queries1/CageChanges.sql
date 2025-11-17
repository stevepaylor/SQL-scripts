---To get Employees on a Role
select top 100 login, firstname, Lastname, * from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZCSSMG'

---To get Employees on a Role
select top 100 login, firstname, Lastname, * from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZCGMGR'

---To get Employees on a Role
select top 100 login, firstname, Lastname, * from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZCSSUP'


---To get Employees on a Role
select top 100 login, firstname, Lastname, * from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZCGSUP'


---To get Employees on a Role
select top 100 login, firstname, Lastname, * from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZCSCSCS'






---To get Employees on a Role
select top 100 login, firstname, Lastname, * from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZCSCSC'


select top 10 * from temp where lastname like 'alvarado' -- 15139 -- 17050
select top 10 * from temp where EMPID='1762'




select securitycode from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCSCSCS'
and SecurityCode not in 
(
select securitycode from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCGMGR' 
)



select securitycode from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCGMGR'
and SecurityCode not in 
(
select securitycode from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCSSUP' 
)



select securitycode from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCGMGR'
and SecurityCode not in 
(
select securitycode from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCGSUP' 
)