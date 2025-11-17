-- PACKAGE - 03_etl_player_rating_fact

-------------------------------
-- load slot pull
-------------------------------
select track_date
from config.tab_datetime_tracker (nolock)
where track_tab_name = 'tSlotRating'
and track_ssis_name = 'etl_player_rating_fact'

-------------------------------
-- load table pull
-------------------------------
select track_date
from config.tab_datetime_tracker (nolock)
where track_tab_name = 'tTableRating'
and track_ssis_name = 'etl_player_rating_fact'

-------------------------------
-- load sports pull
-------------------------------
select track_date
from config.tab_datetime_tracker (nolock)
where track_tab_name = 'tSportsRating'
and track_ssis_name = 'etl_player_rating_fact'

-------------------------------
-- create up
-------------------------------
IF  EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[player].[up_rating_fact]'))
 DROP TABLE [player].[up_rating_fact]
GO
CREATE TABLE [player].[up_rating_fact](
 [DATE_KEY] [int] NOT NULL,
 [PLAYER_KEY] [int] NOT NULL,
 [GEO_KEY] [int] NOT NULL,
 [MACHINE_KEY] [int] NOT NULL,
 [TABLE_KEY] [int] NOT NULL,
 [HOUR_KEY] [int] NOT NULL,
 [player_id] [int] NOT NULL,
 [rating_type] [nvarchar](25) NOT NULL,
 [rating_id] [bigint] NOT NULL,
 [rating_locn_id] [int] NOT NULL,
 [rating_void] [bit] NOT NULL,
 [rating_shift] [int] NULL,
 [rating_minutes_played] [int] NOT NULL,
 [rating_buyin_cash] [money] NOT NULL,
 [rating_buyin_credit] [money] NOT NULL,
 [rating_buyin_chips] [money] NOT NULL,
 [rating_buyin_promo] [money] NOT NULL,
 [rating_buyin_Ecredit] [money] NOT NULL,
 [rating_plays] [money] NOT NULL,
 [rating_total_bet] [money] NOT NULL,
 [rating_paid_out] [money] NOT NULL,
 [rating_theo_win] [money] NOT NULL,
 [rating_actual_win] [money] NOT NULL,
 [rating_jackpot_win] [money] NOT NULL,
 [slot_number][int] null,
 [game_id][int]null
) ON [PRIMARY]
GO
create clustered index CIndex_DATE_KEY on player.up_rating_fact(DATE_KEY)

--=============================================
-- MAIN (DATA FLOW)
--=============================================

-------------------------------
-- tslotrating
-------------------------------
select
  cast(convert(nvarchar(10)
, GamingDt, 112) as int) as DATE_KEY
, datepart(HH, RatingStartDtm) as HOUR_KEY
, PlayerId as player_id
, cast('Slot' as nvarchar(25)) as rating_type
, TranID as rating_id
, LocnID as rating_locn_id
, [Shift] as rating_shift
, RatingPeriodMinutes as rating_minutes_played
, CashBuyIn as rating_buyin_cash
, CreditBuyIn as rating_buyin_credit
, ChipBuyIn as rating_buyin_chips
, PromoBuyIn as rating_buyin_promo
, ECreditBuyIn as rating_buyin_Ecredit
, Plays as rating_plays
, Bet as rating_total_bet
, PaidOut as rating_paid_out
, TheorWin as rating_theo_win
, CasinoWin as rating_actual_win
, JackPot as rating_jackpot_win
, IsVoid as rating_void

from dbo.tSlotRating (nolock) 
where ModifiedDtm >= ?

-------------------------------
-- tTableRating
-------------------------------
UNION ALL

select
  cast(convert(nvarchar(10)
, GamingDt, 112) as int) as DATE_KEY
, datepart(HH, RatingStartDtm) as HOUR_KEY
, PlayerId as player_id
, cast('Table' as nvarchar(25))	as rating_type
, TranID as rating_id
, LocnID as rating_locn_id
, [Shift] as rating_shift
, RatingPeriodMinutes as rating_minutes_played
, CashBuyIn	as rating_buyin_cash
, CreditBuyIn as rating_buyin_credit
, ChipBuyIn	as rating_buyin_chips
, PromoBuyIn as rating_buyin_promo
, ECreditBuyIn as rating_buyin_Ecredit
, Plays	as rating_plays
, Bet as rating_total_bet
, PaidOut as rating_paid_out
, TheorWin as rating_theo_win
, CasinoWin	as rating_actual_win
, cast(0 as money) as rating_jackpot_win
, IsVoid as rating_void
, GameId as game_id

from dbo.tTableRating (nolock) 
where ModifiedDtm >= ?

-------------------------------
-- tSportsRating
-------------------------------
UNION ALL

select
cast(convert(nvarchar(10), GamingDt, 112) as int)		as DATE_KEY,
datepart(HH, RatingStartDtm)				as HOUR_KEY,
PlayerId						as player_id,
cast('Other' as nvarchar(25))				as rating_type,
TranID						as rating_id,
LocnID						as rating_locn_id,
[Shift]						as rating_shift,
RatingPeriodMinutes					as rating_minutes_played,
CashBuyIn					as rating_buyin_cash,
CreditBuyIn					as rating_buyin_credit,
ChipBuyIn						as rating_buyin_chips,
PromoBuyIn					as rating_buyin_promo,
ECreditBuyIn					as rating_buyin_Ecredit,
Plays						as rating_plays,
Bet						as rating_total_bet,
PaidOut						as rating_paid_out,
TheorWin						as rating_theo_win,
CasinoWin					as rating_actual_win,
cast(0 as money)					as rating_jackpot_win,
IsVoid						as rating_void
from dbo.tSportsRating (nolock) 
where ModifiedDtm >= ?

-- the above three data flows are unioned into the next task

-------------------------------
-- player key (lookup match)
-------------------------------
select a.PLAYER_KEY, b.GEO_KEY, a.player_id
from player.tab_player_dim a (nolock)
left join player.tab_geo_dim b (nolock)
on case when len(a.player_zip) > 5 then substring(a.player_zip, 1, 5) else a.player_zip end = b.geo_zip

-------------------------------
-- slot location (lookup match)
-------------------------------
select LocnId, cast(right(LocnCode, 5) as int) as slot_number, cast('Slot' as nvarchar(25)) as rating_type
from dbo.tLocn (nolock)
where isnumeric(right(LocnCode, 5)) = 1
and LocnType = 'MA'

-------------------------------
-- machine key (lookup match)
-------------------------------
select MACHINE_KEY, slot_number
from slot.tab_machine_dim (nolock)

-------------------------------
-- isnull
-------------------------------
-- cleans up null values of keys

-------------------------------
-- exists (lookup match)
-------------------------------
select rating_id
from player.tab_rating_fact (nolock)

-------------------------------
-- insert new
-------------------------------
-- Fast Load into player.tab_rating_fact

-------------------------------
-- insert up
-------------------------------
-- Fast Load into player.up_rating_fact

-------------------------------
-- update
-------------------------------
update a
set 
DATE_KEY  = b.DATE_KEY,
PLAYER_KEY  = b.PLAYER_KEY,
GEO_KEY  = b.GEO_KEY,
MACHINE_KEY  = b.MACHINE_KEY,
TABLE_KEY  = b.TABLE_KEY,
HOUR_KEY  = b.HOUR_KEY,
player_id   = b.player_id,
rating_type  = b.rating_type,
rating_id   = b.rating_id,
rating_locn_id  = b.rating_locn_id,
rating_void  = b.rating_void,
rating_shift  = b.rating_shift,
rating_minutes_played = b.rating_minutes_played,
rating_buyin_cash  = b.rating_buyin_cash,
rating_buyin_credit  = b.rating_buyin_credit,
rating_buyin_chips  = b.rating_buyin_chips,
rating_buyin_promo  = b.rating_buyin_promo,
rating_buyin_Ecredit = b.rating_buyin_Ecredit,
rating_plays  = b.rating_plays,
rating_total_bet  = b.rating_total_bet,
rating_paid_out  = b.rating_paid_out,
rating_theo_win  = b.rating_theo_win,
rating_actual_win  = b.rating_actual_win,
rating_jackpot_win  = b.rating_jackpot_win,
slot_number = b.slot_number,
game_id = b.game_id,
dw_timestamp  = getdate()
from player.tab_rating_fact a (nolock)
inner join player.up_rating_fact b (nolock)
on a.rating_id = b.rating_id

-------------------------------
-- drop up
-------------------------------
IF  EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[player].[up_rating_fact]'))
 DROP TABLE [player].[up_rating_fact]
GO

-------------------------------
-- update dates
-------------------------------
update a
set track_date = dateadd(mi, -10, getdate())
from config.tab_datetime_tracker a (nolock)
where track_ssis_name = 'etl_player_rating_fact'

-------------------------------
-- update machine
-------------------------------
exec player.proc_update_tab_rating_fact_MACHINE_KEY

--===========================================================================================
create procedure [player].[proc_update_tab_rating_fact_MACHINE_KEY]
as

with machines as (
 select MACHINE_KEY, slot_number, ACNF_LOCATION, START_DATE_KEY, END_DATE_KEY,
 row_number() over(partition by slot_number order by ACST_SHORT_NAME desc, ACOP_UPDATED_TS desc, MACHINE_KEY desc) as row_num
 from slot.tab_machine_dim (nolock)
)
select *
into #machines
from machines
where row_num = 1

create index NCIndex_temp on #machines(slot_number, START_DATE_KEY, END_DATE_KEY) include(MACHINE_KEY)

select LocnId, MachStand, cast(right(LocnCode, 5) as int) as slot_number 
into #locations
from [CMKTDB13CPR].CMP13.dbo.tLocn
where isnumeric(right(LocnCode, 5)) = 1 and LocnType = 'MA'

select a.rating_id, b.MACHINE_KEY, a.DATE_KEY
into #updates
from player.tab_rating_fact a (nolock)
inner join #locations l
on a.rating_locn_id = l.LocnId
inner join #machines b (nolock)
on a.slot_number = b.slot_number
and l.MachStand = b.ACNF_LOCATION
and a.DATE_KEY between b.START_DATE_KEY and b.END_DATE_KEY
where a.slot_number <> 0
and a.MACHINE_KEY <> b.MACHINE_KEY

update a
set MACHINE_KEY = b.MACHINE_KEY
from player.tab_rating_fact a with (nolock, index(CIndex_DATE_KEY))
inner join #updates b
on a.rating_id = b.rating_id
and a.DATE_KEY = b.DATE_KEY

drop table #updates, #machines, #locations
GO
--===========================================================================================

-------------------------------
-- update table
-------------------------------
update a
set TABLE_KEY = b.TABLE_KEY, dw_timestamp = getdate()
from player.tab_rating_fact a (nolock)
inner join table_games.tab_table_dim b (nolock)
on a.rating_locn_id = b.table_locn_id
and a.game_id = b.table_game_id
where a.rating_type = 'Table'
and a.TABLE_KEY <> b.TABLE_KEY
