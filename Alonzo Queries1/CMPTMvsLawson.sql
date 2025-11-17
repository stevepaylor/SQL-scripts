select FirstName, LastName, Login, IsInactive, tmcs.Team_Member_Status_CD, Team_Member_status_NM from temp te
left join casi23LS08pr.common_security.dbo.team_member tmcs on convert(varchar(10), te.Login) = convert(varchar(10), tmcs.team_member_num)
inner join casi23LS08pr.common_security.dbo.team_member_status_ref sr on tmcs.team_member_status_CD = sr.team_member_status_CD
where te.IsInactive=0 and tmcs.Team_Member_Status_CD not in ('A1', 'A2', 'A3', 'A4', 'A5', 'L1', 'L2')


select top 100 * from casi23LS08pr.common_security.dbo.team_member
where team_member_last_NM like 'Vizcarra'


select top 100 * from casi23LS08pr.common_security.dbo.team_member_status_ref 
where team_member_last_NM like 'Vizcarra'


