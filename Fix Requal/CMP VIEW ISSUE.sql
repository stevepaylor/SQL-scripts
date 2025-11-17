SELECT	
  pl.PlayerId
, tpc.Acct
, RIGHT('00' + CONVERT(VARCHAR(20), pl.ClubState), 2) 'ClubState'
, sto.DataVal 'ClubStatus'
, sto.KeyType 'sto.ClubState'
, sto.KeyData 'sto.KeyData'
, sto.KeyName 'sto.KeyName'

FROM CMP13.dbo.tPlayer pl (NOLOCK)

JOIN CMP13.dbo.tPlayerCard tpc (NOLOCK) 
ON pl.PlayerId = tpc.PlayerId 

LEFT JOIN	dbo.tStorage sto (NOLOCK) 
ON sto.KeyType = 'ClubState'
AND sto.KeyData = RIGHT('00' + convert(varchar(20), pl.ClubState), 2)
AND sto.KeyName = 'Name'

WHERE ISNUMERIC(Acct) = 1
and Acct = 21134166

SELECT	
		pl.PlayerId
	,	Acct
	,	RIGHT('00' + CONVERT(VARCHAR(20), pl.ClubState), 2) 'ClubState'
	,	sto.DataVal 'ClubStatus'

FROM	dbo.tPlayer pl (NOLOCK) 
JOIN	dbo.tPlayerCard tpc (NOLOCK) ON pl.PlayerId = tpc.PlayerId 
----  ADDING ONE JOIN TO GET ACCOUNTS FROM EXPERITURE
JOIN MSBIDB01DV.CAMPAIGN.[dbo].[ExPlayers] expl on tpc.Acct = expl.playeraccount
JOIN	dbo.tPlayerAttributeDtl tpad (NOLOCK) ON tpad.PlayerID = tpc.PlayerId
LEFT JOIN	dbo.tStorage sto (NOLOCK) ON sto.KeyType = 'ClubState'
			AND sto.KeyData = RIGHT('00' + convert(varchar(20), pl.ClubState), 2)
			AND sto.KeyName = 'Name'
LEFT JOIN	dbo.tPlayerAddress tPA1 (NOLOCK) ON tPA1.PlayerId = pl.PlayerId 
			AND tPA1.ContactTypeId=1
LEFT JOIN	dbo.tState s1 (NOLOCK) ON s1.StateId = tPA1.StateId
			AND s1.CountryId = tPA1.CountryId
LEFT JOIN	dbo.tCountry c1 (NOLOCK) ON c1.CountryId = tPA1.CountryId
LEFT JOIN	dbo.tPlayerEmail tPE1 (NOLOCK) ON tPE1.PlayerId = pl.PlayerId 
			AND tPE1.ContactTypeId = 1
LEFT JOIN	dbo.tPlayerIdentType tPIT3 (NOLOCK) ON tPIT3.PlayerId = pl.PlayerId 
			AND tPIT3.IDIndex = 3
LEFT JOIN	dbo.tPlayerIdentType tPIT1 (NOLOCK) ON tPIT1.PlayerId = pl.PlayerId 
			AND tPIT1.IDIndex = 1
LEFT JOIN	dbo.tIdentType tIT1 (NOLOCK) ON tIT1.IdentTypeId = tPIT1.IdentTypeId
LEFT JOIN   dbo.tPlayerCasinoHost tPCH (NOLOCK) on tPCH.PlayerId = pl.PlayerId
left join dbo.tPlayerLimitConfig tPLC (NOLOCK) on tPLC.PlayerId = pl.PlayerId
LEFT JOIN   dbo.tLanguage tL (NOLOCK) on tL.LanguageId = tPAD.LanguageId

----WHERE tpc.createddtm>='2018-01-01 00:00:00.00'
WHERE ISNUMERIC(Acct) = 1
and Acct = 21134166



--CREATE VIEW	[dbo].[viewPlayersViejasRequalExt]	

--SELECT	
--		pl.PlayerId
--	,	Acct
--	,	RIGHT('00' + CONVERT(VARCHAR(20), pl.ClubState), 2) 'ClubState'
--	,	sto.DataVal 'ClubStatus'


--FROM	dbo.tPlayer pl (NOLOCK) 
--JOIN	dbo.tPlayerCard tpc (NOLOCK) ON pl.PlayerId = tpc.PlayerId 
------  ADDING ONE JOIN TO GET ACCOUNTS FROM EXPERITURE
--JOIN MSBIDB01DV.CAMPAIGN.[dbo].[ExPlayers] expl on tpc.Acct = expl.playeraccount
--JOIN	dbo.tPlayerAttributeDtl tpad (NOLOCK) ON tpad.PlayerID = tpc.PlayerId
--LEFT JOIN	dbo.tStorage sto (NOLOCK) ON sto.KeyType = 'ClubState'
--			AND sto.KeyData = RIGHT('00' + convert(varchar(20), pl.ClubState), 2)
--			AND sto.KeyName = 'Name'
--LEFT JOIN	dbo.tPlayerAddress tPA1 (NOLOCK) ON tPA1.PlayerId = pl.PlayerId 
--			AND tPA1.ContactTypeId=1
--LEFT JOIN	dbo.tState s1 (NOLOCK) ON s1.StateId = tPA1.StateId
--			AND s1.CountryId = tPA1.CountryId
--LEFT JOIN	dbo.tCountry c1 (NOLOCK) ON c1.CountryId = tPA1.CountryId
--LEFT JOIN	dbo.tPlayerEmail tPE1 (NOLOCK) ON tPE1.PlayerId = pl.PlayerId 
--			AND tPE1.ContactTypeId = 1
--LEFT JOIN	dbo.tPlayerIdentType tPIT3 (NOLOCK) ON tPIT3.PlayerId = pl.PlayerId 
--			AND tPIT3.IDIndex = 3
--LEFT JOIN	dbo.tPlayerIdentType tPIT1 (NOLOCK) ON tPIT1.PlayerId = pl.PlayerId 
--			AND tPIT1.IDIndex = 1
--LEFT JOIN	dbo.tIdentType tIT1 (NOLOCK) ON tIT1.IdentTypeId = tPIT1.IdentTypeId
--LEFT JOIN   dbo.tPlayerCasinoHost tPCH (NOLOCK) on tPCH.PlayerId = pl.PlayerId
--left join dbo.tPlayerLimitConfig tPLC (NOLOCK) on tPLC.PlayerId = pl.PlayerId
--LEFT JOIN   dbo.tLanguage tL (NOLOCK) on tL.LanguageId = tPAD.LanguageId

------WHERE tpc.createddtm>='2018-01-01 00:00:00.00'

--WHERE ISNUMERIC(Acct) = 1
--and Acct = 21134166