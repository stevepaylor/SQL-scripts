USE [CMP13]
GO

/****** Object:  View [dbo].[viewPlayersViejas]    Script Date: 9/12/2018 1:35:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
















ALTER VIEW	[dbo].[viewPlayersViejas]	
AS
/*******************************************************************
	v_Players.sql

	Author:			Newgen
	Date:			05/26/2016
	Application:	CMPAPI
	VSS Location:	
	Description:		 
		Used to get players.

	UNIT TEST:		
		SELECT * FROM dbo.v_Players  		
		
	CHANGE LOG
	Date		Author	Version					Description
	-------------------------------------------------------------------------	
	05/25/2016	Newgen	1.0.8 (Title31 4.0.0)	Used to get players.
*******************************************************************/


SELECT	
		pl.PlayerId
	,	Acct
	,	RIGHT('00' + CONVERT(VARCHAR(20), pl.ClubState), 2) 'ClubState'
	,	sto.DataVal 'ClubStatus'
	,	LastName
	,	FirstName
	,	MiddleInitial
	,	DisplayName	
	,	Sex	
	,	BirthDt
	,	Pin
	,   pl.ModifiedDTM
	,	tIT1.IdentCode 'Id1Type'
	,	tIT1.IdentType 'Id1TypeName'	
	,	tIT1.IdentTypeId 'Id1TypeId' 
	,	tPIT1.PlayerIdentity 'Id1'
	,	tPIT1.IssueDt 'Id1IssueDt'
	,	tPIT1.ExpireDt 'Id1ExpireDt'
	,	tPA1.Address1 'HomeAddr1'
	,	tPA1.Address2 'HomeAddr2'
	,	tPA1.City 'HomeCity'
	,	s1.StateCode 'HomeStateCode'
	,	s1.StateName 'HomeStateName'
	,	c1.CountryCode 'HomeCountryCode'
	,	c1.Country 'HomeCountryName'
	,	tPA1.PostalCode 'HomePostalCode'
	,	tPE1.EmailAddress 'HomeEmail'
	,   tPE1.IsEmailSend
	,   tPCH.PrimaryHostEmpId 'HostEmpID'
	,   pl.IsPictureTaken
	,   pl.IsNoMail
	,   pl.LastTripStartTranCodeGamingDt 
	,   pl.IsReturnMail
	,	tPC.LastLocnId as 'LastLocnId'
	,	tPC.IsCardIn
	,	tPAD.Occupation 
	,	tPAD.OwnBusiness 
	,	tPAD.HireDt 
	,	tPAD.EmploymentStatus 
	,	tPAD.AnnualIncome 
	,	tPAD.TotalAssets 
	,	tPAD.Eyes
	,	tPAD.TotalDebts 
	,	tPAD.BusinessCode 
	,	tPAD.DependentCount 
	,	tPAD.IsBankruptcy 
	,	tPAD.LastBankruptcyDt 
	,	tPAD.IsHandicap
	,	tPAD.WeddingDate 'WeddingDt'
	,	tPAD.Marital
	,	tPAD.Smoker
	,	tPLC.CreditLimit
	,   tPLC.TripLimit
	,	tL.LanguageCode 'Language'
	,   pl.IsVIP
	,	IsBanned
	,	pl.IsInactive
	,	IsClubHold
	,	ISNULL(pl.PINLocked, 0) 'PINLocked'
	,	tPAD.Ethnicity 'ET_ETHENICITY'
	,	Height 
	,	[Weight]
	,	Hair
	,	convert(smalldatetime, convert(char(10), pl.SetupDtm, 102)) 'SetupDt'
	,	pl.SetupDtm 'SetupDtm'
	,	tPIT3.PlayerIdentity 'TaxId'
	,	(	
			SELECT sum(tPPr1B.Promo1 + tPPr1B.BonusPromo1 + tPPr1B.AdjPromo1Cr - tPPr1B.AdjPromo1Dr - tPPr1B.Promo1Used - tPPr1B.ExpirePromo1) 
			FROM dbo.tPlayerPromo1Bal tPPr1B WHERE tPPr1B.PlayerId = pl.PlayerId
		)  'Promo1Bal'
	,	(	
			SELECT sum(tPPr2B.Promo2 + tPPr2B.BonusPromo2 + tPPr2B.AdjPromo2Cr - tPPr2B.AdjPromo2Dr - tPPr2B.Promo2Used - tPPr2B.ExpirePromo2) 
			FROM dbo.tPlayerPromo2Bal tPPr2B WHERE tPPr2B.PlayerId = pl.PlayerId
		)  'Promo2Bal'	
     , (
			SELECT sum(stubsBal) from tPlayerStubBal tPStB WHERE tPStB.PlayerId = pl.PlayerId
        )   'StubsBal'

	 , (
			SELECT sum(ptsBal) from tPlayerPointBal tPPtB WHERE tPPtB.PlayerId = pl.PlayerId
        )   'PtsBal'

FROM	dbo.tPlayer pl (NOLOCK) 
JOIN	dbo.tPlayerCard tpc (NOLOCK) ON pl.PlayerId = tpc.PlayerId 
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










GO


