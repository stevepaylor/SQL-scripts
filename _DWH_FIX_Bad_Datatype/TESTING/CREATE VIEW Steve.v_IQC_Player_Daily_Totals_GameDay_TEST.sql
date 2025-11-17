USE [iQ-Gaming]
GO

/****** Object:  View Steve.[v_IQC_Player_Daily_Totals_GameDay]    Script Date: 9/18/2023 11:09:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW Steve.[v_IQC_Player_Daily_Totals_GameDay_TEST]
AS
	SELECT BASE.RecordKey AS RecordKey, 
       --BASE.GamingDate AS GamingDate, 
	   BASE.GamingDateID,
	   BASE.playerID,
       BASE.tripNumber, 
	   BASE.chipsCoinInAmount, 
	   BASE.chipsCoinOutAmount, 
       BASE.games, 
	   BASE.jackpot, 
	   BASE.winLossAmount, 
       BASE.theoreticalWin, 
	   BASE.compsEarned, 
	   BASE.compsUsed, 
       BASE.BonusPointsEarned, 
	   BASE.PartialBonusPointsEarned, 
	   BASE.pointsEarned, 
       BASE.pointPlayUsed, 
	   BASE.freePlayUsed, 
	   BASE.markerPlay, 
       BASE.cashBuyInAmount,
	   BASE.slotWin, 
	   BASE.slotTheo, 
       BASE.tableWin,
	   BASE.tableTheo,
	   BASE.bingoWin,																						--CARL:  Added 7/31/23
	   BASE.bingoTheo,																						--CARL:  Added 7/31/23
	   CAST (BASE.SlotTheo + BASE.TableTheo + BASE.BingoTheo AS MONEY) AS TotalTheo,						--CARL:  Added 7/31/23
	   CAST((BASE.SlotWin + BASE.TableWin + BASE.BingoWin) * .4  AS MONEY) AS TotalWinPerc,					--CARL:  Added 7/31/23
	   CAST (CASE
			WHEN ( (BASE.SlotTheo + BASE.TableTheo + BASE.BingoTheo) > ( (BASE.SlotWin + BASE.TableWin + BASE.BingoWin)*(.4)) ) THEN (BASE.SlotTheo + BASE.TableTheo + BASE.BingoTheo)
			ELSE (BASE.SlotWin + BASE.TableWin + BASE.BingoWin) *.4
	   END AS MONEY) AS Worth,																				--CARL:  Added 7/31/23
	   BASE.slotDays,		
	   BASE.tableDays,
	   BASE.bingoDays,																						--CARL:  Added 7/31/23
       BASE.gamingDays, 
	   BASE.manualUpdate, 
	   COALESCE(BASE.CasinoCode, EXT.CasinoCode) AS CasinoCode,
	   BASE.LoadDTTM,
	   BASE.freePlayUsed AS PromoBuyIn,																				--CARL:  Added 7/31/23  (freePlayUsed = PromoBuyIn)
	   BASE.ECreditBuyIn,																							--CARL:  Added 7/31/23
	   BASE.PaidOut,																								--CARL:  Added 7/31/23
	   BASE.TheorHoldPc,																							--CARL:  Added 7/31/23
	   CASE WHEN ISNULL(BASE.PaidOut,0) = 0 THEN 0 ELSE (BASE.WinLossAmount / BASE.PaidOut) END AS ActualHoldPc,	--CARL:  Added 7/29/23
	   BASE.Hotel_RoomCat,																							--CARL:  Added 8/15/23
	   BASE.Hotel_RateCode,																							--CARL:  Added 8/15/23
	   CASE 																										
			WHEN DATEPART(WEEKDAY,C1.CalendarDate) LIKE '[1-5]' THEN BASE.Hotel_WD_Rate
			WHEN DATEPART(WEEKDAY,C1.CalendarDate) LIKE '[6-7]' THEN BASE.Hotel_WD_Rate
	   END AS Award_CompsUsed_Hotel_MKTG,																			--CARL:  Added 8/15/23
	   BASE.Hotel_ResvNameId,																						--CARL:  Added 8/15/23
	   BASE.Award_CompsUsed_Hotel_Finance, 																			--CARL:  Added 8/15/23
	   BASE.Hotel_CompsNoRooms_GrossAmount,																			--CARL:  Added 8/15/23
 	   BASE.SlotBuyInCredit,
	   BASE.SlotBuyInChips,
	   BASE.SlotBuyInPromo,
	   BASE.SlotBuyInECredit,
	   BASE.SlotPlays,
	   BASE.SlotTotalBet,
	   BASE.SlotPaidOut,
	   BASE.SlotJackpot,
	   BASE.TableBuyInCredit,
	   BASE.TableBuyInChips,
	   BASE.TableBuyInPromo,
	   BASE.TableBuyInECredit,
	   BASE.TablePlays,
	   BASE.TableTotalBet,
	   BASE.TablePaidOut,
	   BASE.TableJackpot,
	   BASE.BingoBuyInCredit,
	   BASE.BingoBuyInChips,
	   BASE.BingoBuyInPromo,
	   BASE.BingoBuyInECredit,
	   BASE.BingoPlays,
	   BASE.BingoTotalBet,
	   BASE.BingoPaidOut,
	   BASE.BingoJackpot,
	   EXT.CompRedeemedCount,
       EXT.CompDollarRedeemedAmount,
       EXT.HotelComps,
	   EXT.RetailComps,
       EXT.TableComps,
       EXT.FoodBevComps,
       EXT.TransportationComps,
	   EXT.MiscComps,
	   EXT.PointRedemptionCount,
	   EXT.PointDollarRedeemedAmountSlot,
	   EXT.PointDollarRedeemedAmountPOS,
	   EXT.PointsRedeemedAmountSlot,
	   EXT.PointsRedeemedAmountPOS,
	   EXT.SlotBuyIn,
	   EXT.TableBuyIn,
	   EXT.BingoBuyIn,
	   EXT.SlotMinutes,
	   EXT.TableMinutes,
	   EXT.BingoMinutes,
	   EXT.SlotMinutes + EXT.TableMinutes + EXT.BingoMinutes AS RatingPeriodMinutes,						--CARL:  Added 7/31/23
	   --BingoBuyIn AS BingoWin,																			--CARL:  Removed 7/31/23
	   --CAST(EXT.BingoBuyIn * 0.3 AS MONEY) AS BingoTheo,													--CARL:  Removed 7/31/23	
	   EXT.SlotSessionCount,
	   EXT.DistinctSlotDeviceCount,
	   EXT.SlotAvgWager,
	   EXT.TableAvgWager,
	   EXT.FreePlayTheo,
	   EXT.LoadDTTM AS LoadDTTM_EXT,
	   CAST(C1.CalendarDate AS DATE) AS GamingDate
	FROM Steve.IQC_Player_Daily_Totals_GameDay_TEST BASE
	INNER JOIN dbo.IQ_Calendar C1 ON BASE.GamingDateID = C1.DateID
	LEFT JOIN 
	(
		Steve.IQC_Player_Daily_Totals_GameDay_EXT_TEST EXT
		INNER JOIN dbo.IQ_Calendar C2 ON EXT.ExtDateID = C2.DateID
	
	) ON BASE.RecordKey = EXT.RecordKey
	WHERE BASE.CasinoCode <> 'CORP'				--NOTE: This can be removed once 'CORP' records are deleted
GO


