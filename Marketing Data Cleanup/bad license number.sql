/****** Script for SelectTopNRows command from SSMS  ******/
drop table #ids
SELECT tt.playerid,
		Acct Account,
		FirstName + ' ' + LastName Guest,
		replace(replace(replace(PlayerIdentity, '-', ''), ' ', ''), '.', '') 'License Number'
		--,case when PlayerIdentity like '%0-9%' then 'number'
		--when PlayerIdentity like '%a-z%' then 'letters' else '' end id

		into #ids
  FROM CMP13.dbo.tPlayerIdentType tt
  left join dbo.viewPlayersViejas vv on tt.playerid = vv.PlayerId


 SELECT 
		Account,
		Guest,
		License Number


  FROM #ids tt
  left join dbo.viewPlayersViejas vv on tt.playerid = vv.PlayerId 
  where account is not null and Guest not like '%VIejas%' and
  --id = 'letters' and
  (
  License Number like '%PARAMEDIC%' or License Number like '%sheriff%' or
  License Number like '%air force%' or License Number like '%nurse%' or
  License Number like '%guard%' or License Number like '%doctor%' or
  License Number like '%retailmnpb%' or License Number like '%border%' or
  License Number like '%marine%' or License Number like '%army%' or
  License Number like '%active%' or License Number like '%navy%' or
  License Number like '%vet' or License Number like '%spouse%' or 
  License Number like '%HERO DEP%' or License Number like '%Police%' or
  License Number = REPLICATE(LEFT(License Number,1),LEN(License Number)) or 
  License Number like '12345%'
  )
  and License Number not like '%garret%'