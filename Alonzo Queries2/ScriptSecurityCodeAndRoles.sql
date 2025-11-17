--Use to find security code
SELECT TOP 1000 [SecurityCodeId]
      ,[SecurityCode]
      ,[Desc]
      ,[IsInactive]
      ,[CreatedDtm]
      ,[CreatedBy]
      ,[ModifiedDtm]
      ,[ModifiedBy]
      ,[DataRowVersion]
      ,[Group]
      ,[SubGroup]
  FROM [CMP13].[dbo].[tSecurityCode]
  where [Desc] like '%prize%'

-- Roles that have the security code
select top 100 RoleName, RoleDescription, count(*) As TotalEmps from tRoleSecurityCode trs inner join tSecurityCode tsc on trs.SecurityCodeId = tsc.SecurityCodeId
 inner join trole tr on trs.RoleId = tr.RoleId
inner join tEmpCasinoRole tecr on tecr.RoleId = trs.RoleId
inner join temp te on tecr.empid = te.empid
where SecurityCode='AllowTagGateway' and tr.IsInactive=0 and te.IsInactive=0 and tr.IsInactive=0
group by RoleName, RoleDescription
having count(*)>0

-- To Get Roles
select rolecode, RoleDescription, count(*) from tEmpCasinoRole tecr
inner join tEmp te on tecr.EmpId = te.EmpId
inner join trole tr on tecr.RoleId = tr.RoleId
where te.IsInactive = 0 and tr.IsInactive =0 and tecr.RoleId<>1 and rolecode not in ('ByPass', 'HTLRAI') and RoleDescription like '%Host%'
group by RoleCode, RoleDescription


--To get Employees on a Role - Casino Host
select top 100 Login, FirstName, LastName, Position, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZMKCAH' and login not in ('11240', '13177', 'VIEJAS')


--To get Employees on a Role - Executive Casino Host
select top 100 Login, FirstName, LastName, Position, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZMKCHM' and login not in ('11240', '13177', 'VIEJAS')

--To get Employees on a Role - Manager of Player Relations -- TBD
select top 100 Login, FirstName, LastName, Position, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZMKCHM' and login not in ('11240', '13177', 'VIEJAS')


--To get Employees on a Role - V-Club Ambassador -- ZMKVCA
select top 100 Login, FirstName, LastName, Position, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZMKVCA' and login not in ('11240', '13177', 'VIEJAS', 'casino')


--To get Employees on a Role -Casino Host -- ZMKCAH
select top 100 Login, FirstName, LastName, Position, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZMKCAH' and login not in ('11240', '13177', 'VIEJAS', 'casino')



select top 1000 * from temp where lastname like 'Stautz'

--To get Employees on a Role - V-Club Supervisor -- ZCSSMG
select top 100 Login, FirstName, LastName, Position, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZCSSMG' and login not in ('11240', '13177', 'VIEJAS', 'casino')


--To get Employees on a Role - V-Club Supervisor -- ZMKVCS
select top 100 Login, FirstName, LastName, Position, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZMKVCS' and login not in ('11240', '13177', 'VIEJAS', 'casino')


--To get Employees on a Role - V-Club Supervisor -- ZMKVVCA
select top 100 Login, FirstName, LastName, Position, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZMKVVCA' and login not in ('11240', '13177', 'VIEJAS', 'casino')

--To get Employees on a Role - VP of PD -- ZMKMPR
select top 100 Login, FirstName, LastName, Position, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZMKMPR' and login not in ('11240', '13177', 'VIEJAS', 'casino')


--To get Employees on a Role - GENERIC
select top 100 Login, FirstName, LastName, Position, RoleName, RoleDescription from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZTGFLS' and login not in ('11240', '13177', 'VIEJAS', 'casino')

select top 100 * from trole
where rolecode like 'zmk%'

select top 100 * from trole
where RoleDescription like '%v-Club%'




---select top 100 * from trole where roledescription like '%Supervisor%'

select top 100 * from trole where RoleName like 'ZMK%'



-- Roles that have the security code
select top 10000 RoleName, RoleDescription, securityCode from tRoleSecurityCode trs inner join tSecurityCode tsc on trs.SecurityCodeId = tsc.SecurityCodeId
 inner join trole tr on trs.RoleId = tr.RoleId
where rolecode='ZTGFLS' 

-- Roles that have the security code
select top 10000 RoleName, RoleDescription, securityCode from tRoleSecurityCode trs inner join tSecurityCode tsc on trs.SecurityCodeId = tsc.SecurityCodeId
 inner join trole tr on trs.RoleId = tr.RoleId
where rolecode='ZMKVPPD' 



SecurityCode='AllowTagGateway' and tr.IsInactive=0 and te.IsInactive=0 and tr.IsInactive=0
group by RoleName, RoleDescription
having count(*)>0