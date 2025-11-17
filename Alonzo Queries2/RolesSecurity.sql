--Use to find security code  --- SettleNote
SELECT TOP 1000 [SecurityCodeId]
      ,[SecurityCode]
      ,[Desc]
  FROM [CMP13].[dbo].[tSecurityCode]
  where [Desc] like '%note%'

  --  AttachPlayerTags
  --  DetachPlayerTags
  --  SetPlayerTag


--ZMKSBD
--ZMKDIR
--ZCSGM
--ZMKMPR
--ZCASMG

  -- FILL   --  RequestFill
  -- 


  select top 100 * from temp where lastname like 'Newman' --17359

-- Roles that have the security code
select top 100 RoleName, RoleDescription, count(*) As TotalEmps from tRoleSecurityCode trs inner join tSecurityCode tsc on trs.SecurityCodeId = tsc.SecurityCodeId
 inner join trole tr on trs.RoleId = tr.RoleId
inner join tEmpCasinoRole tecr on tecr.RoleId = trs.RoleId
inner join temp te on tecr.empid = te.empid
where SecurityCode<>'SettleNote' and tr.IsInactive=0 and te.IsInactive=0 and tr.IsInactive=0 and login<>'11240'
group by RoleName, RoleDescription
having count(*)>0



-- Roles that don't have a specific security code

select RoleName, RoleDescription from tRoleSecurityCode trs inner join tSecurityCode tsc on trs.SecurityCodeId = tsc.SecurityCodeId
 inner join trole tr on trs.RoleId = tr.RoleId
inner join tEmpCasinoRole tecr on tecr.RoleId = trs.RoleId
inner join temp te on tecr.empid = te.empid
where tr.IsInactive=0 and te.IsInactive=0 and tr.IsInactive=0 and login<>'11240'

and rolename not in
(
select RoleName from tRoleSecurityCode trs inner join tSecurityCode tsc on trs.SecurityCodeId = tsc.SecurityCodeId
 inner join trole tr on trs.RoleId = tr.RoleId
inner join tEmpCasinoRole tecr on tecr.RoleId = trs.RoleId
inner join temp te on tecr.empid = te.empid
where SecurityCode='SettleNote' and tr.IsInactive=0 and te.IsInactive=0 and tr.IsInactive=0 and login<>'11240'
group by RoleName, RoleDescription
having count(*)>0
)
and rolecode not in ('HTLRAI', 'ChangePassword', 'Bypass')

group by RoleName, RoleDescription
having count(*)>0





ZCSCSCS
ZMKMP1
ZMKTAN
ZMKVVC
ZMKVS1
ZMKMPR






--To get Employees on a Role
select top 10000 Login, FirstName, LastName, rolecode from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode in ('ZMKMPR')
---AND ROLECODE NOT IN ('ChangePwd', 'ByPass') and lastname like 'thi%'


Select top 10 * from tEmpCasinoRole tcr inner join trole tr on tcr.RoleId = tr.RoleId
where empid=49 

---Delete from tEmpCasinoRole where empid=49



select top 10 * from temp where login='8168'





  --TO Get roles
select top 1000 rolecode, rolename, RoleDescription, tranlimit from trole tr
left join tRoleLimitConfig trl on tr.RoleId = trl.RoleId
left join tTranCode tc on tc.TranCodeId = trl.TrancodeId
where tr.IsInactive=0 and rolecode not in ('ByPass', 'HTLRAI', 'POS000', 'HTLPRD', 'HTLDIR')
and securitycode='AllowTagGateway'



--To get Employees on a Role
select top 100 * from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where te.IsInactive=0 and rolecode='ZCSSM3'

--  EMPS with mismached Position names
select top 100 login, firstname, lastname, position, RoleCode, RoleName, RoleDescription, * from tEmpCasinoRole tcr
inner join temp te on tcr.empid = te.empid
inner join trole tr on tcr.RoleId = tr.RoleId
where RoleCode ='AllowTagGateway' and Position<>RoleDescription and te.IsInactive=0 and FirstName<>'POS' and RoleCode<>'ByPass'
---where te.IsInactive=0 and rolecode='ZCSSMG'



Select top 100 * from 








--TO Get roles
select top 1000 rolecode, rolename, RoleDescription, tranlimit from trole tr
left join tRoleLimitConfig trl on tr.RoleId = trl.RoleId
left join tTranCode tc on tc.TranCodeId = trl.TrancodeId
where tr.IsInactive=0 and IsSystemUse=0 and TranCode='AuthCOMP'  and rolecode not in ('ByPass', 'HTLRAI', 'POS000', 'HTLPRD', 'HTLDIR')

GO

select rolecode, RoleDescription, count(*) from tEmpCasinoRole tecr
inner join tEmp te on tecr.EmpId = te.EmpId
inner join trole tr on tecr.RoleId = tr.RoleId
where te.IsInactive = 0 and tr.IsInactive =0 and tecr.RoleId<>1 and rolecode not in ('ByPass', 'HTLRAI') and RoleDescription like '%TAble%'
group by RoleCode, RoleDescription



QUERIES - POSITION CONSOLIDATION

select top 100 * from trole
where RoleDescription like '%customer%'

ZCSCSC -  Casino Services Cashier
Cage Cashier - ZCSCAS - 64 TMs
V Club Ambassador - ZMKVCA  -- 22 TMs


select securitycode, [Desc] from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZTGPCL'




select securitycode, * from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCSCAS'


select securitycode, * from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZMKVCA'



ZCSCSCS - Casino Services Cashier Supervisor
Cage Supervisor - ZCSSUP - - 14 TM
V Club Supervisor -  ZCSCSS -- 21 TM


select securitycode, * from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCSCSCS'


select securitycode, * from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZCGMGR'


-- Security Codes in one template but not in the other one
select securitycode, * from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZMKVPPD'
and securitycode not in
(
select securitycode from tRoleSecurityCode trsc
inner join tRole tr on trsc.RoleId = tr.RoleId
inner join tSecurityCode tsc on tsc.SecurityCodeId = trsc.SecurityCodeId
where rolecode='ZMKVCM'
)




select top 10 * from tprize
where prizename like '%cigar%'

select top 1000 prizecode, ref2, AuthAward, * from viewAwardsViejas
where trancode='AUTHMGMT' and prizecode in ('Cigarettes')
---and ref2 like '%cig%'
order by GamingDt desc

where 