SELECT *
FROM msdb.dbo.sysoperators
WHERE email_address LIKE '%VIM%'
   OR email_address LIKE '%AVI%'
	 OR email_address LIKE '%6194339966@vtext.com%'
	 OR email_address LIKE '%6195653332@vtext.com%'
	 OR pager_address LIKE '%VIM%'
   OR pager_address LIKE '%AVI%'
	 OR pager_address LIKE '%6194339966@vtext.com%'
	 OR pager_address LIKE '%6195653332@vtext.com%'	
	 OR [name] LIKE '%Venkat%'
	 OR [name] LIKE '%Alonzo%'