USE [iQ-Gaming]
GO

-------- Drop tamp tables if they exist
------drop table if exists ##DailyTotalsExtract_Steve
------drop table if exists ##DailyTripsExtract_Steve
------drop table if exists ##LGD_Extract_Steve

------IF OBJECT_ID('tempdb..#RawMarketingMetrics_Steve') IS NOT NULL    
------drop table #RawMarketingMetrics_Steve

------IF OBJECT_ID('tempdb..##SummedMarketingMetrics_Steve') IS NOT NULL    
------drop table ##SummedMarketingMetrics

------IF OBJECT_ID('tempdb..#Last3TripsbyProperty_Steve') IS NOT NULL    
------drop table #Last3TripsbyProperty_Steve

------IF OBJECT_ID('tempdb..##RankedTrips_Steve') IS NOT NULL  
------drop table ##RankedTrips_Steve

------IF OBJECT_ID('tempdb..##LastTrips_Steve') IS NOT NULL 
------drop table ##LastTrips_Steve

------IF OBJECT_ID('tempdb..#GuestType_Steve') IS NOT NULL
------drop table #GuestType_Steve


-------- Create extract tables

------	create table ##DailyTotalsExtract_Steve
------	       ( [Date]						[date]
------		    ,[DateID]					[int]
------		    ,[PlayerID]					[bigint]
------			,[CasinoCode]				[varchar](4)
------			,[GamingDays]				[int]
------			,[SlotDays]					[int]
------		    ,[TableDays]				[int]
------			,[TripNumber]				[int]
------			,[TheoreticalWin]			[numeric](18,2)
------			,[WinLossAmount]			[numeric](18,2)
------			,[ChipsCoinInAmount]		[numeric](18,2)
------			,[ChipsCoinOutAmount]		[numeric](18,2)
------			,[CompsEarned]				[numeric](18,2)
------			,[CompsUsed]				[numeric](18,2)
------			,[PointsEarned]				[numeric](18,2)
------			,[PointPlayUsed]			[numeric](18,2)
------			,[SlotWin]					[numeric](18,2)
------			,[SlotTheo]					[numeric](18,2)
------			,[TableWin]					[numeric](18,2)
------			,[TableTheo]				[numeric](18,2)
------			,[BingoTheo]				[numeric](18,2)
------			,[BingoWin]					[numeric](18,2)
------			,[dailyWorth]				[numeric](18,2)
------		   )	
		   
------	create table ##DailyTripsExtract_Steve
------	       ( [PlayerID]					[bigint]
------			,[CasinoCode]				[varchar](4)
------			,[TripNumber]				[int]
------			,[LastTripDate]				[date]
------		   )		

------    create table ##LGD_Extract_Steve
------	       ( [PlayerID]					[bigint]
------			,[CasinoCode]				[varchar](4)
------			,[LastTripDate]				[date]
------		   )	

---- Declare Date variables
	declare @baseLineDate date
	declare @beginningDate date
	declare @endPeriodDatetime date

--set @baseLineDate = DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1);
set @baseLineDate = DATEADD(day, -1, cast(GETDATE() as date));
print @baseLineDate;

set @beginningDate = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 36, 0)
print @beginningDate ; 

set @endPeriodDatetime = DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1);
print @endPeriodDatetime

----------------------------------------------------------------------------------------------------------------------------
------insert into ##DailyTotalsExtract_Steve
------select cast(CalendarDate as date) as [Date],
------		       [DateID],
------			   a.[playerID],
------			   [casinoCode],
------			   [gamingDays],
------			   [slotDays],
------			   [tableDays],
------			   [tripNumber],
------			   [theoreticalWin],
------			   [winLossAmount],
------			   [chipsCoinInAmount],
------			   [chipsCoinOutAmount],
------			   [compsEarned],
------			   [compsUsed],
------			   isnull(isnull(c.BasePts,0) + isnull(c.BonusPts,0),[pointsEarned]) as pointsEarned,
------			   [pointPlayUsed],
------			   [slotWin],
------			   [slotTheo],
------			   [tableWin],
------			   [tableTheo],
------			   [BingoBuyin]*0.40 as [BingoTheo],
------			   [BingoBuyin] as BingoWin,
------			   (select max(daily_worth)
------				from (values (isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull( [BingoBuyin]*0.40,0)),
------							 ((isnull(SlotWin,0)+isnull(TableWin,0)+isnull([BingoBuyin],0))*0.4)) as daily_worth(daily_worth)) as dailyWorth

------from dbo.v_IQC_Player_Daily_Totals_GameDay a

------inner join [iQ-Gaming].dbo.IQ_Calendar b
------on a.GamingDateID = b.DateID 

------left join  [iQ-Gaming].dbo.IQC_Player_Points c
------on c.GamingDate = b.CalendarDate 
------and a.Playerid = c.Playerid
------and b.CalendarDate between cast(@beginningDate as nvarchar(10)) and cast(@baseLineDate as nvarchar(10))

------SELECT TOP 1000 *
------FROM ##DailyTotalsExtract_Steve

----------------------------------------------------------------------------------------------------------------------------	
------insert into ##DailyTripsExtract_Steve
------select PlayerID, 
------		       CasinoCode, 
------			   TripNumber, 
------			   cast(max(TripBeginDate) as date) as LastTripDate

------from dbo.IQC_Player_Trips_GameDay

------group by PlayerID, CasinoCode, TripNumber

------SELECT TOP 1000 *
------from ##DailyTripsExtract_Steve

----------------------------------------------------------------------------------------------------------------------------	
-------- Create an index to improve processing
------	CREATE CLUSTERED INDEX IDX_Date_Casino ON ##DailyTotalsExtract_Steve([Date],CasinoCode)
------	CREATE CLUSTERED INDEX IDX_Player_Casino ON ##DailyTripsExtract_Steve(PlayerID,CasinoCode)
----------------------------------------------------------------------------------------------------------------------------	

------insert into ##LGD_Extract_Steve
------select PlayerID, 
------CasinoCode, 
------cast(max(TripBeginDate) as date) as LastTripDate

------from dbo.IQC_Player_Trips_GameDay 

------where cast(TripBeginDate as date) between cast(@beginningDate as nvarchar(10)) and cast(@baseLineDate as nvarchar(10))

------group by PlayerID, CasinoCode

------SELECT TOP 1000 *
------from ##LGD_Extract_Steve

---------------------------------------------------------------------------------------------------------------------------------

------drop table if exists ##RawRatings_Steve

------select 
------  cast(PlayerID as varchar(12)) + cast(CasinoCode as varchar(4)) as UniqueKey
------, playerID
------, CasinoCode
------, cast(GamingDate as date) as [Date]
------, GameType
------, GameCode
------, case
------	when SessionEnd > SessionStart 
------	then cast( DATEDIFF(ss, SessionStart, SessionEnd)/60 as decimal(12,2)) 
------	else cast(0 as decimal(12,2))
------  End as Rating_Minutes

------into ##RawRatings_Steve

------from [dbo].[IQC_Player_Ratings]

------where cast(GamingDate as date) > @endPeriodDatetime

------SELECT TOP 1000 *
------FROM ##RawRatings_Steve

-----------------------------------------------------------------------------------------------
------drop table if exists ##playerType_Steve 

------select 
------  p.playerID
------, 'VCR' as CasinoCode
------, cast(p.PlayerID as varchar(12)) + cast('VCR' as varchar(4)) as UniqueKey
------, p.PlayerTypeID
------, pt.PlayerTypeCode
------, pt.PlayerTypeName

------into ##playerType_Steve

------FROM 
------CMKTDB13DPR.CMP13.dbo.tPlayer p
------left join 

------CMKTDB13DPR.CMP13.dbo.tPlayerType pt
------on p.playerTypeID=pt.playerTypeID

------SELECT TOP 1000 *
------FROM ##playerType_Steve

---------------------------------------------------------------------------------------------------

--------
-------- Create the Raw Marketing Metrics data. These are Additional variables that supplement time silo defined in the base program added LastTrip date so can calculate the 3MonthLGD numbers
-------- 3MonthLGD is the the 3 months ratings from the last gamingday.  If last gaming day is 7/5/2018 the LGD timeframe is 7/31/2019 back through 5/1/2019, 3 months total
--------

------drop table if exists #RawMarketingMetricsEXT_Steve

------	select 
------		cast(a.PlayerID as varchar(12)) + cast(a.CasinoCode as varchar(4)) as UniqueKey, 
------		   	[Date],
------			b.LastTripDate,
------			eomonth(b.LastTripDate) as max_3MonthLGD,
------			DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) as min_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then 1 else 0 end as daysOnProperty_last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then 1 else 0 end as daysOnProperty_last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then 1 else 0 end as daysOnProperty_last2Months,
------	--		case when [Date] between DATEADD(day, 1, DATEADD(month,-3,eomonth(b.LastTripDate))) and eomonth(b.LastTripDate) then 1 else 0 end as daysOnProperty_3MonthLGD,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then gamingDays else 0 end as gamingDays_last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then gamingDays else 0 end as gamingDays_last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then gamingDays else 0 end as gamingDays_last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then gamingDays else 0 end as gamingDays_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then slotDays else 0 end as slotDays_last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then slotDays else 0 end as slotDays_last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then slotDays else 0 end as slotDays_last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then slotDays else 0 end as slotDays_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then tableDays else 0 end as tableDays_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then tableDays else 0 end as tableDays_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then tableDays else 0 end as tableDays_last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then tableDays else 0 end as tableDays_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then tripNumber else NULL end as tripNumber_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then tripNumber else NULL end as tripNumber_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then tripNumber else null end as tripNumber_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then tripNumber else NULL end as tripNumber_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then theoreticalWin else 0 end as totalTheo_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then theoreticalWin else 0 end as totalTheo_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then theoreticalWin else 0 end as totalTheo_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then theoreticalWin else 0 end as totalTheo_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then winLossAmount else 0 end as actualWinLoss_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then winLossAmount else 0 end as actualWinLoss_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then winLossAmount else 0 end as actualWinLoss_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then winLossAmount else 0 end as actualWinLoss_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then slotTheo else 0 end as slotTheo_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then slotTheo else 0 end as slotTheo_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then slotTheo else 0 end as slotTheo_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then slotTheo else 0 end as slotTheo_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then tableTheo else 0 end as tableTheo_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then tableTheo else 0 end as tableTheo_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then tableTheo else 0 end as tableTheo_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then tableTheo else 0 end as tableTheo_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then slotWin else 0 end as slotActualWinLoss_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then slotWin else 0 end as slotActualWinLoss_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then slotWin else 0 end as slotActualWinLoss_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then slotWin else 0 end as slotActualWinLoss_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then tableWin else 0 end as tableActualWinLoss_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then tableWin else 0 end as tableActualWinLoss_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then tableWin else 0 end as tableActualWinLoss_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then tableWin else 0 end as tableActualWinLoss_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then compsEarned else 0 end as compsEarned_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then compsEarned else 0 end as compsEarned_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then compsEarned else 0 end as compsEarned_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then compsEarned else 0 end as compsEarned_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then compsUsed else 0 end as compsUsed_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then compsUsed else 0 end as compsUsed_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then compsUsed else 0 end as compsUsed_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then compsUsed else 0 end as compsUsed_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then pointsEarned else 0 end as pointsEarned_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then pointsEarned else 0 end as pointsEarned_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then pointsEarned else 0 end as pointsEarned_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then pointsEarned else 0 end as pointsEarned_3MonthLGD,

------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then pointPlayUsed else 0 end as pointPlayUsed_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then pointPlayUsed else 0 end as pointPlayUsed_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then pointPlayUsed else 0 end as pointPlayUsed_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then pointPlayUsed else 0 end as pointPlayUsed_3MonthLGD,
	
------	--/*
------	--		case when [Date] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_YTD,
------	--		case when [Date] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_QTD,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_last24Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_last18Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_last12Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_last9Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_last6Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_last3Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_lastMonth,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then isnull(SlotTheo,0)+isnull(TableTheo,0)+isnull(BingoTheo,0) else 0 end as dailyWorth_3MonthLGD,
------	--*/
------	--		case when [Date] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then dailyWorth else 0 end as dailyWorth_YTD,
------	--		case when [Date] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then dailyWorth else 0 end as dailyWorth_QTD,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then dailyWorth else 0 end as dailyWorth_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then dailyWorth else 0 end as dailyWorth_last24Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then dailyWorth else 0 end as dailyWorth_last18Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then dailyWorth else 0 end as dailyWorth_last12Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then dailyWorth else 0 end as dailyWorth_last9Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then dailyWorth else 0 end as dailyWorth_last6Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then dailyWorth else 0 end as dailyWorth_last3Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then dailyWorth else 0 end as dailyWorth_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then dailyWorth else 0 end as dailyWorth_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then dailyWorth else 0 end as dailyWorth_lastMonth,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then dailyWorth else 0 end as dailyWorth_3MonthLGD,

------	--		case when [Date] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_YTD,
------	--		case when [Date] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_QTD,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_last24Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_last18Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_last12Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_last9Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_last6Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_last3Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(BingoTheo,0) else 0 end as BingoTheo_lastMonth,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then isnull(BingoTheo,0) else 0 end as BingoTheo_3MonthLGD,

------	--		case when [Date] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then [Date] else null end as PlayDates_YTD,
------	--		case when [Date] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then [Date] else null end as PlayDates_QTD,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then [Date] else null end as PlayDates_Last36Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then [Date] else null end as PlayDates_last24Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then [Date] else null end as PlayDates_last18Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then [Date] else null end as PlayDates_last12Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then [Date] else null end as PlayDates_last9Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then [Date] else null end as PlayDates_last6Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then [Date] else null end as PlayDates_last3Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then [Date] else null end as PlayDates_Last4Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then [Date] else null end as PlayDates_Last2Months,
------	--		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then [Date] else null end as PlayDates_lastMonth,
------			case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) and eomonth(LastTripDate) then [Date] else null end as PlayDates_3MonthLGD

------		into #RawMarketingMetricsEXT_Steve
------		from 
------			##DailyTotalsExtract_Steve a
------		left join 
------			(
------			select PlayerID, CasinoCode, LastTripDate from ##LGD_Extract_Steve --##LastTrips
------			) b
------		on a.PlayerID = b.PlayerID
------		and a.CasinoCode = b.CasinoCode

------	 where a.playerID <> 0

SELECT TOP 1000 *
FROM #RawMarketingMetricsEXT_Steve

--------------------------------------------------------------------------------------------------------------------------------------

------ Create an index to improve processing
----	CREATE CLUSTERED INDEX IDX_Player_Casino_EXT ON #RawMarketingMetricsEXT_Steve(UniqueKey)

--
-- Summarize detail data  by PlayerID, CasinoCode
--

DROP TABLE IF EXISTS #SummedMarketingMetricsEXT_Steve

select UniqueKey,
max(PlayDates_3MonthLGD ) as lastPlayDate_3MonthLGD

	into #SummedMarketingMetricsEXT_Steve
	from #RawMarketingMetricsEXT_Steve
	group by UniqueKey


SELECT TOP 1000 *
FROM #SummedMarketingMetricsEXT_Steve
WHERE lastPlayDate_3MonthLGD IS NOT NULL

/**************************************************************************************************************************************
--declare	@baseLineDate date = '2021-12-31'  
--declare @beginningDate date = '2019-01-01' 
	--Added SQC 2021-12

--
-- Do a similar pigeon-holing of the Awards table
--

drop table if exists #AwardsExtract 

		select 
			cast(a.PlayerID as varchar(12)) + 'VCR' as UniqueKey, 
			a.GamingDate,
			b.LastTripDate,
			eomonth(b.LastTripDate) as max_3MonthLGD,
			DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(LastTripDate)))) as min_3MonthLGD,

			/* template so when need other columns 
			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then  else 0 end as _YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then  else 0 end as _QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then  else 0 end as _Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then  else 0 end as _last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then  else 0 end as _last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then  else 0 end as _last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then  else 0 end as _last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then  else 0 end as _last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then  else 0 end as _last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then  else 0 end as _Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then  else 0 end as _Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then  else 0 end as _lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then  else 0 end as _3MonthLGD
			*/
			case when GamingDate between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_YTD,
			case when GamingDate between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_QTD,
			case when GamingDate between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_Last36Months,
			case when GamingDate between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_last24Months,
			case when GamingDate between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_last18Months,
			case when GamingDate between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_last12Months,
			case when GamingDate between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_last9Months,
			case when GamingDate between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_last6Months,
			case when GamingDate between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_last3Months,
			case when GamingDate between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_Last4Months,
			case when GamingDate between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_Last2Months,
			case when GamingDate between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_FPUsed,0) else 0 end as award_FPUsed_lastMonth,
			case when GamingDate between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_FPUsed,0) else 0 end as award_FPUsed_3MonthLGD,

			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_FPAwarded_ServiceRecovery,0) else 0 end as award_FPAwarded_ServiceRecovery_3MonthLGD,

			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0)  else 0 end as award_FPAwarded_PromoWinner_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_FPAwarded_PromoWinner,0) else 0 end as award_FPAwarded_PromoWinner_3MonthLGD,

			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(Award_Cash_Total,0) else 0 end as Award_Cash_Total_3MonthLGD,

			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_Cash_PromoWinner,0) else 0 end as award_Cash_PromoWinner_3MonthLGD,

			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_PromoChipsUsed_Total,0) else 0 end as award_PromoChipsUsed_Total_3MonthLGD,

			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_PromoChipUsed_ServiceRecovery,0) else 0 end as award_PromoChipUsed_ServiceRecovery_3MonthLGD,
			
			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_PromoChipUsed_PromoWinner,0) else 0 end as award_PromoChipUsed_PromoWinner_3MonthLGD,

			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_Comp_Total_NoHotel,0) else 0 end as award_Comp_Total_NoHotel_3MonthLGD,

			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_Comp_ServiceRecovery,0) else 0 end as award_Comp_ServiceRecovery_3MonthLGD,

			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_FB_Benefit,0) else 0 end as award_FB_Benefit_3MonthLGD,

			case when [GamingDate] between DATEADD(year, DATEDIFF(year, 0 ,@baselineDate),0) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_YTD,
			case when [GamingDate] between DATEADD(quarter, DATEDIFF(quarter, 0 ,@baselineDate),0) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_QTD,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_Last36Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_last24Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_last18Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_last12Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_last9Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_last6Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_last3Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_Last4Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_Last2Months,
			case when [GamingDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_lastMonth,
			case when [GamingDate] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then isnull(award_FB_HostDine,0) else 0 end as award_FB_HostDine_3MonthLGD

		into #AwardsExtract				                                                                                                                                                                                                           
		from 
			[iQ-Gaming].[dbo].[IQC_Awards] a
		left join 
			(select PlayerID, CasinoCode, LastTripDate from ##LGD_Extract --##LastTrips
			) b
		on a.PlayerID = b.PlayerID
			and a.CasinoCode = b.CasinoCode
		where a.playerID <> 0
			and a.CasinoCode in ('VCR')

	--Added SQC 2021-12
	
drop table if exists #AwardsSum

		select 
		 UniqueKey, 
			/* template in case needed
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			sum( ) as ,
			*/

			sum(award_FPUsed_YTD) as award_FPUsed_YTD,
			sum(award_FPUsed_QTD) as award_FPUsed_QTD,
			sum(award_FPUsed_Last36Months) as award_FPUsed_Last36Months,
			sum(award_FPUsed_last24Months) as award_FPUsed_last24Months,
			sum(award_FPUsed_last18Months) as award_FPUsed_last18Months,
			sum(award_FPUsed_last12Months) as award_FPUsed_last12Months,
			sum(award_FPUsed_last9Months) as award_FPUsed_last9Months,
			sum(award_FPUsed_last6Months) as award_FPUsed_last6Months,
			sum(award_FPUsed_last3Months) as award_FPUsed_last3Months,
			sum(award_FPUsed_Last4Months) as award_FPUsed_Last4Months,
			sum(award_FPUsed_Last2Months) as award_FPUsed_Last2Months,
			sum(award_FPUsed_lastMonth) as award_FPUsed_lastMonth,
			sum(award_FPUsed_3MonthLGD) as award_FPUsed_3MonthLGD,

			sum(award_FPAwarded_ServiceRecovery_YTD ) as award_FPAwarded_ServiceRecovery_YTD,
			sum(award_FPAwarded_ServiceRecovery_QTD ) as award_FPAwarded_ServiceRecovery_QTD,
			sum(award_FPAwarded_ServiceRecovery_Last36Months ) as award_FPAwarded_ServiceRecovery_Last36Months,
			sum(award_FPAwarded_ServiceRecovery_last24Months ) as award_FPAwarded_ServiceRecovery_last24Months,
			sum(award_FPAwarded_ServiceRecovery_last18Months ) as award_FPAwarded_ServiceRecovery_last18Months,
			sum(award_FPAwarded_ServiceRecovery_last12Months ) as award_FPAwarded_ServiceRecovery_last12Months,
			sum(award_FPAwarded_ServiceRecovery_last9Months ) as award_FPAwarded_ServiceRecovery_last9Months,
			sum(award_FPAwarded_ServiceRecovery_last6Months ) as award_FPAwarded_ServiceRecovery_last6Months,
			sum(award_FPAwarded_ServiceRecovery_last3Months ) as award_FPAwarded_ServiceRecovery_last3Months,
			sum(award_FPAwarded_ServiceRecovery_Last4Months ) as award_FPAwarded_ServiceRecovery_Last4Months,
			sum(award_FPAwarded_ServiceRecovery_Last2Months ) as award_FPAwarded_ServiceRecovery_Last2Months,
			sum(award_FPAwarded_ServiceRecovery_lastMonth ) as award_FPAwarded_ServiceRecovery_lastMonth,
			sum(award_FPAwarded_ServiceRecovery_3MonthLGD ) as award_FPAwarded_ServiceRecovery_3MonthLGD,

			sum(award_FPAwarded_PromoWinner_YTD ) as award_FPAwarded_PromoWinner_YTD,
			sum(award_FPAwarded_PromoWinner_QTD ) as award_FPAwarded_PromoWinner_QTD ,
			sum(award_FPAwarded_PromoWinner_Last36Months ) as award_FPAwarded_PromoWinner_Last36Months,
			sum(award_FPAwarded_PromoWinner_last24Months ) as award_FPAwarded_PromoWinner_last24Months,
			sum(award_FPAwarded_PromoWinner_last18Months ) as award_FPAwarded_PromoWinner_last18Months,
			sum(award_FPAwarded_PromoWinner_last12Months ) as award_FPAwarded_PromoWinner_last12Months,
			sum(award_FPAwarded_PromoWinner_last9Months ) as award_FPAwarded_PromoWinner_last9Months,
			sum(award_FPAwarded_PromoWinner_last6Months ) as award_FPAwarded_PromoWinner_last6Months,
			sum(award_FPAwarded_PromoWinner_last3Months ) as award_FPAwarded_PromoWinner_last3Months,
			sum(award_FPAwarded_PromoWinner_Last4Months ) as award_FPAwarded_PromoWinner_Last4Months,
			sum(award_FPAwarded_PromoWinner_Last2Months ) as award_FPAwarded_PromoWinner_Last2Months,
			sum(award_FPAwarded_PromoWinner_lastMonth ) as award_FPAwarded_PromoWinner_lastMonth,
			sum(award_FPAwarded_PromoWinner_3MonthLGD ) as award_FPAwarded_PromoWinner_3MonthLGD,

			sum(Award_Cash_Total_YTD ) as Award_Cash_Total_YTD,
			sum(Award_Cash_Total_QTD ) as Award_Cash_Total_QTD,
			sum(Award_Cash_Total_Last36Months ) as Award_Cash_Total_Last36Months,
			sum(Award_Cash_Total_last24Months ) as Award_Cash_Total_last24Months,
			sum(Award_Cash_Total_last18Months ) as Award_Cash_Total_last18Months,
			sum(Award_Cash_Total_last12Months ) as Award_Cash_Total_last12Months,
			sum(Award_Cash_Total_last9Months ) as Award_Cash_Total_last9Months,
			sum(Award_Cash_Total_last6Months ) as Award_Cash_Total_last6Months,
			sum(Award_Cash_Total_last3Months ) as Award_Cash_Total_last3Months,
			sum(Award_Cash_Total_Last4Months ) as Award_Cash_Total_Last4Months,
			sum(Award_Cash_Total_Last2Months ) as Award_Cash_Total_Last2Months,
			sum(Award_Cash_Total_lastMonth ) as Award_Cash_Total_lastMonth,
			sum(Award_Cash_Total_3MonthLGD ) as Award_Cash_Total_3MonthLGD,

			sum(award_Cash_PromoWinner_YTD ) as award_Cash_PromoWinner_YTD,
			sum(award_Cash_PromoWinner_QTD ) as award_Cash_PromoWinner_QTD,
			sum(award_Cash_PromoWinner_Last36Months ) as award_Cash_PromoWinner_Last36Months,
			sum(award_Cash_PromoWinner_last24Months ) as award_Cash_PromoWinner_last24Months,
			sum(award_Cash_PromoWinner_last18Months ) as award_Cash_PromoWinner_last18Months,
			sum(award_Cash_PromoWinner_last12Months ) as award_Cash_PromoWinner_last12Months,
			sum(award_Cash_PromoWinner_last9Months ) as award_Cash_PromoWinner_last9Months,
			sum(award_Cash_PromoWinner_last6Months ) as award_Cash_PromoWinner_last6Months,
			sum(award_Cash_PromoWinner_last3Months ) as award_Cash_PromoWinner_last3Months,
			sum(award_Cash_PromoWinner_Last4Months ) as award_Cash_PromoWinner_Last4Months,
			sum(award_Cash_PromoWinner_Last2Months ) as award_Cash_PromoWinner_Last2Months,
			sum(award_Cash_PromoWinner_lastMonth ) as award_Cash_PromoWinner_lastMonth,
			sum(award_Cash_PromoWinner_3MonthLGD ) as award_Cash_PromoWinner_3MonthLGD,

			sum(award_PromoChipsUsed_Total_YTD ) as award_PromoChipsUsed_Total_YTD,
			sum(award_PromoChipsUsed_Total_QTD ) as award_PromoChipsUsed_Total_QTD,
			sum(award_PromoChipsUsed_Total_Last36Months ) as award_PromoChipsUsed_Total_Last36Months,
			sum(award_PromoChipsUsed_Total_last24Months ) as award_PromoChipsUsed_Total_last24Months,
			sum(award_PromoChipsUsed_Total_last18Months ) as award_PromoChipsUsed_Total_last18Months,
			sum(award_PromoChipsUsed_Total_last12Months ) as award_PromoChipsUsed_Total_last12Months,
			sum(award_PromoChipsUsed_Total_last9Months ) as award_PromoChipsUsed_Total_last9Months,
			sum(award_PromoChipsUsed_Total_last6Months ) as award_PromoChipsUsed_Total_last6Months,
			sum(award_PromoChipsUsed_Total_last3Months ) as award_PromoChipsUsed_Total_last3Months,
			sum(award_PromoChipsUsed_Total_Last4Months ) as award_PromoChipsUsed_Total_Last4Months,
			sum(award_PromoChipsUsed_Total_Last2Months ) as award_PromoChipsUsed_Total_Last2Months,
			sum(award_PromoChipsUsed_Total_lastMonth ) as award_PromoChipsUsed_Total_lastMonth,
			sum(award_PromoChipsUsed_Total_3MonthLGD ) as award_PromoChipsUsed_Total_3MonthLGD,
			
			sum(award_PromoChipUsed_ServiceRecovery_YTD ) as award_PromoChipUsed_ServiceRecovery_YTD,
			sum(award_PromoChipUsed_ServiceRecovery_QTD ) as award_PromoChipUsed_ServiceRecovery_QTD,
			sum(award_PromoChipUsed_ServiceRecovery_Last36Months ) as award_PromoChipUsed_ServiceRecovery_Last36Months,
			sum(award_PromoChipUsed_ServiceRecovery_last24Months ) as award_PromoChipUsed_ServiceRecovery_last24Months,
			sum(award_PromoChipUsed_ServiceRecovery_last18Months ) as award_PromoChipUsed_ServiceRecovery_last18Months,
			sum(award_PromoChipUsed_ServiceRecovery_last12Months ) as award_PromoChipUsed_ServiceRecovery_last12Months,
			sum(award_PromoChipUsed_ServiceRecovery_last9Months ) as award_PromoChipUsed_ServiceRecovery_last9Months,
			sum(award_PromoChipUsed_ServiceRecovery_last6Months ) as award_PromoChipUsed_ServiceRecovery_last6Months,
			sum(award_PromoChipUsed_ServiceRecovery_last3Months ) as award_PromoChipUsed_ServiceRecovery_last3Months,
			sum(award_PromoChipUsed_ServiceRecovery_Last4Months ) as award_PromoChipUsed_ServiceRecovery_Last4Months,
			sum(award_PromoChipUsed_ServiceRecovery_Last2Months ) as award_PromoChipUsed_ServiceRecovery_Last2Months,
			sum(award_PromoChipUsed_ServiceRecovery_lastMonth ) as award_PromoChipUsed_ServiceRecovery_lastMonth,
			sum(award_PromoChipUsed_ServiceRecovery_3MonthLGD ) as award_PromoChipUsed_ServiceRecovery_3MonthLGD,

			sum(award_PromoChipUsed_PromoWinner_YTD ) as award_PromoChipUsed_PromoWinner_YTD,
			sum(award_PromoChipUsed_PromoWinner_QTD ) as award_PromoChipUsed_PromoWinner_QTD,
			sum(award_PromoChipUsed_PromoWinner_Last36Months ) as award_PromoChipUsed_PromoWinner_Last36Months,
			sum(award_PromoChipUsed_PromoWinner_last24Months ) as award_PromoChipUsed_PromoWinner_last24Months,
			sum(award_PromoChipUsed_PromoWinner_last18Months ) as award_PromoChipUsed_PromoWinner_last18Months,
			sum(award_PromoChipUsed_PromoWinner_last12Months ) as award_PromoChipUsed_PromoWinner_last12Months,
			sum(award_PromoChipUsed_PromoWinner_last9Months ) as award_PromoChipUsed_PromoWinner_last9Months,
			sum(award_PromoChipUsed_PromoWinner_last6Months ) as award_PromoChipUsed_PromoWinner_last6Months,
			sum(award_PromoChipUsed_PromoWinner_last3Months ) as award_PromoChipUsed_PromoWinner_last3Months,
			sum(award_PromoChipUsed_PromoWinner_Last4Months ) as award_PromoChipUsed_PromoWinner_Last4Months,
			sum(award_PromoChipUsed_PromoWinner_Last2Months ) as award_PromoChipUsed_PromoWinner_Last2Months,
			sum(award_PromoChipUsed_PromoWinner_lastMonth ) as award_PromoChipUsed_PromoWinner_lastMonth,
			sum(award_PromoChipUsed_PromoWinner_3MonthLGD ) as award_PromoChipUsed_PromoWinner_3MonthLGD,

			sum(award_Comp_Total_NoHotel_YTD ) as award_Comp_Total_NoHotel_YTD,
			sum(award_Comp_Total_NoHotel_QTD ) as award_Comp_Total_NoHotel_QTD,
			sum(award_Comp_Total_NoHotel_Last36Months ) as award_Comp_Total_NoHotel_Last36Months,
			sum(award_Comp_Total_NoHotel_last24Months ) as award_Comp_Total_NoHotel_last24Months,
			sum(award_Comp_Total_NoHotel_last18Months ) as award_Comp_Total_NoHotel_last18Months,
			sum(award_Comp_Total_NoHotel_last12Months ) as award_Comp_Total_NoHotel_last12Months,
			sum(award_Comp_Total_NoHotel_last9Months ) as award_Comp_Total_NoHotel_last9Months,
			sum(award_Comp_Total_NoHotel_last6Months ) as award_Comp_Total_NoHotel_last6Months,
			sum(award_Comp_Total_NoHotel_last3Months ) as award_Comp_Total_NoHotel_last3Months,
			sum(award_Comp_Total_NoHotel_Last4Months ) as award_Comp_Total_NoHotel_Last4Months,
			sum(award_Comp_Total_NoHotel_Last2Months ) as award_Comp_Total_NoHotel_Last2Months,
			sum(award_Comp_Total_NoHotel_lastMonth ) as award_Comp_Total_NoHotel_lastMonth,
			sum(award_Comp_Total_NoHotel_3MonthLGD ) as award_Comp_Total_NoHotel_3MonthLGD,

			sum(award_Comp_ServiceRecovery_YTD ) as award_Comp_ServiceRecovery_YTD ,
			sum(award_Comp_ServiceRecovery_QTD ) as award_Comp_ServiceRecovery_QTD,
			sum(award_Comp_ServiceRecovery_Last36Months ) as award_Comp_ServiceRecovery_Last36Months,
			sum(award_Comp_ServiceRecovery_last24Months ) as award_Comp_ServiceRecovery_last24Months,
			sum(award_Comp_ServiceRecovery_last18Months ) as award_Comp_ServiceRecovery_last18Months,
			sum(award_Comp_ServiceRecovery_last12Months ) as award_Comp_ServiceRecovery_last12Months,
			sum(award_Comp_ServiceRecovery_last9Months ) as award_Comp_ServiceRecovery_last9Months,
			sum(award_Comp_ServiceRecovery_last6Months ) as award_Comp_ServiceRecovery_last6Months,
			sum(award_Comp_ServiceRecovery_last3Months ) as award_Comp_ServiceRecovery_last3Months,
			sum(award_Comp_ServiceRecovery_Last4Months ) as award_Comp_ServiceRecovery_Last4Months,
			sum(award_Comp_ServiceRecovery_Last2Months ) as award_Comp_ServiceRecovery_Last2Months,
			sum(award_Comp_ServiceRecovery_lastMonth ) as award_Comp_ServiceRecovery_lastMonth,
			sum(award_Comp_ServiceRecovery_3MonthLGD ) as award_Comp_ServiceRecovery_3MonthLGD,

			sum(award_FB_Benefit_YTD ) as award_FB_Benefit_YTD,
			sum(award_FB_Benefit_QTD ) as award_FB_Benefit_QTD,
			sum(award_FB_Benefit_Last36Months ) as award_FB_Benefit_Last36Months,
			sum(award_FB_Benefit_last24Months ) as award_FB_Benefit_last24Months,
			sum(award_FB_Benefit_last18Months ) as award_FB_Benefit_last18Months,
			sum(award_FB_Benefit_last12Months ) as award_FB_Benefit_last12Months,
			sum(award_FB_Benefit_last9Months ) as award_FB_Benefit_last9Months,
			sum(award_FB_Benefit_last6Months ) as award_FB_Benefit_last6Months,
			sum(award_FB_Benefit_last3Months ) as award_FB_Benefit_last3Months,
			sum(award_FB_Benefit_Last4Months ) as award_FB_Benefit_Last4Months,
			sum(award_FB_Benefit_Last2Months ) as award_FB_Benefit_Last2Months,
			sum(award_FB_Benefit_lastMonth ) as award_FB_Benefit_lastMonth,
			sum(award_FB_Benefit_3MonthLGD ) as award_FB_Benefit_3MonthLGD,

			sum(award_FB_HostDine_YTD ) as award_FB_HostDine_YTD,
			sum(award_FB_HostDine_QTD ) as award_FB_HostDine_QTD,
			sum(award_FB_HostDine_Last36Months ) as award_FB_HostDine_Last36Months,
			sum(award_FB_HostDine_last24Months ) as award_FB_HostDine_last24Months,
			sum(award_FB_HostDine_last18Months ) as award_FB_HostDine_last18Months,
			sum(award_FB_HostDine_last12Months ) as award_FB_HostDine_last12Months,
			sum(award_FB_HostDine_last9Months ) as award_FB_HostDine_last9Months,
			sum(award_FB_HostDine_last6Months ) as award_FB_HostDine_last6Months,
			sum(award_FB_HostDine_last3Months ) as award_FB_HostDine_last3Months,
			sum(award_FB_HostDine_Last4Months ) as award_FB_HostDine_Last4Months,
			sum(award_FB_HostDine_Last2Months ) as award_FB_HostDine_Last2Months,
			sum(award_FB_HostDine_lastMonth ) as award_FB_HostDine_lastMonth,
			sum(award_FB_HostDine_3MonthLGD ) as award_FB_HostDine_3MonthLGD

	into #AwardsSum
	from #AwardsExtract
	group by UniqueKey



--
-- These variables are specific metric needed in marketing campaigns
--

drop table if exists #AwardsSum2

select
	 aws.UniqueKey

	/*Daily profitability
	,(award_FPUsed - award_FPAwarded_ServiceRecovery - award_FPAwarded_PromoWinner ) 
		+ (Award_Cash_Total - award_Cash_PromoWinner ) 
		+ (award_PromoChipsUsed_Total - award_PromoChipUsed_ServiceRecovery - award_PromoChipUsed_PromoWinner )
		+ (award_Comp_Total_NoHotel - award_Comp_ServiceRecovery - award_FB_Benefit - award_FB_HostDine) as dailyProfitability 
	*/

	,MME.dailyWorth_YTD - ((award_FPUsed_YTD - award_FPAwarded_ServiceRecovery_YTD - award_FPAwarded_PromoWinner_YTD ) 
		+ (Award_Cash_Total_YTD - award_Cash_PromoWinner_YTD ) 
		+ (award_PromoChipsUsed_Total_YTD - award_PromoChipUsed_ServiceRecovery_YTD - award_PromoChipUsed_PromoWinner_YTD )
		+ (award_Comp_Total_NoHotel_YTD - award_Comp_ServiceRecovery_YTD - award_FB_Benefit_YTD - award_FB_HostDine_YTD)) as dailyProfitability_YTD 

	,MME.dailyWorth_QTD - ((award_FPUsed_QTD - award_FPAwarded_ServiceRecovery_QTD - award_FPAwarded_PromoWinner_QTD ) 
		+ (Award_Cash_Total_QTD - award_Cash_PromoWinner_QTD ) 
		+ (award_PromoChipsUsed_Total_QTD - award_PromoChipUsed_ServiceRecovery_QTD - award_PromoChipUsed_PromoWinner_QTD )
		+ (award_Comp_Total_NoHotel_QTD - award_Comp_ServiceRecovery_QTD - award_FB_Benefit_QTD - award_FB_HostDine_QTD)) as dailyProfitability_QTD 

	,MME.dailyWorth_Last36Months - ((award_FPUsed_Last36Months - award_FPAwarded_ServiceRecovery_Last36Months - award_FPAwarded_PromoWinner_Last36Months ) 
		+ (Award_Cash_Total_Last36Months - award_Cash_PromoWinner_Last36Months ) 
		+ (award_PromoChipsUsed_Total_Last36Months - award_PromoChipUsed_ServiceRecovery_Last36Months - award_PromoChipUsed_PromoWinner_Last36Months )
		+ (award_Comp_Total_NoHotel_Last36Months - award_Comp_ServiceRecovery_Last36Months - award_FB_Benefit_Last36Months - award_FB_HostDine_Last36Months)) as dailyProfitability_Last36Months 

	,MME.dailyWorth_last24Months - ((award_FPUsed_last24Months - award_FPAwarded_ServiceRecovery_last24Months - award_FPAwarded_PromoWinner_last24Months ) 
		+ (Award_Cash_Total_last24Months - award_Cash_PromoWinner_last24Months ) 
		+ (award_PromoChipsUsed_Total_last24Months - award_PromoChipUsed_ServiceRecovery_last24Months - award_PromoChipUsed_PromoWinner_last24Months )
		+ (award_Comp_Total_NoHotel_last24Months - award_Comp_ServiceRecovery_last24Months - award_FB_Benefit_last24Months - award_FB_HostDine_last24Months)) as dailyProfitability_last24Months

	,MME.dailyWorth_last18Months - ((award_FPUsed_last18Months - award_FPAwarded_ServiceRecovery_last18Months - award_FPAwarded_PromoWinner_last18Months ) 
		+ (Award_Cash_Total_last18Months - award_Cash_PromoWinner_last18Months ) 
		+ (award_PromoChipsUsed_Total_last18Months - award_PromoChipUsed_ServiceRecovery_last18Months - award_PromoChipUsed_PromoWinner_last18Months )
		+ (award_Comp_Total_NoHotel_last18Months - award_Comp_ServiceRecovery_last18Months - award_FB_Benefit_last18Months - award_FB_HostDine_last18Months)) as dailyProfitability_last18Months 

	,MME.dailyWorth_last12Months - ((award_FPUsed_last12Months - award_FPAwarded_ServiceRecovery_last12Months - award_FPAwarded_PromoWinner_last12Months ) 
		+ (Award_Cash_Total_last12Months - award_Cash_PromoWinner_last12Months ) 
		+ (award_PromoChipsUsed_Total_last12Months - award_PromoChipUsed_ServiceRecovery_last12Months - award_PromoChipUsed_PromoWinner_last12Months )
		+ (award_Comp_Total_NoHotel_last12Months - award_Comp_ServiceRecovery_last12Months - award_FB_Benefit_last12Months - award_FB_HostDine_last12Months)) as dailyProfitability_last12Months 

	,MME.dailyWorth_last9Months - ((award_FPUsed_last9Months - award_FPAwarded_ServiceRecovery_last9Months - award_FPAwarded_PromoWinner_last9Months ) 
		+ (Award_Cash_Total_last9Months - award_Cash_PromoWinner_last9Months ) 
		+ (award_PromoChipsUsed_Total_last9Months - award_PromoChipUsed_ServiceRecovery_last9Months - award_PromoChipUsed_PromoWinner_last9Months )
		+ (award_Comp_Total_NoHotel_last9Months - award_Comp_ServiceRecovery_last9Months - award_FB_Benefit_last9Months - award_FB_HostDine_last9Months)) as dailyProfitability_last9Months 

	,MME.dailyWorth_last6Months - ((award_FPUsed_last6Months - award_FPAwarded_ServiceRecovery_last6Months - award_FPAwarded_PromoWinner_last6Months ) 
		+ (Award_Cash_Total_last6Months - award_Cash_PromoWinner_last6Months ) 
		+ (award_PromoChipsUsed_Total_last6Months - award_PromoChipUsed_ServiceRecovery_last6Months - award_PromoChipUsed_PromoWinner_last6Months )
		+ (award_Comp_Total_NoHotel_last6Months - award_Comp_ServiceRecovery_last6Months - award_FB_Benefit_last6Months - award_FB_HostDine_last6Months)) as dailyProfitability_last6Months 

	,MME.dailyWorth_Last4Months - ((award_FPUsed_Last4Months - award_FPAwarded_ServiceRecovery_Last4Months - award_FPAwarded_PromoWinner_Last4Months ) 
		+ (Award_Cash_Total_Last4Months - award_Cash_PromoWinner_Last4Months ) 
		+ (award_PromoChipsUsed_Total_Last4Months - award_PromoChipUsed_ServiceRecovery_Last4Months - award_PromoChipUsed_PromoWinner_Last4Months )
		+ (award_Comp_Total_NoHotel_Last4Months - award_Comp_ServiceRecovery_Last4Months - award_FB_Benefit_Last4Months - award_FB_HostDine_Last4Months)) as dailyProfitability_Last4Months

	,MME.dailyWorth_last3Months - ((award_FPUsed_last3Months - award_FPAwarded_ServiceRecovery_last3Months - award_FPAwarded_PromoWinner_last3Months ) 
		+ (Award_Cash_Total_last3Months - award_Cash_PromoWinner_last3Months ) 
		+ (award_PromoChipsUsed_Total_last3Months - award_PromoChipUsed_ServiceRecovery_last3Months - award_PromoChipUsed_PromoWinner_last3Months )
		+ (award_Comp_Total_NoHotel_last3Months - award_Comp_ServiceRecovery_last3Months - award_FB_Benefit_last3Months - award_FB_HostDine_last3Months)) as dailyProfitability_last3Months 

	,MME.dailyWorth_Last2Months - ((award_FPUsed_Last2Months - award_FPAwarded_ServiceRecovery_Last2Months - award_FPAwarded_PromoWinner_Last2Months ) 
		+ (Award_Cash_Total_Last2Months - award_Cash_PromoWinner_Last2Months ) 
		+ (award_PromoChipsUsed_Total_Last2Months - award_PromoChipUsed_ServiceRecovery_Last2Months - award_PromoChipUsed_PromoWinner_Last2Months )
		+ (award_Comp_Total_NoHotel_Last2Months - award_Comp_ServiceRecovery_Last2Months - award_FB_Benefit_Last2Months - award_FB_HostDine_Last2Months)) as dailyProfitability_Last2Months 

	,MME.dailyWorth_lastMonth - ((award_FPUsed_lastMonth - award_FPAwarded_ServiceRecovery_lastMonth - award_FPAwarded_PromoWinner_lastMonth) 
		+ (Award_Cash_Total_lastMonth - award_Cash_PromoWinner_lastMonth ) 
		+ (award_PromoChipsUsed_Total_lastMonth - award_PromoChipUsed_ServiceRecovery_lastMonth - award_PromoChipUsed_PromoWinner_lastMonth )
		+ (award_Comp_Total_NoHotel_lastMonth - award_Comp_ServiceRecovery_lastMonth - award_FB_Benefit_lastMonth - award_FB_HostDine_lastMonth)) as dailyProfitability_lastMonth

	,MME.dailyWorth_3MonthLGD - ((award_FPUsed_3MonthLGD - award_FPAwarded_ServiceRecovery_3MonthLGD - award_FPAwarded_PromoWinner_3MonthLGD ) 
		+ (Award_Cash_Total_3MonthLGD - award_Cash_PromoWinner_3MonthLGD ) 
		+ (award_PromoChipsUsed_Total_3MonthLGD - award_PromoChipUsed_ServiceRecovery_3MonthLGD - award_PromoChipUsed_PromoWinner_3MonthLGD )
		+ (award_Comp_Total_NoHotel_3MonthLGD - award_Comp_ServiceRecovery_3MonthLGD - award_FB_Benefit_3MonthLGD - award_FB_HostDine_3MonthLGD)) as dailyProfitability_3MonthLGD
	

	/*Daily NetFP
	,(award_FPUsed - award_FPAwarded_ServiceRecovery - award_FPAwarded_PromoWinner ) 
		+ (Award_Cash_Total - award_Cash_PromoWinner ) 
		+ (award_PromoChipsUsed_Total - award_PromoChipUsed_ServiceRecovery - award_PromoChipUsed_PromoWinner )
	*/

	,(award_FPUsed_YTD - award_FPAwarded_ServiceRecovery_YTD - award_FPAwarded_PromoWinner_YTD ) 
		+ (Award_Cash_Total_YTD - award_Cash_PromoWinner_YTD ) 
		+ (award_PromoChipsUsed_Total_YTD - award_PromoChipUsed_ServiceRecovery_YTD - award_PromoChipUsed_PromoWinner_YTD )  as NetFP_YTD

	,(award_FPUsed_QTD - award_FPAwarded_ServiceRecovery_QTD - award_FPAwarded_PromoWinner_QTD ) 
		+ (Award_Cash_Total_QTD - award_Cash_PromoWinner_QTD ) 
		+ (award_PromoChipsUsed_Total_QTD - award_PromoChipUsed_ServiceRecovery_QTD - award_PromoChipUsed_PromoWinner_QTD )
		+ (award_Comp_Total_NoHotel_QTD - award_Comp_ServiceRecovery_QTD - award_FB_Benefit_QTD - award_FB_HostDine_QTD) as NetFP_QTD 

	,(award_FPUsed_Last36Months - award_FPAwarded_ServiceRecovery_Last36Months - award_FPAwarded_PromoWinner_Last36Months ) 
		+ (Award_Cash_Total_Last36Months - award_Cash_PromoWinner_Last36Months ) 
		+ (award_PromoChipsUsed_Total_Last36Months - award_PromoChipUsed_ServiceRecovery_Last36Months - award_PromoChipUsed_PromoWinner_Last36Months ) as NetFP_Last36Months 

	,(award_FPUsed_last24Months - award_FPAwarded_ServiceRecovery_last24Months - award_FPAwarded_PromoWinner_last24Months ) 
		+ (Award_Cash_Total_last24Months - award_Cash_PromoWinner_last24Months ) 
		+ (award_PromoChipsUsed_Total_last24Months - award_PromoChipUsed_ServiceRecovery_last24Months - award_PromoChipUsed_PromoWinner_last24Months ) as NetFP_last24Months

	,(award_FPUsed_last18Months - award_FPAwarded_ServiceRecovery_last18Months - award_FPAwarded_PromoWinner_last18Months ) 
		+ (Award_Cash_Total_last18Months - award_Cash_PromoWinner_last18Months ) 
		+ (award_PromoChipsUsed_Total_last18Months - award_PromoChipUsed_ServiceRecovery_last18Months - award_PromoChipUsed_PromoWinner_last18Months ) as NetFP_last18Months 

	,(award_FPUsed_last12Months - award_FPAwarded_ServiceRecovery_last12Months - award_FPAwarded_PromoWinner_last12Months ) 
		+ (Award_Cash_Total_last12Months - award_Cash_PromoWinner_last12Months ) 
		+ (award_PromoChipsUsed_Total_last12Months - award_PromoChipUsed_ServiceRecovery_last12Months - award_PromoChipUsed_PromoWinner_last12Months ) as NetFP_last12Months 

	,(award_FPUsed_last9Months - award_FPAwarded_ServiceRecovery_last9Months - award_FPAwarded_PromoWinner_last9Months ) 
		+ (Award_Cash_Total_last9Months - award_Cash_PromoWinner_last9Months ) 
		+ (award_PromoChipsUsed_Total_last9Months - award_PromoChipUsed_ServiceRecovery_last9Months - award_PromoChipUsed_PromoWinner_last9Months ) as NetFP_last9Months 

	,(award_FPUsed_last6Months - award_FPAwarded_ServiceRecovery_last6Months - award_FPAwarded_PromoWinner_last6Months ) 
		+ (Award_Cash_Total_last6Months - award_Cash_PromoWinner_last6Months ) 
		+ (award_PromoChipsUsed_Total_last6Months - award_PromoChipUsed_ServiceRecovery_last6Months - award_PromoChipUsed_PromoWinner_last6Months )
		+ (award_Comp_Total_NoHotel_last6Months - award_Comp_ServiceRecovery_last6Months - award_FB_Benefit_last6Months - award_FB_HostDine_last6Months) as NetFP_last6Months 

	,(award_FPUsed_Last4Months - award_FPAwarded_ServiceRecovery_Last4Months - award_FPAwarded_PromoWinner_Last4Months ) 
		+ (Award_Cash_Total_Last4Months - award_Cash_PromoWinner_Last4Months ) 
		+ (award_PromoChipsUsed_Total_Last4Months - award_PromoChipUsed_ServiceRecovery_Last4Months - award_PromoChipUsed_PromoWinner_Last4Months ) as NetFP_Last4Months

	,(award_FPUsed_last3Months - award_FPAwarded_ServiceRecovery_last3Months - award_FPAwarded_PromoWinner_last3Months ) 
		+ (Award_Cash_Total_last3Months - award_Cash_PromoWinner_last3Months ) 
		+ (award_PromoChipsUsed_Total_last3Months - award_PromoChipUsed_ServiceRecovery_last3Months - award_PromoChipUsed_PromoWinner_last3Months ) as NetFP_last3Months 

	,(award_FPUsed_Last2Months - award_FPAwarded_ServiceRecovery_Last2Months - award_FPAwarded_PromoWinner_Last2Months ) 
		+ (Award_Cash_Total_Last2Months - award_Cash_PromoWinner_Last2Months ) 
		+ (award_PromoChipsUsed_Total_Last2Months - award_PromoChipUsed_ServiceRecovery_Last2Months - award_PromoChipUsed_PromoWinner_Last2Months ) as  NetFP_Last2Months 

	,(award_FPUsed_lastMonth - award_FPAwarded_ServiceRecovery_lastMonth - award_FPAwarded_PromoWinner_lastMonth) 
		+ (Award_Cash_Total_lastMonth - award_Cash_PromoWinner_lastMonth ) 
		+ (award_PromoChipsUsed_Total_lastMonth - award_PromoChipUsed_ServiceRecovery_lastMonth - award_PromoChipUsed_PromoWinner_lastMonth ) as NetFP_lastMonth

	,(award_FPUsed_3MonthLGD - award_FPAwarded_ServiceRecovery_3MonthLGD - award_FPAwarded_PromoWinner_3MonthLGD ) 
		+ (Award_Cash_Total_3MonthLGD - award_Cash_PromoWinner_3MonthLGD ) 
		+ (award_PromoChipsUsed_Total_3MonthLGD - award_PromoChipUsed_ServiceRecovery_3MonthLGD - award_PromoChipUsed_PromoWinner_3MonthLGD ) as NetFP_3MonthLGD

	,award_FPUsed_YTD
	,award_FPUsed_QTD
	,award_FPUsed_Last36Months
	,award_FPUsed_last24Months
	,award_FPUsed_last18Months
	,award_FPUsed_last12Months
	,award_FPUsed_last9Months
	,award_FPUsed_last6Months
	,award_FPUsed_last3Months
	,award_FPUsed_Last4Months
	,award_FPUsed_Last2Months
	,award_FPUsed_lastMonth
	,award_FPUsed_3MonthLGD

 into #AwardsSum2
 from #AwardsSum aws
 right join (select Uniquekey,
				dailyWorth_YTD,
				dailyWorth_QTD,
				dailyWorth_Last36Months,
				dailyWorth_last24Months,
				dailyWorth_last18Months,
				dailyWorth_last12Months,
				dailyWorth_last9Months,
				dailyWorth_last6Months,
				dailyWorth_Last4Months,
				dailyWorth_last3Months,
				dailyWorth_Last2Months,
				dailyWorth_lastMonth,
				dailyWorth_3MonthLGD 
				from #SummedMarketingMetricsEXT) MME
	on aws.UniqueKey = MME.UniqueKey

	--drop table if exists dbo.iq_marketing_metrics_tmp_AwardsSum2

	--select * into dbo.iq_marketing_metrics_tmp_AwardsSum2 from #AwardsSum2
 --select top 1000 * from #AwardsSum2 order by UniqueKey
 --select top 1000 * from #SummedMarketingMetricsEXT order by UniqueKey

 drop table if exists #UniqueDays


 select
	coalesce (base.UniqueKey, rate.uniqueKey, awd.uniqueKey) as Uniquekey

	/*Template
	,case when gamingDays_YTD <> 0 then cast(_YTD/gamingDays_YTD as money) else null end as _YTD
	,case when gamingDays_QTD <> 0 then cast(_QTD/gamingDays_QTD as money) else null end as _QTD
	,case when gamingDays_last36Months <> 0 then cast(_last36Months/gamingDays_last36Months as money) else null end as _last36Months
	,case when gamingDays_last24Months <> 0 then cast(_last24Months/gamingDays_last24Months as money) else null end as _last24Months
	,case when gamingDays_last18Months <> 0 then cast(_last18Months/gamingDays_last18Months as money) else null end as _last18Months
	,case when gamingDays_last12Months <> 0 then cast(_last12Months/gamingDays_last12Months as money) else null end as _last12Months
	,case when gamingDays_last9Months <> 0 then cast(_last9Months/gamingDays_last9Months as money) else null end as _last9Months
	,case when gamingDays_last6Months <> 0 then cast(_last6Months/gamingDays_last6Months as money) else null end as _last6Months
	,case when gamingDays_last4Months <> 0 then cast(_last4Months/gamingDays_last4Months as money) else null end as _last4Months
	,case when gamingDays_last3Months <> 0 then cast(_last3Months/gamingDays_last3Months as money) else null end as _last3Months
	,case when gamingDays_last2Months <> 0 then cast(_last2Months/gamingDays_last2Months as money) else null end as _last2Months
	,case when gamingDays_lastMonth <> 0 then cast(_lastMonth/gamingDays_lastMonth as money) else null end as _lastMonth
	,case when gamingDays_3MonthLGD <> 0 then cast(_3MonthLGD/gamingDays_3MonthLGD as money) else null end as _3MonthLGD
	*/

	--ADP
	,case when gamingDays_YTD <> 0 then cast(dailyProfitability_YTD/gamingDays_YTD as money) else null end as ADP_YTD
	,case when gamingDays_QTD <> 0 then cast(dailyProfitability_QTD/gamingDays_QTD as money) else null end as ADP_QTD
	,case when gamingDays_last36Months <> 0 then cast(dailyProfitability_last36Months/gamingDays_last36Months as money) else null end as ADP_last36Months
	,case when gamingDays_last24Months <> 0 then cast(dailyProfitability_last24Months/gamingDays_last24Months as money) else null end as ADP_last24Months
	,case when gamingDays_last18Months <> 0 then cast(dailyProfitability_last18Months/gamingDays_last18Months as money) else null end as ADP_last18Months
	,case when gamingDays_last12Months <> 0 then cast(dailyProfitability_last12Months/gamingDays_last12Months as money) else null end as ADP_last12Months
	,case when gamingDays_last9Months <> 0 then cast(dailyProfitability_last9Months/gamingDays_last9Months as money) else null end as ADP_last9Months
	,case when gamingDays_last6Months <> 0 then cast(dailyProfitability_last6Months/gamingDays_last6Months as money) else null end as ADP_last6Months
	,case when gamingDays_last4Months <> 0 then cast(dailyProfitability_last4Months/gamingDays_last4Months as money) else null end as ADP_last4Months
	,case when gamingDays_last3Months <> 0 then cast(dailyProfitability_last3Months/gamingDays_last3Months as money) else null end as ADP_last3Months
	,case when gamingDays_last2Months <> 0 then cast(dailyProfitability_last2Months/gamingDays_last2Months as money) else null end as ADP_last2Months
	,case when gamingDays_lastMonth <> 0 then cast(dailyProfitability_lastMonth/gamingDays_lastMonth as money) else null end as ADP_lastMonth
	,case when gamingDays_3MonthLGD <> 0 then cast(dailyProfitability_3MonthLGD/gamingDays_3MonthLGD as money) else null end as ADP_3MonthLGD

	--ADT GrossFP
	,case when gamingDays_YTD <> 0 then cast(totalTheo_YTD/gamingDays_YTD as money) else null end as ADT_GrossFP_YTD
	,case when gamingDays_QTD <> 0 then cast(totalTheo_QTD/gamingDays_QTD as money) else null end as ADT_GrossFP_QTD
	,case when gamingDays_last36Months <> 0 then cast(totalTheo_last36Months/gamingDays_last36Months as money) else null end as ADT_GrossFP_last36Months
	,case when gamingDays_last24Months <> 0 then cast(totalTheo_last24Months/gamingDays_last24Months as money) else null end as ADT_GrossFP_last24Months
	,case when gamingDays_last18Months <> 0 then cast(totalTheo_last18Months/gamingDays_last18Months as money) else null end as ADT_GrossFP_last18Months
	,case when gamingDays_last12Months <> 0 then cast(totalTheo_last12Months/gamingDays_last12Months as money) else null end as ADT_GrossFP_last12Months
	,case when gamingDays_last9Months <> 0 then cast(totalTheo_last9Months/gamingDays_last9Months as money) else null end as ADT_GrossFP_last9Months
	,case when gamingDays_last6Months <> 0 then cast(totalTheo_last6Months/gamingDays_last6Months as money) else null end as ADT_GrossFP_last6Months
	,case when gamingDays_last4Months <> 0 then cast(totalTheo_last4Months/gamingDays_last4Months as money) else null end as ADT_GrossFP_last4Months
	,case when gamingDays_last3Months <> 0 then cast(totalTheo_last3Months/gamingDays_last3Months as money) else null end as ADT_GrossFP_last3Months
	,case when gamingDays_last2Months <> 0 then cast(totalTheo_last2Months/gamingDays_last2Months as money) else null end as ADT_GrossFP_last2Months
	,case when gamingDays_lastMonth <> 0 then cast(totalTheo_lastMonth/gamingDays_lastMonth as money) else null end as ADT_GrossFP_lastMonth
	,case when gamingDays_3MonthLGD <> 0 then cast(totalTheo_3MonthLGD/gamingDays_3MonthLGD as money) else null end as ADT_GrossFP_3MonthLGD

	--ADT NetFP	
	,case when gamingDays_YTD <> 0 then cast((totalTheo_YTD-isnull(NetFP_YTD,0))/gamingDays_YTD as money) else null end as ADT_NetFP_YTD
	,case when gamingDays_QTD <> 0 then cast((totalTheo_QTD-isnull(NetFP_QTD,0))/gamingDays_QTD as money) else null end as ADT_NetFP_QTD
	,case when gamingDays_last36Months <> 0 then cast((totalTheo_last36Months-isnull(NetFP_last36Months,0))/gamingDays_last36Months as money) else null end as ADT_NetFP_last36Months
	,case when gamingDays_last24Months <> 0 then cast((totalTheo_last24Months-isnull(NetFP_last24Months,0))/gamingDays_last24Months as money) else null end as ADT_NetFP_last24Months
	,case when gamingDays_last18Months <> 0 then cast((totalTheo_last18Months-isnull(NetFP_last18Months,0))/gamingDays_last18Months as money) else null end as ADT_NetFP_last18Months
	,case when gamingDays_last12Months <> 0 then cast((totalTheo_Last12Months-isnull(NetFP_last12Months,0))/gamingDays_last12Months as money) else null end as ADT_NetFP_last12Months
	,case when gamingDays_last9Months <> 0 then cast((totalTheo_Last9Months-isnull(NetFP_last9Months,0))/gamingDays_last9Months as money) else null end as ADT_NetFP_last9Months
	,case when gamingDays_last6Months <> 0 then cast((totalTheo_Last6months-isnull(NetFP_last6Months,0))/gamingDays_last6Months as money) else null end as ADT_NetFP_last6Months
	,case when gamingDays_last4Months <> 0 then cast((totalTheo_last4Months-isnull(NetFP_last4Months,0))/gamingDays_last4Months as money) else null end as ADT_NetFP_last4Months
	,case when gamingDays_last3Months <> 0 then cast((totalTheo_last3Months-isnull(NetFP_last3Months,0))/gamingDays_last3Months as money) else null end as ADT_NetFP_last3Months
	,case when gamingDays_last2Months <> 0 then cast((totalTheo_last2Months-isnull(NetFP_last2Months,0))/gamingDays_last2Months as money) else null end as ADT_NetFP_last2Months
	,case when gamingDays_lastMonth <> 0 then cast((totalTheo_lastMonth-isnull(NetFP_lastMonth,0))/gamingDays_lastMonth as money) else null end as ADT_NetFP_lastMonth
	,case when gamingDays_3MonthLGD <> 0 then cast((totalTheo_3MonthLGD-isnull(NetFP_3MonthLGD,0))/gamingDays_3MonthLGD as money) else null end as ADT_NetFP_3MonthLGD

	--DailyWorth
	,case when gamingDays_YTD <> 0 then cast(dailyWorth_YTD/gamingDays_YTD as money) else null end as ADW_GrossFP_YTD
	,case when gamingDays_QTD <> 0 then cast(dailyWorth_QTD/gamingDays_QTD as money) else null end as ADW_GrossFP_QTD
	,case when gamingDays_last36Months <> 0 then cast(DailyWorth_last36Months/gamingDays_last36Months as money) else null end as ADW_GrossFP_last36Months
	,case when gamingDays_last24Months <> 0 then cast(DailyWorth_last24Months/gamingDays_last24Months as money) else null end as ADW_GrossFP_last24Months
	,case when gamingDays_last18Months <> 0 then cast(DailyWorth_last18Months/gamingDays_last18Months as money) else null end as ADW_GrossFP_last18Months
	,case when gamingDays_last12Months <> 0 then cast(DailyWorth_last12Months/gamingDays_last12Months as money) else null end as ADW_GrossFP_last12Months
	,case when gamingDays_last9Months <> 0 then cast(DailyWorth_last9Months/gamingDays_last9Months as money) else null end as ADW_GrossFP_last9Months
	,case when gamingDays_last6Months <> 0 then cast(DailyWorth_last6Months/gamingDays_last6Months as money) else null end as ADW_GrossFP_last6Months
	,case when gamingDays_last4Months <> 0 then cast(DailyWorth_last4Months/gamingDays_last4Months as money) else null end as ADW_GrossFP_last4Months
	,case when gamingDays_last3Months <> 0 then cast(DailyWorth_last3Months/gamingDays_last3Months as money) else null end as ADW_GrossFP_last3Months
	,case when gamingDays_last2Months <> 0 then cast(DailyWorth_last2Months/gamingDays_last2Months as money) else null end as ADW_GrossFP_last2Months
	,case when gamingDays_lastMonth <> 0 then cast(DailyWorth_lastMonth/gamingDays_lastMonth as money) else null end as ADW_GrossFP_lastMonth
	,case when gamingDays_3MonthLGD <> 0 then cast(DailyWorth_3MonthLGD/gamingDays_3MonthLGD as money) else null end as ADW_GrossFP_3MonthLGD

	--DailyWorth NETFP
	,case when gamingDays_YTD <> 0 then cast((dailyWorth_YTD-isnull(NETFP_YTD,0))/gamingDays_YTD as money) else null end as ADW_NetFP_YTD
	,case when gamingDays_QTD <> 0 then cast((dailyWorth_QTD-isnull(NETFP_QTD,0))/gamingDays_QTD as money) else null end as ADW_NetFP_QTD
	,case when gamingDays_last36Months <> 0 then cast((dailyWorth_Last36Months-isnull(NETFP_last36Months,0))/gamingDays_last36Months as money) else null end as ADW_NetFP_last36Months
	,case when gamingDays_last24Months <> 0 then cast((dailyWorth_last24Months-isnull(NETFP_last24Months,0))/gamingDays_last24Months as money) else null end as ADW_NetFP_last24Months
	,case when gamingDays_last18Months <> 0 then cast((dailyWorth_last18Months-isnull(NetFP_last18Months,0))/gamingDays_last18Months as money) else null end as ADW_NetFP_last18Months
	,case when gamingDays_last12Months <> 0 then cast((dailyWorth_last12Months-isnull(NETFP_last12Months,0))/gamingDays_last12Months as money) else null end as ADW_NetFP_last12Months
	,case when gamingDays_last9Months <> 0 then cast((dailyWorth_last9Months-isnull(NETFP_last9Months,0))/gamingDays_last9Months as money) else null end as ADW_NetFP_last9Months
	,case when gamingDays_last6Months <> 0 then cast((dailyWorth_last6Months -isnull(NETFP_last6Months,0))/gamingDays_last6Months as money) else null end as ADW_NetFP_last6Months
	,case when gamingDays_last4Months <> 0 then cast((dailyWorth_last4Months -isnull(NETFP_last4Months,0) )/gamingDays_last4Months as money) else null end as ADW_NetFP_last4Months
	,case when gamingDays_last3Months <> 0 then cast((dailyWorth_last3Months-isnull(NETFP_last3Months,0))/gamingDays_last3Months as money) else null end as ADW_NetFP_last3Months
	,case when gamingDays_last2Months <> 0 then cast((dailyWorth_last2Months-isnull(NETFP_last2Months,0))/gamingDays_last2Months as money) else null end as ADW_NetFP_last2Months
	,case when gamingDays_lastMonth <> 0 then cast((dailyWorth_lastMonth-isnull(NETFP_lastMonth,0))/gamingDays_lastMonth as money) else null end as ADW_NetFP_lastMonth
	,case when gamingDays_3MonthLGD <> 0 then cast((dailyWorth_3MonthLGD-isnull(NETFP_3MonthLGD,0))/gamingDays_3MonthLGD as money) else null end as ADW_NetFP_3MonthLGD

	--AMP
	,case when MonthsPlayed_YTD <> 0 then cast(dailyProfitability_YTD/MonthsPlayed_YTD as money) else null end as AMP_YTD
	,case when MonthsPlayed_QTD <> 0 then cast(dailyProfitability_QTD/MonthsPlayed_QTD as money) else null end as AMP_QTD
	,case when MonthsPlayed_last36Months <> 0 then cast(dailyProfitability_last36Months/MonthsPlayed_last36Months as money) else null end as AMP_last36Months
	,case when MonthsPlayed_last24Months <> 0 then cast(dailyProfitability_last24Months/MonthsPlayed_last24Months as money) else null end as AMP_last24Months
	,case when MonthsPlayed_last18Months <> 0 then cast(dailyProfitability_last18Months/MonthsPlayed_last18Months as money) else null end as AMP_last18Months
	,case when MonthsPlayed_last12Months <> 0 then cast(dailyProfitability_last12Months/MonthsPlayed_last12Months as money) else null end as AMP_last12Months
	,case when MonthsPlayed_last9Months <> 0 then cast(dailyProfitability_last9Months/MonthsPlayed_last9Months as money) else null end as AMP_last9Months
	,case when MonthsPlayed_last6Months <> 0 then cast(dailyProfitability_last6Months/MonthsPlayed_last6Months as money) else null end as AMP_last6Months
	,case when MonthsPlayed_last4Months <> 0 then cast(dailyProfitability_last4Months/MonthsPlayed_last4Months as money) else null end as AMP_last4Months
	,case when MonthsPlayed_last3Months <> 0 then cast(dailyProfitability_last3Months/MonthsPlayed_last3Months as money) else null end as AMP_last3Months
	,case when MonthsPlayed_last2Months <> 0 then cast(dailyProfitability_last2Months/MonthsPlayed_last2Months as money) else null end as AMP_last2Months
	,case when MonthsPlayed_lastMonth <> 0 then cast(dailyProfitability_lastMonth/MonthsPlayed_lastMonth as money) else null end as AMP_lastMonth
	,case when MonthsPlayed_3MonthLGD <> 0 then cast(dailyProfitability_3MonthLGD/MonthsPlayed_3MonthLGD as money) else null end as AMP_3MonthLGD

	--AMT GrossFP
	,case when MonthsPlayed_YTD <> 0 then cast(totalTheo_YTD/MonthsPlayed_YTD as money) else null end as AMT_GrossFP_YTD
	,case when MonthsPlayed_QTD <> 0 then cast(totalTheo_QTD/MonthsPlayed_QTD as money) else null end as AMT_GrossFP_QTD
	,case when MonthsPlayed_last36Months <> 0 then cast(totalTheo_last36Months/MonthsPlayed_last36Months as money) else null end as AMT_GrossFP_last36Months
	,case when MonthsPlayed_last24Months <> 0 then cast(totalTheo_last24Months/MonthsPlayed_last24Months as money) else null end as AMT_GrossFP_last24Months
	,case when MonthsPlayed_last18Months <> 0 then cast(totalTheo_last18Months/MonthsPlayed_last18Months as money) else null end as AMT_GrossFP_last18Months
	,case when MonthsPlayed_last12Months <> 0 then cast(totalTheo_last12Months/MonthsPlayed_last12Months as money) else null end as AMT_GrossFP_last12Months
	,case when MonthsPlayed_last9Months <> 0 then cast(totalTheo_last9Months/MonthsPlayed_last9Months as money) else null end as AMT_GrossFP_last9Months
	,case when MonthsPlayed_last6Months <> 0 then cast(totalTheo_last6Months/MonthsPlayed_last6Months as money) else null end as AMT_GrossFP_last6Months
	,case when MonthsPlayed_last4Months <> 0 then cast(totalTheo_last4Months/MonthsPlayed_last4Months as money) else null end as AMT_GrossFP_last4Months
	,case when MonthsPlayed_last3Months <> 0 then cast(totalTheo_last3Months/MonthsPlayed_last3Months as money) else null end as AMT_GrossFP_last3Months
	,case when MonthsPlayed_last2Months <> 0 then cast(totalTheo_last2Months/MonthsPlayed_last2Months as money) else null end as AMT_GrossFP_last2Months
	,case when MonthsPlayed_lastMonth <> 0 then cast(totalTheo_lastMonth/MonthsPlayed_lastMonth as money) else null end as AMT_GrossFP_lastMonth
	,case when MonthsPlayed_3MonthLGD <> 0 then cast(totalTheo_3MonthLGD/MonthsPlayed_3MonthLGD as money) else null end as AMT_GrossFP_3MonthLGD

	--AMT NetFP	
	,case when MonthsPlayed_YTD <> 0 then cast((totalTheo_YTD-isnull(NetFP_YTD,0))/MonthsPlayed_YTD as money) else null end as AMT_NetFP_YTD
	,case when MonthsPlayed_QTD <> 0 then cast((totalTheo_QTD-isnull(NetFP_QTD,0))/MonthsPlayed_QTD as money) else null end as AMT_NetFP_QTD
	,case when MonthsPlayed_last36Months <> 0 then cast((totalTheo_last36Months-isnull(NetFP_last36Months,0))/MonthsPlayed_last36Months as money) else null end as AMT_NetFP_last36Months
	,case when MonthsPlayed_last24Months <> 0 then cast((totalTheo_last24Months-isnull(NetFP_last24Months,0))/MonthsPlayed_last24Months as money) else null end as AMT_NetFP_last24Months
	,case when MonthsPlayed_last18Months <> 0 then cast((totalTheo_last18Months-isnull(NetFP_last18Months,0))/MonthsPlayed_last18Months as money) else null end as AMT_NetFP_last18Months
	,case when MonthsPlayed_last12Months <> 0 then cast((totalTheo_Last12Months-isnull(NetFP_last12Months,0))/MonthsPlayed_last12Months as money) else null end as AMT_NetFP_last12Months
	,case when MonthsPlayed_last9Months <> 0 then cast((totalTheo_Last9Months-isnull(NetFP_last9Months,0))/MonthsPlayed_last9Months as money) else null end as AMT_NetFP_last9Months
	,case when MonthsPlayed_last6Months <> 0 then cast((totalTheo_Last6months-isnull(NetFP_last6Months,0))/MonthsPlayed_last6Months as money) else null end as AMT_NetFP_last6Months
	,case when MonthsPlayed_last4Months <> 0 then cast((totalTheo_last4Months-isnull(NetFP_last4Months,0))/MonthsPlayed_last4Months as money) else null end as AMT_NetFP_last4Months
	,case when MonthsPlayed_last3Months <> 0 then cast((totalTheo_last3Months-isnull(NetFP_last3Months,0))/MonthsPlayed_last3Months as money) else null end as AMT_NetFP_last3Months
	,case when MonthsPlayed_last2Months <> 0 then cast((totalTheo_last2Months-isnull(NetFP_last2Months,0))/MonthsPlayed_last2Months as money) else null end as AMT_NetFP_last2Months
	,case when MonthsPlayed_lastMonth <> 0 then cast((totalTheo_lastMonth-isnull(NetFP_lastMonth,0))/MonthsPlayed_lastMonth as money) else null end as AMT_NetFP_lastMonth
	,case when MonthsPlayed_3MonthLGD <> 0 then cast((totalTheo_3MonthLGD-isnull(NetFP_3MonthLGD,0))/MonthsPlayed_3MonthLGD as money) else null end as AMT_NetFP_3MonthLGD


	--AMV
	--Need to fiqure out divsior in YTD,QTD
	,cast(daysOnProperty_Last36Months/36.0 as [decimal](18,4)) as AMV_Last36Months
	,cast(daysOnProperty_Last24Months/24.0 as [decimal](18,4)) as AMV_Last24Months
	,cast(daysOnProperty_Last18Months/18.0 as [decimal](18,4)) as AMV_Last18Months
	,cast(daysOnProperty_Last12Months/12.0 as [decimal](18,4)) as AMV_Last12Months
	,cast(daysOnProperty_Last9Months/9.0 as [decimal](18,4)) as AMV_Last9Months
	,cast(daysOnProperty_Last6Months/6.0 as [decimal](18,4)) as AMV_Last6Months
	,cast(daysOnProperty_Last4Months/4.0 as [decimal](18,4)) as AMV_Last4Months
	,cast(daysOnProperty_Last3Months/3.0 as [decimal](18,4)) as AMV_Last3Months
	,cast(daysOnProperty_Last2Months/2.0 as [decimal](18,4)) as AMV_Last2Months
	,cast(daysOnProperty_LastMonth/1.0 as [decimal](18,4)) as AMV_LastMonth
	,cast(daysOnProperty_3MonthLGD/3.0 as [decimal](18,4)) as AMV_3MonthLGD


	--Average Monthly Worth
	,case when MonthsPlayed_YTD <> 0 then cast(dailyWorth_YTD/MonthsPlayed_YTD as money) else null end as AMW_GrossFP_YTD
	,case when MonthsPlayed_QTD <> 0 then cast(dailyWorth_QTD/MonthsPlayed_QTD as money) else null end as AMW_GrossFP_QTD
	,case when MonthsPlayed_last36Months <> 0 then cast(DailyWorth_last36Months/MonthsPlayed_last36Months as money) else null end as AMW_GrossFP_last36Months
	,case when MonthsPlayed_last24Months <> 0 then cast(DailyWorth_last24Months/MonthsPlayed_last24Months as money) else null end as AMW_GrossFP_last24Months
	,case when MonthsPlayed_last18Months <> 0 then cast(DailyWorth_last18Months/MonthsPlayed_last18Months as money) else null end as AMW_GrossFP_last18Months
	,case when MonthsPlayed_last12Months <> 0 then cast(DailyWorth_last12Months/MonthsPlayed_last12Months as money) else null end as AMW_GrossFP_last12Months
	,case when MonthsPlayed_last9Months <> 0 then cast(DailyWorth_last9Months/MonthsPlayed_last9Months as money) else null end as AMW_GrossFP_last9Months
	,case when MonthsPlayed_last6Months <> 0 then cast(DailyWorth_last6Months/MonthsPlayed_last6Months as money) else null end as AMW_GrossFP_last6Months
	,case when MonthsPlayed_last4Months <> 0 then cast(DailyWorth_last4Months/MonthsPlayed_last4Months as money) else null end as AMW_GrossFP_last4Months
	,case when MonthsPlayed_last3Months <> 0 then cast(DailyWorth_last3Months/MonthsPlayed_last3Months as money) else null end as AMW_GrossFP_last3Months
	,case when MonthsPlayed_last2Months <> 0 then cast(DailyWorth_last2Months/MonthsPlayed_last2Months as money) else null end as AMW_GrossFP_last2Months
	,case when MonthsPlayed_lastMonth <> 0 then cast(DailyWorth_lastMonth/MonthsPlayed_lastMonth as money) else null end as AMW_GrossFP_lastMonth
	,case when MonthsPlayed_3MonthLGD <> 0 then cast(DailyWorth_3MonthLGD/MonthsPlayed_3MonthLGD as money) else null end as AMW_GrossFP_3MonthLGD

	--Montly Worth NETFP
	,case when MonthsPlayed_YTD <> 0 then cast((dailyWorth_YTD-isnull(NETFP_YTD,0))/MonthsPlayed_YTD as money) else null end as AMW_Net_YTD
	,case when MonthsPlayed_QTD <> 0 then cast((dailyWorth_QTD-isnull(NETFP_QTD,0))/MonthsPlayed_QTD as money) else null end as AMW_Net_QTD
	,case when MonthsPlayed_last36Months <> 0 then cast((dailyWorth_Last36Months-isnull(NETFP_last36Months,0))/MonthsPlayed_last36Months as money) else null end as AMW_NetFP_last36Months
	,case when MonthsPlayed_last24Months <> 0 then cast((dailyWorth_last24Months-isnull(NETFP_last24Months,0))/MonthsPlayed_last24Months as money) else null end as AMW_NetFP_last24Months
	,case when MonthsPlayed_last18Months <> 0 then cast((dailyWorth_last18Months-isnull(NetFP_last18Months,0))/MonthsPlayed_last18Months as money) else null end as AMW_NetFP_last18Months
	,case when MonthsPlayed_last12Months <> 0 then cast((dailyWorth_last12Months-isnull(NETFP_last12Months,0))/MonthsPlayed_last12Months as money) else null end as AMW_NetFP_last12Months
	,case when MonthsPlayed_last9Months <> 0 then cast((dailyWorth_last9Months-isnull(NETFP_last9Months,0))/MonthsPlayed_last9Months as money) else null end as AMW_NetFP_last9Months
	,case when MonthsPlayed_last6Months <> 0 then cast((dailyWorth_last6Months -isnull(NETFP_last6Months,0))/MonthsPlayed_last6Months as money) else null end as AMW_NetFP_last6Months
	,case when MonthsPlayed_last4Months <> 0 then cast((dailyWorth_last4Months -isnull(NETFP_last4Months,0))/MonthsPlayed_last4Months as money) else null end as AMW_NetFP_last4Months
	,case when MonthsPlayed_last3Months <> 0 then cast((dailyWorth_last3Months-isnull(NETFP_last3Months,0))/MonthsPlayed_last3Months as money) else null end as AMW_NetFP_last3Months
	,case when MonthsPlayed_last2Months <> 0 then cast((dailyWorth_last2Months-isnull(NETFP_last2Months,0))/MonthsPlayed_last2Months as money) else null end as AMW_NetFP_last2Months
	,case when MonthsPlayed_lastMonth <> 0 then cast((dailyWorth_lastMonth-isnull(NETFP_lastMonth,0))/MonthsPlayed_lastMonth as money) else null end as AMW_NetFP_lastMonth
	,case when MonthsPlayed_3MonthLGD <> 0 then cast((dailyWorth_3MonthLGD-isnull(NETFP_3MonthLGD,0))/MonthsPlayed_3MonthLGD as money) else null end as AMW_NetFP_3MonthLGD

	,award_FPUsed_YTD
	,award_FPUsed_QTD
	,award_FPUsed_Last36Months
	,award_FPUsed_last24Months
	,award_FPUsed_last18Months
	,award_FPUsed_last12Months
	,award_FPUsed_last9Months
	,award_FPUsed_last6Months
	,award_FPUsed_last3Months
	,award_FPUsed_Last4Months
	,award_FPUsed_Last2Months
	,award_FPUsed_lastMonth
	,award_FPUsed_3MonthLGD


into #UniqueDays

from
	[iQ-Gaming].[dbo].[IQ_Marketing_Metrics] base
full join 
	#SummedMarketingMetricsEXT rate
on base.UniqueKey=rate.UniqueKey
left join
	#AwardsSum2 awd
on base.UniqueKey=awd.UniqueKey

-- Create an index to improve processing
	CREATE CLUSTERED INDEX IDX_UniqueKey ON #UniqueDays(UniqueKey)	

----------------------------------------------------------------------------------------------------
-- This code is under development  there are structures that wont work with VCR                   
-- Commenting out for now and just writing the output dataset with nullsthe fields defined below
----------------------------------------------------------------------------------------------------


-- Calculate Gaming Preferences
	select UniqueKey,
		a.playerID,
		a.CasinoCode,
		a.GameType,
		a.GameCode,
		a.Rating_Minutes,
		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-36,@baselineDate))) and @baselineDate then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_last36Months,
		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-24,@baselineDate))) and @baselineDate then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_last24Months,
		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-18,@baselineDate))) and @baselineDate then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_last18Months,
		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-12,@baselineDate))) and @baselineDate then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_last12Months,
		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-9,@baselineDate))) and @baselineDate then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_last9Months,	
		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-6,@baselineDate))) and @baselineDate then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_last6Months,	
		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-4,@baselineDate))) and @baselineDate then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_last4Months,	
		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,@baselineDate))) and @baselineDate then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_last3Months,	
		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-2,@baselineDate))) and @baselineDate then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_last2Months,	
		case when [Date] between DATEADD(day, 1, EOMONTH(DATEADD(month,-1,@baselineDate))) and @baselineDate then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_lastMonth,	
		case when [Date] between DATEADD(month,-3,eomonth(b.LastTripDate)) and eomonth(b.LastTripDate) then Rating_Minutes else cast(0 as decimal(12,2)) end as RatingMinutes_3MonthLGD	
	  into #RatingMinutes		  
	  from ##RawRatings a
		left join 
			(select PlayerID, CasinoCode, LastTripDate from ##LGD_Extract --##LastTrips
			) b
		on a.PlayerID = b.PlayerID
		and a.CasinoCode = b.CasinoCode
	where Rating_Minutes > 0.0
	  and a.PlayerID <> 0

-- Create Base Casino Preferences
    select PlayerID,
		   CasinoCode,
		   GameType,
		   GameCode,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_last36Months DESC) AS GameTypePrefID_Last36Months,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_last36Months DESC) AS GameCodePrefID_Last36Months,
		   
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_last24Months DESC) AS GameTypePrefID_Last24Months,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_last24Months DESC) AS GameCodePrefID_Last24Months,
		   
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_last18Months DESC) AS GameTypePrefID_Last18Months,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_last18Months DESC) AS GameCodePrefID_Last18Months,
		   
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_last12Months DESC) AS GameTypePrefID_Last12Months,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_last12Months DESC) AS GameCodePrefID_Last12Months,
		   
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_last9Months DESC) AS GameTypePrefID_Last9Months,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_last9Months DESC) AS GameCodePrefID_Last9Months,

		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_last6Months DESC) AS GameTypePrefID_Last6Months,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_last6Months DESC) AS GameCodePrefID_Last6Months,

		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_last4Months DESC) AS GameTypePrefID_Last4Months,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_last4Months DESC) AS GameCodePrefID_Last4Months,

		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_last3Months DESC) AS GameTypePrefID_Last3Months,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_last3Months DESC) AS GameCodePrefID_Last3Months,

		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_last2Months DESC) AS GameTypePrefID_Last2Months,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_last2Months DESC) AS GameCodePrefID_Last2Months,

		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_lastMonth DESC) AS GameTypePrefID_LastMonth,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_lastMonth DESC) AS GameCodePrefID_LastMonth,

		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameType ORDER BY RatingMinutes_3MonthLGD DESC) AS GameTypePrefID_3MonthLGD,
		   ROW_NUMBER() OVER(PARTITION BY PlayerID, CasinoCode, GameCode ORDER BY RatingMinutes_3MonthLGD DESC) AS GameCodePrefID_3MonthLGD

	  into #GamingPreferencesBase
	  from (select PlayerID,
				   CasinoCode,
				   GameType,
				   GameCode,
				   sum(RatingMinutes_last36Months) as RatingMinutes_last36Months,			 
				   sum(RatingMinutes_last24Months) as RatingMinutes_last24Months,			 
				   sum(RatingMinutes_last18Months) as RatingMinutes_last18Months,			 
				   sum(RatingMinutes_last12Months) as RatingMinutes_last12Months,			 
				   sum(RatingMinutes_last9Months) as RatingMinutes_last9Months,
				   sum(RatingMinutes_last6Months) as RatingMinutes_last6Months,
				   sum(RatingMinutes_last4Months) as RatingMinutes_last4Months,
				   sum(RatingMinutes_last3Months) as RatingMinutes_last3Months,
				   sum(RatingMinutes_last2Months) as RatingMinutes_last2Months,
				   sum(RatingMinutes_lastMonth) as RatingMinutes_lastMonth,
				   sum(RatingMinutes_lastMonth) as RatingMinutes_3MonthLGD
			  from #RatingMinutes
			 where RatingMinutes_last36Months > 0
			 group by PlayerID, CasinoCode, GameType, GameCode ) a




---------- Create CORP Time Preferences
		select PlayerID,
			'CORP' AS CasinoCode,
			GameType,
			GameCode,
			GameTypePrefID_Last36Months,
			GameCodePrefID_Last36Months,
			   
			GameTypePrefID_Last24Months,
			GameCodePrefID_Last24Months,
			   
			GameTypePrefID_Last18Months,
			GameCodePrefID_Last18Months,
			   
			 GameTypePrefID_Last12Months,
			GameCodePrefID_Last12Months,
			   
			GameTypePrefID_Last9Months,
			GameCodePrefID_Last9Months,

			GameTypePrefID_Last6Months,
			GameCodePrefID_Last6Months,

			GameTypePrefID_Last4Months,
			GameCodePrefID_Last4Months,

			GameTypePrefID_Last3Months,
			GameCodePrefID_Last3Months,

			GameTypePrefID_Last2Months,
			GameCodePrefID_Last2Months,

			GameTypePrefID_LastMonth,
			GameCodePrefID_LastMonth,

			GameTypePrefID_3MonthLGD,
			GameCodePrefID_3MonthLGD

		into #GamingPreferencesCORP
		from #GamingPreferencesBase


-- Create final preference file
	select UniqueKey, 
		   isnull(max(GameTypePref_Last36Months),'U') as GameTypePref_Last36Months,
		   isnull(max(GameCodePref_Last36Months),'U') as GameCodePref_Last36Months,

		   isnull(max(GameTypePref_Last24Months),'U') as GameTypePref_Last24Months,
		   isnull(max(GameCodePref_Last24Months),'U') as GameCodePref_Last24Months, 

		   isnull(max(GameTypePref_Last18Months),'U') as GameTypePref_Last18Months,
		   isnull(max(GameCodePref_Last18Months),'U') as GameCodePref_Last18Months, 

		   isnull(max(GameTypePref_Last12Months),'U') as GameTypePref_Last12Months,
		   isnull(max(GameCodePref_Last12Months),'U') as GameCodePref_Last12Months, 

		   isnull(max(GameTypePref_Last9Months),'U') as GameTypePref_Last9Months,
		   isnull(max(GameCodePref_Last9Months),'U') as GameCodePref_Last9Months,

		   isnull(max(GameTypePref_Last6Months),'U') as GameTypePref_Last6Months,
		   isnull(max(GameCodePref_Last6Months),'U') as GameCodePref_Last6Months,

		   isnull(max(GameTypePref_Last4Months),'U') as GameTypePref_Last4Months,
		   isnull(max(GameCodePref_Last4Months),'U') as GameCodePref_Last4Months,	

		   isnull(max(GameTypePref_Last3Months),'U') as GameTypePref_Last3Months,
		   isnull(max(GameCodePref_Last3Months),'U') as GameCodePref_Last3Months,	

		   isnull(max(GameTypePref_Last2Months),'U') as GameTypePref_Last2Months,
		   isnull(max(GameCodePref_Last2Months),'U') as GameCodePref_Last2Months,	

		   isnull(max(GameTypePref_LastMonth),'U') as GameTypePref_LastMonth,
		   isnull(max(GameCodePref_LastMonth),'U') as GameCodePref_LastMonth,	

		   isnull(max(GameTypePref_3MonthLGD),'U') as GameTypePref_3MonthLGD,
		   isnull(max(GameCodePref_3MonthLGD),'U') as GameCodePref_3MonthLGD


	  into #FinalPreferences         
      from (select cast(PlayerID as varchar(12)) + cast(CasinoCode as varchar(4)) as UniqueKey,
				case when GameTypePrefID_Last36Months = 1 then GameType else null end as GameTypePref_Last36Months,
				case when GameCodePrefID_Last36Months = 1 then GameCode else null end as GameCodePref_Last36Months,

				case when GameTypePrefID_Last24Months = 1 then GameType else null end as GameTypePref_Last24Months,
				case when GameCodePrefID_Last24Months = 1 then GameCode else null end as GameCodePref_Last24Months,

				case when GameTypePrefID_Last18Months = 1 then GameType else null end as GameTypePref_Last18Months,
				case when GameCodePrefID_Last18Months = 1 then GameCode else null end as GameCodePref_Last18Months,

				case when GameTypePrefID_Last12Months = 1 then GameType else null end as GameTypePref_Last12Months,
				case when GameCodePrefID_Last12Months = 1 then GameCode else null end as GameCodePref_Last12Months,

				case when GameTypePrefID_Last9Months = 1 then GameType else null end as GameTypePref_Last9Months,
				case when GameCodePrefID_Last9Months = 1 then GameCode else null end as GameCodePref_Last9Months,
 
				case when GameTypePrefID_Last6Months = 1 then GameType else null end as GameTypePref_Last6Months,
				case when GameCodePrefID_Last6Months = 1 then GameCode else null end as GameCodePref_Last6Months,

				case when GameTypePrefID_Last4Months = 1 then GameType else null end as GameTypePref_Last4Months,
				case when GameCodePrefID_Last4Months = 1 then GameCode else null end as GameCodePref_Last4Months,

				case when GameTypePrefID_Last3Months = 1 then GameType else null end as GameTypePref_Last3Months,
				case when GameCodePrefID_Last3Months = 1 then GameCode else null end as GameCodePref_Last3Months,

				case when GameTypePrefID_Last2Months = 1 then GameType else null end as GameTypePref_Last2Months,
				case when GameCodePrefID_Last2Months = 1 then GameCode else null end as GameCodePref_Last2Months,

				case when GameTypePrefID_LastMonth = 1 then GameType else null end as GameTypePref_LastMonth,
				case when GameCodePrefID_LastMonth = 1 then GameCode else null end as GameCodePref_LastMonth,

				case when GameTypePrefID_3MonthLGD = 1 then GameType else null end as GameTypePref_3MonthLGD,
				case when GameCodePrefID_3MonthLGD = 1 then GameCode else null end as GameCodePref_3MonthLGD

	          from #GamingPreferencesBase 
			 union
	        select cast(PlayerID as varchar(12)) + cast(CasinoCode as varchar(4)) as UniqueKey,
				case when GameTypePrefID_Last36Months = 1 then GameType else null end as GameTypePref_Last36Months,
				case when GameCodePrefID_Last36Months = 1 then GameCode else null end as GameCodePref_Last36Months,

				case when GameTypePrefID_Last24Months = 1 then GameType else null end as GameTypePref_Last24Months,
				case when GameCodePrefID_Last24Months = 1 then GameCode else null end as GameCodePref_Last24Months,

				case when GameTypePrefID_Last18Months = 1 then GameType else null end as GameTypePref_Last18Months,
				case when GameCodePrefID_Last18Months = 1 then GameCode else null end as GameCodePref_Last18Months,

				case when GameTypePrefID_Last12Months = 1 then GameType else null end as GameTypePref_Last12Months,
				case when GameCodePrefID_Last12Months = 1 then GameCode else null end as GameCodePref_Last12Months,

				case when GameTypePrefID_Last9Months = 1 then GameType else null end as GameTypePref_Last9Months,
				case when GameCodePrefID_Last9Months = 1 then GameCode else null end as GameCodePref_Last9Months,
 
				case when GameTypePrefID_Last6Months = 1 then GameType else null end as GameTypePref_Last6Months,
				case when GameCodePrefID_Last6Months = 1 then GameCode else null end as GameCodePref_Last6Months,

				case when GameTypePrefID_Last4Months = 1 then GameType else null end as GameTypePref_Last4Months,
				case when GameCodePrefID_Last4Months = 1 then GameCode else null end as GameCodePref_Last4Months,

				case when GameTypePrefID_Last3Months = 1 then GameType else null end as GameTypePref_Last3Months,
				case when GameCodePrefID_Last3Months = 1 then GameCode else null end as GameCodePref_Last3Months,

				case when GameTypePrefID_Last2Months = 1 then GameType else null end as GameTypePref_Last2Months,
				case when GameCodePrefID_Last2Months = 1 then GameCode else null end as GameCodePref_Last2Months,

				case when GameTypePrefID_LastMonth = 1 then GameType else null end as GameTypePref_LastMonth,
				case when GameCodePrefID_LastMonth = 1 then GameCode else null end as GameCodePref_LastMonth,

				case when GameTypePrefID_3MonthLGD = 1 then GameType else null end as GameTypePref_3MonthLGD,
				case when GameCodePrefID_3MonthLGD = 1 then GameCode else null end as GameCodePref_3MonthLGD
			from #GamingPreferencesCORP 
	        ) a
     group by UniqueKey
 
-- Create an index to improve processing
	CREATE CLUSTERED INDEX IDX_UniqueKey_2 ON #FinalPreferences(UniqueKey)	    
	   
-- Game Type Preferences based on Marketing Metrics
	select  e.UniqueKey,
	       case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last36Months]),([tableTheo_last36Months]),([BingoTheo_last36Months])) AS Theos(Theo)) = [slotTheo_last36Months]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last36Months]),([tableTheo_last36Months]),([BingoTheo_last36Months])) AS Theos(Theo)) = [tableTheo_last36Months]
			   then 'T'
			 else 'B'
		   end as [GameType_Last36Months],

	       case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last24Months]),([tableTheo_last24Months]),([BingoTheo_last24Months])) AS Theos(Theo)) = [slotTheo_last24Months]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last24Months]),([tableTheo_last24Months]),([BingoTheo_last24Months])) AS Theos(Theo)) = [tableTheo_last24Months]
			   then 'T'
			 else 'B'
		   end as [GameType_Last24Months],

		  case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last18Months]),([tableTheo_last18Months]),([BingoTheo_last18Months])) AS Theos(Theo)) = [slotTheo_last18Months]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last18Months]),([tableTheo_last18Months]),([BingoTheo_last18Months])) AS Theos(Theo)) = [tableTheo_last18Months]
			   then 'T'
			 else 'B'
		   end as [GameType_Last18Months],

	       case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last12Months]),([tableTheo_last12Months]),([BingoTheo_last12Months])) AS Theos(Theo)) = [slotTheo_last12Months]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last12Months]),([tableTheo_last12Months]),([BingoTheo_last12Months])) AS Theos(Theo)) = [tableTheo_last12Months]
			   then 'T'
			 else 'B'
		   end as [GameType_Last12Months],

	       case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last9Months]),([tableTheo_last9Months]),([BingoTheo_last9Months])) AS Theos(Theo)) = [slotTheo_last9Months]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last9Months]),([tableTheo_last9Months]),([BingoTheo_last9Months])) AS Theos(Theo)) = [tableTheo_last9Months]
			   then 'T'
			 else 'B'
		   end as [GameType_Last9Months],
	       case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last6Months]),([tableTheo_last6Months]),([BingoTheo_last6Months])) AS Theos(Theo)) = [slotTheo_last6Months]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last6Months]),([tableTheo_last6Months]),([BingoTheo_last6Months])) AS Theos(Theo)) = [tableTheo_last6Months]
			   then 'T'
			 else 'B'
		   end as [GameType_Last6Months],
	       case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last4Months]),([tableTheo_last4Months]),([BingoTheo_last4Months])) AS Theos(Theo)) = [slotTheo_last4Months]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last4Months]),([tableTheo_last4Months]),([BingoTheo_last4Months])) AS Theos(Theo)) = [tableTheo_last4Months]
			   then 'T'
			 else 'B'
		   end as [GameType_Last4Months],
	       case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last3Months]),([tableTheo_last3Months]),([BingoTheo_last3Months])) AS Theos(Theo)) = [slotTheo_last3Months]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last3Months]),([tableTheo_last3Months]),([BingoTheo_last3Months])) AS Theos(Theo)) = [tableTheo_last3Months]
			   then 'T'
			 else 'B'
		   end as [GameType_Last3Months],
	       case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last2Months]),([tableTheo_last2Months]),([BingoTheo_last2Months])) AS Theos(Theo)) = [slotTheo_last2Months]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_last2Months]),([tableTheo_last2Months]),([BingoTheo_last2Months])) AS Theos(Theo)) = [tableTheo_last2Months]
			   then 'T'
			 else 'B'
		   end as [GameType_Last2Months],
	       case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_lastMonth]),([tableTheo_lastMonth]),([BingoTheo_lastMonth])) AS Theos(Theo)) = [slotTheo_lastMonth]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_lastMonth]),([tableTheo_lastMonth]),([BingoTheo_lastMonth])) AS Theos(Theo)) = [tableTheo_lastMonth]
			   then 'T'
			 else 'B'
		   end as [GameType_LastMonth],
	       case
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_3MonthLGD]),([tableTheo_3MonthLGD]),([BingoTheo_3MonthLGD])) AS Theos(Theo)) = [slotTheo_3MonthLGD]
			   then 'S'
		     when (SELECT MAX(Theo) FROM (VALUES ([slotTheo_3MonthLGD]),([tableTheo_3MonthLGD]),([BingoTheo_3MonthLGD])) AS Theos(Theo)) = [tableTheo_3MonthLGD]
			   then 'T'
			 else 'B'
		   end as [GameType_3MonthLGD]

      into #MMGameTypePref
	  from [dbo].[IQ_Marketing_Metrics] b
	   join
		#SummedMarketingMetricsEXT e
	on b.UniqueKey=e.UniqueKey

-- Create an index to improve processing
	CREATE CLUSTERED INDEX IDX_UniqueKey_3 ON #MMGameTypePref(UniqueKey)







--------/* Template for code specific for VCR */
--------select 
--------	mm.playerID
--------	,case when awd.gamingDate between DATEADD(day, 1, DATEADD(month,-3,mm.LastTripDate)) and mm.LastTripDate then award_FPAwarded_Total else 0 end as FP_3monthLGD
----------need to calculate worth probably PlayerDailyTotalsExt
----------pd.worth_Gross_3monthLGD,
--------	,case when awd.gamingDate between DATEADD(day, 1, DATEADD(month,-3,mm.LastTripDate)) and mm.LastTripDate then 1 else 0 end as visits_3monthLGD,
--------	,case when awd.gamingDate between DATEADD(day, 1, DATEADD(month,-3,mm.LastTripDate)) and mm.LastTripDate 
--------			then ([award_FPawarded_Total] - [award_FPawarded_PromoWinner]-[award_FPAwarded_ServiceRecovery])
--------				+ ([award_CompsUsed_Other]-[award_Comp_ServiceRecovery]) 
--------				+ [award_CompsUsed_FB] 
--------				+ ([award_PromoChipsAwarded]-[award_PromoChipUsed_PromoWinner]-[award_PromoChipUsed_ServiceRecovery])
--------				+ [award_CashAwarded_Bingo]+ ([award_CompsUsed_Hotel_Mktg]*.5) + [award_Promo_Merchanise]
--------			else 0 
--------		end as ReinvestmentValue

----------sum(([award_FPawarded_Total] - p.[award_FPawarded_PromoWinner]-[award_FPAwarded_ServiceRecovery]) + ([award_CompsUsed_Other]-[award_Comp_ServiceRecovery]) + p.[award_CompsUsed_FB] + ([award_PromoChipsAwarded]-[award_PromoChipUsed_PromoWinner]-[award_PromoChipUsed_ServiceRecovery]) + [award_CashAwarded_Bingo]+ (p.[award_CompsUsed_Hotel_Mktg]*.5) + p.[award_Promo_Merchanise]) / sum(p.daily_worth) ReinvestnmentPercent,
----------sum (p.daily_worth) TotalWorth,
----------pd.ADW_NetFP_3monthLGD as '3Mos_ADW',
----------pd.AMW_NetFP_3MonthLGD as '3Mos_AMW',
--------pd.ADP_3MonthLGD as '3Mos_ADP',
--------pd.AMP_3monthLGD as '3Mos_AMP',
--------pd.AMV_3monthLGD,
--------pd.PlayerType_3monthLGD PlayerType,
--------pd.Total_Theo_6month,
--------pd.visits_3month,
--------pd.visits_6month,
--------pd.visits_12month,
--------pd.playerlastdate_3monthLGD LastGamingDate,
--------Case when pd.ADP_3MonthLGD >= 1000 then '1.$1000+'
--------when pd.ADP_3MonthLGD >= 500 then '2.$500 - $999'
--------when pd.ADP_3MonthLGD >= 200 then '3.$200 - $499'
--------when pd.ADP_3MonthLGD >= 100 then '4.$100 - $199'
--------when pd.ADP_3MonthLGD >= 75 then '5.$75 - $99'
--------when pd.ADP_3MonthLGD >= 25 then '6.$25 - $74'
--------else '7.$0 - $24' end ADP_Segment,
--------case when pd.[AMV_3monthLGD] >=10 then '10+'
--------when pd.[AMV_3monthLGD] >=6 then '06-9.99'
--------when pd.[AMV_3monthLGD] >=4 then '04-5.99'
--------when pd.[AMV_3monthLGD] >=2 then '02-3.99'
--------else '01-1.99' end TripSeg,
--------case when pd.Table_Theo_6month > 0 then 'Yes' else 'No' end 'PlaysTables',
--------CONVERT(VARCHAR(10), getdate(), 101) [Account Update As-Of Date],
--------CASE WHEN pd.player_FPC_bal <0 THEN 0 ELSE pd.player_FPC_bal end Promo1Bal,
--------pd.player_point_bal,
--------case when (pd.playerlastdate_3monthLGD >= DATEADD(month, -6, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) and (pd.player_geo_distance <=150 or (pd.player_geo_distance is null and pd.player_state in ('CA','AZ')))) or pd.player_club_level in ('Gold','Platinum','Infinity') then 'Active'
--------when pd.playerlastdate_3monthLGD >= DATEADD(month, -12, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) and (pd.player_geo_distance <=150 or (pd.player_geo_distance is null and pd.player_state in ('CA','AZ'))) and (pd.player_isemailsend = 'true' or (pd.player_isnomail = 'false' and pd.player_isreturnmail = 'false')) then 'Inactive'
--------when pd.playerlastdate_3monthLGD >= DATEADD(month, -12, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) and (pd.player_geo_distance between 150 and 1500) and (pd.player_isemailsend = 'true' or (pd.player_isnomail = 'false' and pd.player_isreturnmail = 'false')) then 'OuterMarket'
--------else 'DNU' end 'Activity'





--------	from 
--------		(select distinct playerID , LastTripDate from [iQ-Gaming].[dbo].[IQ_Marketing_Metrics] where CasinoCode='VCR') MM
--------	left join
--------		[iQ-Gaming].[dbo].[IQC_Awards] awd
--------	on mm.PlayerID=awd.playerID


---- Create an index to improve processing
--	CREATE CLUSTERED INDEX IDX_UniqueKey_Distances ON #Distances(UniqueKey)

-- Clear existing data from the table
	truncate table [dbo].[IQ_Marketing_Metrics_EXT]

---- Insert updated data into the table
	insert into [dbo].[IQ_Marketing_Metrics_EXT]
			([UniqueKey]
		,PlayerID
		,[BaselineDate]
		,[RunDate]
		,[casinoCode]
		,LastTripDate
		,max_3MonthLGD
		,min_3MonthLGD
		,[AccountCreditStatus]
		,[BonusPointsCurrentBalance]
		,[SpecialInterestCode]
		,[Territory]
		,[GuestStatus]
		,[GameType_3MonthLGD]
		,[GameType_LastMonth]
		,[GameType_Last2Months]
		,[GameType_Last3Months]
		,[GameType_Last4Months]
		,[GameType_Last6Months]
		,[GameType_Last9Months]
		,[GameType_Last12Months]
		,[GameType_Last18Months]
		,[GameType_Last24Months]
		,[GameType_Last36Months]
		,Distance_VCR
		,[PropertyPref_Last36Months]
		,[PropertyPref_Last24Months]
		,[PropertyPref_Last18Months]
		,[PropertyPref_Last12Months]
		,[PropertyPref_Last9Months]
		,[PropertyPref_Last6Months]
		,[PropertyPref_Last4Months]
		,[PropertyPref_Last3Months]
		,[PropertyPref_Last2Months]
		,[PropertyPref_LastMonth]
		,[PropertyPref_3MonthLGD]
		,[ADW_Last36Months]
		,[ADW_Last24Months]
		,[ADW_Last18Months]
		,[ADW_Last12Months]
		,[ADW_Last9Months]
		,[ADW_Last6Months]
		,[ADW_Last4Months]
		,[ADW_Last3Months]
		,[ADW_Last2Months]
		,[ADW_LastMonth]
		,[daysOnProperty_last36Months]
		,[daysOnProperty_last4Months]
		,[daysOnProperty_last2Months]
		,[gamingDays_last36Months]
		,[gamingDays_last4Months]
		,[gamingDays_last2Months]
		,[slotDays_last36Months]
		,[slotDays_last4Months]
		,[slotDays_last2Months]
		,[tableDays_last36Months]
		,[tableDays_last4Months]
		,[tableDays_last2Months]
		,[totalTheo_last36Months]
		,[totalTheo_last4Months]
		,[totalTheo_last2Months]
		,[actualWinLoss_last36Months]
		,[actualWinLoss_last4Months]
		,[actualWinLoss_last2Months]
		,[slotTheo_last36Months]
		,[slotTheo_last4Months]
		,[slotTheo_last2Months]
		,[tableTheo_last36Months]
		,[tableTheo_last4Months]
		,[tableTheo_last2Months]
		,[slotActualWinLoss_last36Months]
		,[slotActualWinLoss_last4Months]
		,[slotActualWinLoss_last2Months]
		,[tableActualWinLoss_last36Months]
		,[tableActualWinLoss_last4Months]
		,[tableActualWinLoss_last2Months]
		,[compsEarned_last36Months]
		,[compsEarned_last4Months]
		,[compsEarned_last2Months]
		,[compsUsed_last36Months]
		,[compsUsed_last4Months]
		,[compsUsed_last2Months]
		,[pointsEarned_last36Months]
		,[pointsEarned_last4Months]
		,[pointsEarned_last2Months]
		,[pointPlayUsed_last36Months]
		,[pointPlayUsed_last4Months]
		,[pointPlayUsed_last2Months]
		,[trips_last36Months]
		,[trips_last4Months]
		,[trips_last2Months]
		,[ADT_last36Months]
		,[ADT_last4Months]
		,[ADT_last2Months]
		,[ATT_last36Months]
		,[ATT_last4Months]
		,[ATT_last2Months]
		,[MarketCode2]
		,[CustomerID_C]
		,[EmpFlag]
		,GameTypePref_Last36Months
		,GameCodePref_Last36Months

		,GameTypePref_Last24Months
		,GameCodePref_Last24Months

		,GameTypePref_Last18Months 
		,GameCodePref_Last18Months

		,GameTypePref_Last12Months
		,GameCodePref_Last12Months
	
		,GameTypePref_Last9Months
		,GameCodePref_Last9Months

		,GameTypePref_Last6Months
		,GameCodePref_Last6Months

		,GameTypePref_Last4Months
		,GameCodePref_Last4Months

		,GameTypePref_Last3Months
		,GameCodePref_Last3Months

		,GameTypePref_Last2Months
		,GameCodePref_Last2Months

		,GameTypePref_LastMonth
		,GameCodePref_LastMonth
	
		,GameTypePref_3MonthLGD
		,GameCodePref_3MonthLGD

		,[AvgTrips_Last12Months]
		,[AvgTrips_Last9Months]
		,[AvgTrips_Last6Months]
		,[AvgTrips_Last3Months]
		,[TripsDifference_9M_12M]
		,[TripsDifference_6M_9M]
		,[TripsDifference_3M_6M]
		,[DeclinedTripsFlag_9M_12M]
		,[DeclinedTripsFlag_6M_9M]
		,[DeclinedTripsFlag_3M_6M]
		,[DeclinedTripsFlag_Sum]
		,[DeclinerType]
		,[daysOnProperty_3MonthLGD]
		,[gamingDays_3MonthLGD]
		,[slotDays_3MonthLGD]
		,[tableDays_3MonthLGD]
		,[trips_3MonthLGD]
		,[totalTheo_3MonthLGD]
		,[actualWinLoss_3MonthLGD]
		,[slotTheo_3MonthLGD]
		,[tableTheo_3MonthLGD]
		,[slotActualWinLoss_3MonthLGD]
		,[tableActualWinLoss_3MonthLGD]
		,[compsEarned_3MonthLGD]
		,[compsUsed_3MonthLGD]
		,[pointsEarned_3MonthLGD]
		,[pointPlayUsed_3MonthLGD]
		,[dailyWorth_YTD]
		,[dailyWorth_QTD]
		,[dailyWorth_Last36Months]
		,[dailyWorth_last24Months]
		,[dailyWorth_last18Months]
		,[dailyWorth_last12Months]
		,[dailyWorth_last9Months]
		,[dailyWorth_last6Months]
		,[dailyWorth_Last4Months]
		,[dailyWorth_last3Months]
		,[dailyWorth_Last2Months]
		,[dailyWorth_lastMonth]
		,[dailyWorth_3MonthLGD]
		,[BingoTheo_YTD]
		,[BingoTheo_QTD]
		,[BingoTheo_Last36Months]
		,[BingoTheo_last24Months]
		,[BingoTheo_last18Months]
		,[BingoTheo_last12Months]
		,[BingoTheo_last9Months]
		,[BingoTheo_last6Months]
		,[BingoTheo_Last4Months]
		,[BingoTheo_last3Months]
		,[BingoTheo_Last2Months]
		,[BingoTheo_lastMonth]
		,[BingoTheo_3MonthLGD]
		,[MonthsPlayed_YTD]
		,[MonthsPlayed_QTD]
		,[MonthsPlayed_Last36Months]
		,[MonthsPlayed_last24Months]
		,[MonthsPlayed_last18Months]
		,[MonthsPlayed_last12Months]
		,[MonthsPlayed_last9Months]
		,[MonthsPlayed_last6Months]
		,[MonthsPlayed_last3Months]
		,[MonthsPlayed_Last4Months]
		,[MonthsPlayed_Last2Months]
		,[MonthsPlayed_lastMonth]
		,[MonthsPlayed_3MonthLGD]
		,[ADP_YTD]
		,[ADP_QTD]
		,[ADP_last36Months]
		,[ADP_last24Months]
		,[ADP_last18Months]
		,[ADP_last12Months]
		,[ADP_last9Months]
		,[ADP_last6Months]
		,[ADP_last4Months]
		,[ADP_last3Months]
		,[ADP_last2Months]
		,[ADP_lastMonth]
		,[ADP_3MonthLGD]
		,[ADT_GrossFP_YTD]
		,[ADT_GrossFP_QTD]
		,[ADT_GrossFP_last36Months]
		,[ADT_GrossFP_last24Months]
		,[ADT_GrossFP_last18Months]
		,[ADT_GrossFP_last12Months]
		,[ADT_GrossFP_last9Months]
		,[ADT_GrossFP_last6Months]
		,[ADT_GrossFP_last4Months]
		,[ADT_GrossFP_last3Months]
		,[ADT_GrossFP_last2Months]
		,[ADT_GrossFP_lastMonth]
		,[ADT_GrossFP_3MonthLGD]
		,[ADT_NetFP_YTD]
		,[ADT_NetFP_QTD]
		,[ADT_NetFP_last36Months]
		,[ADT_NetFP_last24Months]
		,[ADT_NetFP_last18Months]
		,[ADT_NetFP_last12Months]
		,[ADT_NetFP_last9Months]
		,[ADT_NetFP_last6Months]
		,[ADT_NetFP_last4Months]
		,[ADT_NetFP_last3Months]
		,[ADT_NetFP_last2Months]
		,[ADT_NetFP_lastMonth]
		,[ADT_NetFP_3MonthLGD]
		,[ADW_GrossFP_YTD]
		,[ADW_GrossFP_QTD]
		,[ADW_GrossFP_last36Months]
		,[ADW_GrossFP_last24Months]
		,[ADW_GrossFP_last18Months]
		,[ADW_GrossFP_last12Months]
		,[ADW_GrossFP_last9Months]
		,[ADW_GrossFP_last6Months]
		,[ADW_GrossFP_last4Months]
		,[ADW_GrossFP_last3Months]
		,[ADW_GrossFP_last2Months]
		,[ADW_GrossFP_lastMonth]
		,[ADW_GrossFP_3MonthLGD]
		,[ADW_NetFP_YTD]
		,[ADW_NetFP_QTD]
		,[ADW_NetFP_last36Months]
		,[ADW_NetFP_last24Months]
		,[ADW_NetFP_last18Months]
		,[ADW_NetFP_last12Months]
		,[ADW_NetFP_last9Months]
		,[ADW_NetFP_last6Months]
		,[ADW_NetFP_last4Months]
		,[ADW_NetFP_last3Months]
		,[ADW_NetFP_last2Months]
		,[ADW_NetFP_lastMonth]
		,[ADW_NetFP_3MonthLGD]
		,[AMP_YTD]
		,[AMP_QTD]
		,[AMP_last36Months]
		,[AMP_last24Months]
		,[AMP_last18Months]
		,[AMP_last12Months]
		,[AMP_last9Months]
		,[AMP_last6Months]
		,[AMP_last4Months]
		,[AMP_last3Months]
		,[AMP_last2Months]
		,[AMP_lastMonth]
		,[AMP_3MonthLGD]
		,[AMT_GrossFP_YTD]
		,[AMT_GrossFP_QTD]
		,[AMT_GrossFP_last36Months]
		,[AMT_GrossFP_last24Months]
		,[AMT_GrossFP_last18Months]
		,[AMT_GrossFP_last12Months]
		,[AMT_GrossFP_last9Months]
		,[AMT_GrossFP_last6Months]
		,[AMT_GrossFP_last4Months]
		,[AMT_GrossFP_last3Months]
		,[AMT_GrossFP_last2Months]
		,[AMT_GrossFP_lastMonth]
		,[AMT_GrossFP_3MonthLGD]
		,[AMT_NetFP_YTD]
		,[AMT_NetFP_QTD]
		,[AMT_NetFP_last36Months]
		,[AMT_NetFP_last24Months]
		,[AMT_NetFP_last18Months]
		,[AMT_NetFP_last12Months]
		,[AMT_NetFP_last9Months]
		,[AMT_NetFP_last6Months]
		,[AMT_NetFP_last4Months]
		,[AMT_NetFP_last3Months]
		,[AMT_NetFP_last2Months]
		,[AMT_NetFP_lastMonth]
		,[AMT_NetFP_3MonthLGD]
		,[AMV_Last36Months]
		,[AMV_Last24Months]
		,[AMV_Last18Months]
		,[AMV_Last12Months]
		,[AMV_Last9Months]
		,[AMV_Last6Months]
		,[AMV_Last4Months]
		,[AMV_Last3Months]
		,[AMV_Last2Months]
		,[AMV_LastMonth]
		,[AMV_3MonthLGD]
		,[AMW_GrossFP_YTD]
		,[AMW_GrossFP_QTD]
		,[AMW_GrossFP_last36Months]
		,[AMW_GrossFP_last24Months]
		,[AMW_GrossFP_last18Months]
		,[AMW_GrossFP_last12Months]
		,[AMW_GrossFP_last9Months]
		,[AMW_GrossFP_last6Months]
		,[AMW_GrossFP_last4Months]
		,[AMW_GrossFP_last3Months]
		,[AMW_GrossFP_last2Months]
		,[AMW_GrossFP_lastMonth]
		,[AMW_GrossFP_3MonthLGD]
		,[AMW_Net_YTD]
		,[AMW_Net_QTD]
		,[AMW_NetFP_last36Months]
		,[AMW_NetFP_last24Months]
		,[AMW_NetFP_last18Months]
		,[AMW_NetFP_last12Months]
		,[AMW_NetFP_last9Months]
		,[AMW_NetFP_last6Months]
		,[AMW_NetFP_last4Months]
		,[AMW_NetFP_last3Months]
		,[AMW_NetFP_last2Months]
		,[AMW_NetFP_lastMonth]
		,[AMW_NetFP_3MonthLGD]
		,PlayerTypeID
		,[PlayerTypeCode]
		,[PlayerTypeName]
		,award_FPUsed_YTD
		,award_FPUsed_QTD
		,award_FPUsed_Last36Months
		,award_FPUsed_last24Months
		,award_FPUsed_last18Months
		,award_FPUsed_last12Months
		,award_FPUsed_last9Months
		,award_FPUsed_last6Months
		,award_FPUsed_last3Months
		,award_FPUsed_Last4Months
		,award_FPUsed_Last2Months
		,award_FPUsed_lastMonth
		,award_FPUsed_3MonthLGD

		,firstPlayDate_YTD
		,firstPlayDate_QTD
		,firstPlayDate_Last36Months
		,firstPlayDate_last24Months
		,firstPlayDate_last18Months
		,firstPlayDate_last12Months
		,firstPlayDate_last9Months
		,firstPlayDate_last6Months
		,firstPlayDate_Last4Months
		,firstPlayDate_last3Months
		,firstPlayDate_Last2Months
		,firstPlayDate_lastMonth
		,firstPlayDate_3MonthLGD

		,lastPlayDate_YTD
		,lastPlayDate_QTD
		,lastPlayDate_Last36Months
		,lastPlayDate_last24Months
		,lastPlayDate_last18Months
		,lastPlayDate_last12Months
		,lastPlayDate_last9Months
		,lastPlayDate_last6Months
		,lastPlayDate_Last4Months
		,lastPlayDate_last3Months
		,lastPlayDate_Last2Months
		,lastPlayDate_lastMonth
		,lastPlayDate_3MonthLGD

	  )
	select a.UniqueKey ,
		substring(a.UniqueKey,1,charindex('VCR' ,a.uniqueKey)-1) as PlayerID,
		cast(@baselineDate as date) as BaselineDate,
		cast(getdate() as date) as RunDate,
		'VCR' as CasinoCode,
		LastTripDate,
		max_3MonthLGD,
		min_3MonthLGD,
		null as /*isnull(e.AccountCreditStatus,'') as*/ AccountCreditStatus,
		null as /*isnull(e.BonusPointsCurrentBalance,0) */ BonusPointsCurrentBalance,
		null as /*isnull(e.SpecialInterestCode,'') */ SpecialInterestCode
		,null as [Territory]
		,null as [GuestStatus]
		,[GameType_3MonthLGD]
		,[GameType_LastMonth]
		,[GameType_Last2Months]
		,[GameType_Last3Months]
		,[GameType_Last4Months]
		,[GameType_Last6Months]
		,[GameType_Last9Months]
		,[GameType_Last12Months]
		,[GameType_Last18Months]
		,[GameType_Last24Months]
		,[GameType_Last36Months]
		,null as [Distance_VCR]
		,'VCR' as [PropertyPref_Last36Months]
		,'VCR' as [PropertyPref_Last24Months]
		,'VCR' as [PropertyPref_Last18Months]
		,'VCR' as [PropertyPref_Last12Months]
		,'VCR' as [PropertyPref_Last9Months]
		,'VCR' as [PropertyPref_Last6Months]
		,'VCR' as [PropertyPref_Last4Months]
		,'VCR' as [PropertyPref_Last3Months]
		,'VCR' as [PropertyPref_Last2Months]
		,'VCR' as [PropertyPref_LastMonth]
		,'VCR' as [PropertyPref_3MonthLGD]
		,[ADW_GrossFP_last36Months] as [ADW_Last36Months]
		,[ADW_GrossFP_last24Months] as [ADW_Last24Months]
		,[ADW_GrossFP_last18Months] as [ADW_Last18Months]
		,[ADW_GrossFP_last12Months] as [ADW_Last12Months]
		,[ADW_GrossFP_last9Months] as [ADW_Last9Months]
		,[ADW_GrossFP_last6Months] as [ADW_Last6Months]
		,[ADW_GrossFP_last4Months] as [ADW_Last4Months]
		,[ADW_GrossFP_last3Months] as [ADW_Last3Months]
		,[ADW_GrossFP_last2Months] as [ADW_Last2Months]
		,[ADW_GrossFP_lastMonth] as [ADW_LastMonth]
		,[daysOnProperty_last36Months]
		,[daysOnProperty_last4Months]
		,[daysOnProperty_last2Months]
		,[gamingDays_last36Months]
		,[gamingDays_last4Months]
		,[gamingDays_last2Months]
		,[slotDays_last36Months]
		,[slotDays_last4Months]
		,[slotDays_last2Months]
		,[tableDays_last36Months]
		,[tableDays_last4Months]
		,[tableDays_last2Months]
		,[totalTheo_last36Months]
		,[totalTheo_last4Months]
		,[totalTheo_last2Months]
		,[actualWinLoss_last36Months]
		,[actualWinLoss_last4Months]
		,[actualWinLoss_last2Months]
		,[slotTheo_last36Months]
		,[slotTheo_last4Months]
		,[slotTheo_last2Months]
		,[tableTheo_last36Months]
		,[tableTheo_last4Months]
		,[tableTheo_last2Months]
		,[slotActualWinLoss_last36Months]
		,[slotActualWinLoss_last4Months]
		,[slotActualWinLoss_last2Months]
		,[tableActualWinLoss_last36Months]
		,[tableActualWinLoss_last4Months]
		,[tableActualWinLoss_last2Months]
		,[compsEarned_last36Months]
		,[compsEarned_last4Months]
		,[compsEarned_last2Months]
		,[compsUsed_last36Months]
		,[compsUsed_last4Months]
		,[compsUsed_last2Months]
		,[pointsEarned_last36Months]
		,[pointsEarned_last4Months]
		,[pointsEarned_last2Months]
		,[pointPlayUsed_last36Months]
		,[pointPlayUsed_last4Months]
		,[pointPlayUsed_last2Months]
		,[trips_last36Months]
		,[trips_last4Months]
		,[trips_last2Months]
		,null as [ADT_last36Months]
		,null as [ADT_last4Months]
		,null as [ADT_last2Months]
		,null as [ATT_last36Months]
		,null as [ATT_last4Months]
		,null as [ATT_last2Months]
		,null as [MarketCode2]
		,null as [CustomerID_C]
		,null as [EmpFlag]
		,GameTypePref_Last36Months
		,GameCodePref_Last36Months

		,GameTypePref_Last24Months
		,GameCodePref_Last24Months

		,GameTypePref_Last18Months 
		,GameCodePref_Last18Months

		,GameTypePref_Last12Months
		,GameCodePref_Last12Months
	
		,GameTypePref_Last9Months
		,GameCodePref_Last9Months

		,GameTypePref_Last6Months
		,GameCodePref_Last6Months

		,GameTypePref_Last4Months
		,GameCodePref_Last4Months

		,GameTypePref_Last3Months
		,GameCodePref_Last3Months

		,GameTypePref_Last2Months
		,GameCodePref_Last2Months

		,GameTypePref_LastMonth
		,GameCodePref_LastMonth
	
		,GameTypePref_3MonthLGD
		,GameCodePref_3MonthLGD
		,null as [AvgTrips_Last12Months]
		,null as [AvgTrips_Last9Months]
		,null as [AvgTrips_Last6Months]
		,null as [AvgTrips_Last3Months]
		,null as [TripsDifference_9M_12M]
		,null as [TripsDifference_6M_9M]
		,null as [TripsDifference_3M_6M]
		,null as [DeclinedTripsFlag_9M_12M]
		,null as [DeclinedTripsFlag_6M_9M]
		,null as [DeclinedTripsFlag_3M_6M]
		,null as [DeclinedTripsFlag_Sum]
		,null as [DeclinerType]
		,[daysOnProperty_3MonthLGD]
		,[gamingDays_3MonthLGD]
		,[slotDays_3MonthLGD]
		,[tableDays_3MonthLGD]
		,[trips_3MonthLGD]
		,[totalTheo_3MonthLGD]
		,[actualWinLoss_3MonthLGD]
		,[slotTheo_3MonthLGD]
		,[tableTheo_3MonthLGD]
		,[slotActualWinLoss_3MonthLGD]
		,[tableActualWinLoss_3MonthLGD]
		,[compsEarned_3MonthLGD]
		,[compsUsed_3MonthLGD]
		,[pointsEarned_3MonthLGD]
		,[pointPlayUsed_3MonthLGD]
		,[dailyWorth_YTD]
		,[dailyWorth_QTD]
		,[dailyWorth_Last36Months]
		,[dailyWorth_last24Months]
		,[dailyWorth_last18Months]
		,[dailyWorth_last12Months]
		,[dailyWorth_last9Months]
		,[dailyWorth_last6Months]
		,[dailyWorth_Last4Months]
		,[dailyWorth_last3Months]
		,[dailyWorth_Last2Months]
		,[dailyWorth_lastMonth]
		,[dailyWorth_3MonthLGD]
		,[BingoTheo_YTD]
		,[BingoTheo_QTD]
		,[BingoTheo_Last36Months]
		,[BingoTheo_last24Months]
		,[BingoTheo_last18Months]
		,[BingoTheo_last12Months]
		,[BingoTheo_last9Months]
		,[BingoTheo_last6Months]
		,[BingoTheo_Last4Months]
		,[BingoTheo_last3Months]
		,[BingoTheo_Last2Months]
		,[BingoTheo_lastMonth]
		,[BingoTheo_3MonthLGD]
		,[MonthsPlayed_YTD]
		,[MonthsPlayed_QTD]
		,[MonthsPlayed_Last36Months]
		,[MonthsPlayed_last24Months]
		,[MonthsPlayed_last18Months]
		,[MonthsPlayed_last12Months]
		,[MonthsPlayed_last9Months]
		,[MonthsPlayed_last6Months]
		,[MonthsPlayed_last3Months]
		,[MonthsPlayed_Last4Months]
		,[MonthsPlayed_Last2Months]
		,[MonthsPlayed_lastMonth]
		,[MonthsPlayed_3MonthLGD]
		,[ADP_YTD]
		,[ADP_QTD]
		,[ADP_last36Months]
		,[ADP_last24Months]
		,[ADP_last18Months]
		,[ADP_last12Months]
		,[ADP_last9Months]
		,[ADP_last6Months]
		,[ADP_last4Months]
		,[ADP_last3Months]
		,[ADP_last2Months]
		,[ADP_lastMonth]
		,[ADP_3MonthLGD]
		,[ADT_GrossFP_YTD]
		,[ADT_GrossFP_QTD]
		,[ADT_GrossFP_last36Months]
		,[ADT_GrossFP_last24Months]
		,[ADT_GrossFP_last18Months]
		,[ADT_GrossFP_last12Months]
		,[ADT_GrossFP_last9Months]
		,[ADT_GrossFP_last6Months]
		,[ADT_GrossFP_last4Months]
		,[ADT_GrossFP_last3Months]
		,[ADT_GrossFP_last2Months]
		,[ADT_GrossFP_lastMonth]
		,[ADT_GrossFP_3MonthLGD]
		,[ADT_NetFP_YTD]
		,[ADT_NetFP_QTD]
		,[ADT_NetFP_last36Months]
		,[ADT_NetFP_last24Months]
		,[ADT_NetFP_last18Months]
		,[ADT_NetFP_last12Months]
		,[ADT_NetFP_last9Months]
		,[ADT_NetFP_last6Months]
		,[ADT_NetFP_last4Months]
		,[ADT_NetFP_last3Months]
		,[ADT_NetFP_last2Months]
		,[ADT_NetFP_lastMonth]
		,[ADT_NetFP_3MonthLGD]
		,[ADW_GrossFP_YTD]
		,[ADW_GrossFP_QTD]
		,[ADW_GrossFP_last36Months]
		,[ADW_GrossFP_last24Months]
		,[ADW_GrossFP_last18Months]
		,[ADW_GrossFP_last12Months]
		,[ADW_GrossFP_last9Months]
		,[ADW_GrossFP_last6Months]
		,[ADW_GrossFP_last4Months]
		,[ADW_GrossFP_last3Months]
		,[ADW_GrossFP_last2Months]
		,[ADW_GrossFP_lastMonth]
		,[ADW_GrossFP_3MonthLGD]
		,[ADW_NetFP_YTD]
		,[ADW_NetFP_QTD]
		,[ADW_NetFP_last36Months]
		,[ADW_NetFP_last24Months]
		,[ADW_NetFP_last18Months]
		,[ADW_NetFP_last12Months]
		,[ADW_NetFP_last9Months]
		,[ADW_NetFP_last6Months]
		,[ADW_NetFP_last4Months]
		,[ADW_NetFP_last3Months]
		,[ADW_NetFP_last2Months]
		,[ADW_NetFP_lastMonth]
		,[ADW_NetFP_3MonthLGD]
		,[AMP_YTD]
		,[AMP_QTD]
		,[AMP_last36Months]
		,[AMP_last24Months]
		,[AMP_last18Months]
		,[AMP_last12Months]
		,[AMP_last9Months]
		,[AMP_last6Months]
		,[AMP_last4Months]
		,[AMP_last3Months]
		,[AMP_last2Months]
		,[AMP_lastMonth]
		,[AMP_3MonthLGD]
		,[AMT_GrossFP_YTD]
		,[AMT_GrossFP_QTD]
		,[AMT_GrossFP_last36Months]
		,[AMT_GrossFP_last24Months]
		,[AMT_GrossFP_last18Months]
		,[AMT_GrossFP_last12Months]
		,[AMT_GrossFP_last9Months]
		,[AMT_GrossFP_last6Months]
		,[AMT_GrossFP_last4Months]
		,[AMT_GrossFP_last3Months]
		,[AMT_GrossFP_last2Months]
		,[AMT_GrossFP_lastMonth]
		,[AMT_GrossFP_3MonthLGD]
		,[AMT_NetFP_YTD]
		,[AMT_NetFP_QTD]
		,[AMT_NetFP_last36Months]
		,[AMT_NetFP_last24Months]
		,[AMT_NetFP_last18Months]
		,[AMT_NetFP_last12Months]
		,[AMT_NetFP_last9Months]
		,[AMT_NetFP_last6Months]
		,[AMT_NetFP_last4Months]
		,[AMT_NetFP_last3Months]
		,[AMT_NetFP_last2Months]
		,[AMT_NetFP_lastMonth]
		,[AMT_NetFP_3MonthLGD]
		,[AMV_Last36Months]
		,[AMV_Last24Months]
		,[AMV_Last18Months]
		,[AMV_Last12Months]
		,[AMV_Last9Months]
		,[AMV_Last6Months]
		,[AMV_Last4Months]
		,[AMV_Last3Months]
		,[AMV_Last2Months]
		,[AMV_LastMonth]
		,[AMV_3MonthLGD]
		,[AMW_GrossFP_YTD]
		,[AMW_GrossFP_QTD]
		,[AMW_GrossFP_last36Months]
		,[AMW_GrossFP_last24Months]
		,[AMW_GrossFP_last18Months]
		,[AMW_GrossFP_last12Months]
		,[AMW_GrossFP_last9Months]
		,[AMW_GrossFP_last6Months]
		,[AMW_GrossFP_last4Months]
		,[AMW_GrossFP_last3Months]
		,[AMW_GrossFP_last2Months]
		,[AMW_GrossFP_lastMonth]
		,[AMW_GrossFP_3MonthLGD]
		,[AMW_Net_YTD]
		,[AMW_Net_QTD]
		,[AMW_NetFP_last36Months]
		,[AMW_NetFP_last24Months]
		,[AMW_NetFP_last18Months]
		,[AMW_NetFP_last12Months]
		,[AMW_NetFP_last9Months]
		,[AMW_NetFP_last6Months]
		,[AMW_NetFP_last4Months]
		,[AMW_NetFP_last3Months]
		,[AMW_NetFP_last2Months]
		,[AMW_NetFP_lastMonth]
		,[AMW_NetFP_3MonthLGD]
		,p.PlayerTypeID
		,p.[PlayerTypeCode]
		,p.[PlayerTypeName]
		,award_FPUsed_YTD
		,award_FPUsed_QTD
		,award_FPUsed_Last36Months
		,award_FPUsed_last24Months
		,award_FPUsed_last18Months
		,award_FPUsed_last12Months
		,award_FPUsed_last9Months
		,award_FPUsed_last6Months
		,award_FPUsed_last3Months
		,award_FPUsed_Last4Months
		,award_FPUsed_Last2Months
		,award_FPUsed_lastMonth
		,award_FPUsed_3MonthLGD


		,firstPlayDate_YTD
		,firstPlayDate_QTD
		,firstPlayDate_Last36Months
		,firstPlayDate_last24Months
		,firstPlayDate_last18Months
		,firstPlayDate_last12Months
		,firstPlayDate_last9Months
		,firstPlayDate_last6Months
		,firstPlayDate_Last4Months
		,firstPlayDate_last3Months
		,firstPlayDate_Last2Months
		,firstPlayDate_lastMonth
		,firstPlayDate_3MonthLGD

		,lastPlayDate_YTD
		,lastPlayDate_QTD
		,lastPlayDate_Last36Months
		,lastPlayDate_last24Months
		,lastPlayDate_last18Months
		,lastPlayDate_last12Months
		,lastPlayDate_last9Months
		,lastPlayDate_last6Months
		,lastPlayDate_Last4Months
		,lastPlayDate_last3Months
		,lastPlayDate_Last2Months
		,lastPlayDate_lastMonth
		,lastPlayDate_3MonthLGD
	  
	  from 
		#SummedMarketingMetricsEXT a
	  left join 
		#UniqueDays b 
       on a.UniqueKey = b.UniqueKey
	  left join
			#MMGameTypePref c
	  on a.UniqueKey = c.UniqueKey
	  left join
			#FinalPreferences d
	  on a.UniqueKey = d.UniqueKey

	  left join
			##PlayerType p
	  on a.UniqueKey = p.UniqueKey

END
GO
**************************************************************************************************************************************/


