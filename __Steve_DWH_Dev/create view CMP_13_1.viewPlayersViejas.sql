USE [iQ-Gaming]
GO

IF EXISTS(SELECT 1 FROM SYS.VIEWS WHERE NAME='viewPlayersViejas' AND TYPE='V')
--IF OBJECT_ID('viewPlayersViejas','v') IS NOT NULL
DROP VIEW [CMP_13-1].[viewPlayersViejas]
GO

/****** Object:  View [dbo].[viewPlayersViejas]    Script Date: 6/27/2023 4:26:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW	[CMP_13-1].[viewPlayersViejas]	
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
		SELECT * FROM [CMP_13-1].v_Players  		
		
	CHANGE LOG
	Date		Author	Version					Description
	-------------------------------------------------------------------------	
	05/25/2016	Newgen	1.0.8 (Title31 4.0.0)	Used to get players.
	09/12/2018  S.Paylor added calculation for Comp Bal colunm in output
	10/8/2018   S.Paylor changed calculation for Comp Bal column to be zero if null 

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
	,   isnull(tPCH.PrimaryHostEmpId,'') 'HostEmpID'
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
			FROM [CMP_13-1].tPlayerPromo1Bal tPPr1B WHERE tPPr1B.PlayerId = pl.PlayerId
		)  'Promo1Bal'
	,	(	
			SELECT sum(tPPr2B.Promo2 + tPPr2B.BonusPromo2 + tPPr2B.AdjPromo2Cr - tPPr2B.AdjPromo2Dr - tPPr2B.Promo2Used - tPPr2B.ExpirePromo2) 
			FROM [CMP_13-1].tPlayerPromo2Bal tPPr2B WHERE tPPr2B.PlayerId = pl.PlayerId
		)  'Promo2Bal'	
     , (
			SELECT sum(stubsBal) from tPlayerStubBal tPStB WHERE tPStB.PlayerId = pl.PlayerId
        )   'StubsBal'

	 , (
			SELECT sum(ptsBal) from tPlayerPointBal tPPtB WHERE tPPtB.PlayerId = pl.PlayerId and BucketGroupID=1
        )   'PtsBal'

	 , ISNULL((
			SELECT CAST(ROUND(SUM(tPCB.EarnedComp + tPCB.AdjCompCr - tPCB.AdjCompDr - tPCB.CompUsed - tPCB.ExpireComp),2,1) AS DECIMAL(18,2))
			FROM tPlayerCompBal (nolock) tPCB 
			WHERE tPCB.PlayerID = pl.PlayerId
			  AND ISNULL((tPCB.EarnedComp + tPCB.AdjCompCr - tPCB.AdjCompDr - tPCB.CompUsed - tPCB.ExpireComp),0) <> 0
        ),0)   'COMPBal'

FROM	[CMP_13-1].tPlayer pl (NOLOCK) 
JOIN	[CMP_13-1].tPlayerCard tpc (NOLOCK) ON pl.PlayerId = tpc.PlayerId 
JOIN	[CMP_13-1].tPlayerAttributeDtl tpad (NOLOCK) ON tpad.PlayerID = tpc.PlayerId
LEFT JOIN	[CMP_13-1].tStorage sto (NOLOCK) ON sto.KeyType = 'ClubState'
			AND sto.KeyData = RIGHT('00' + convert(varchar(20), pl.ClubState), 2)
			AND sto.KeyName = 'Name'
LEFT JOIN	[CMP_13-1].tPlayerAddress tPA1 (NOLOCK) ON tPA1.PlayerId = pl.PlayerId 
			AND tPA1.ContactTypeId=1
LEFT JOIN	[CMP_13-1].tState s1 (NOLOCK) ON s1.StateId = tPA1.StateId
			AND s1.CountryId = tPA1.CountryId
LEFT JOIN	[CMP_13-1].tCountry c1 (NOLOCK) ON c1.CountryId = tPA1.CountryId
LEFT JOIN	[CMP_13-1].tPlayerEmail tPE1 (NOLOCK) ON tPE1.PlayerId = pl.PlayerId 
			AND tPE1.ContactTypeId = 1
LEFT JOIN	[CMP_13-1].tPlayerIdentType tPIT3 (NOLOCK) ON tPIT3.PlayerId = pl.PlayerId 
			AND tPIT3.IDIndex = 3
LEFT JOIN	[CMP_13-1].tPlayerIdentType tPIT1 (NOLOCK) ON tPIT1.PlayerId = pl.PlayerId 
			AND tPIT1.IDIndex = 1
LEFT JOIN	[CMP_13-1].tIdentType tIT1 (NOLOCK) ON tIT1.IdentTypeId = tPIT1.IdentTypeId
LEFT JOIN   [CMP_13-1].tPlayerCasinoHost tPCH (NOLOCK) on tPCH.PlayerId = pl.PlayerId
left join [CMP_13-1].tPlayerLimitConfig tPLC (NOLOCK) on tPLC.PlayerId = pl.PlayerId
LEFT JOIN   [CMP_13-1].tLanguage tL (NOLOCK) on tL.LanguageId = tPAD.LanguageId
GO

SELECT TOP 10 *
FROM [iQ-Gaming].[CMP_13-1].[viewPlayersViejas]	
GO
