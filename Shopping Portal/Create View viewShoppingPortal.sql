USE [CMP13]
GO

/****** Object:  View [dbo].[viewPlayersViejas]    Script Date: 3/1/2020 1:08:18 PM ******/
--DROP VIEW [dbo].[viewShoppingPortal]
--GO

/****** Object:  View [dbo].[viewPlayersViejas]    Script Date: 3/1/2020 1:08:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW	[dbo].[viewShoppingPortal]	
AS
/*******************************************************************
	v_Players.sql

	Author:			Alonzo Viscarra	
	Date:			03/01/2020
	Application:	ShoppingPortalRepl
	VSS Location:	
	Description:		 
		Used to feed transactional replication to database in Azure

		CHANGE LOG
	Date		Author				Description
	-------------------------------------------------------------------------	
	03/01/2020  spaylor/avizcarra	Initial creation

*******************************************************************/

SELECT TOP 1000 
  playerid
, acct
, FirstName
, MiddleInitial
, LastName
, ClubStatus
, HomeEmail
, IsEmailSend
, HomeAddr1
, HomeAddr2
, HomeCity
, HomeCountryCode
, HomeCountryName
, HomePostalCode
, HomeStateCode
, HomeStateName
, PtsBal 

FROM viewPlayersViejas

WHERE LastTripStartTranCodeGamingDt >= '02/01/2020'

GO


