with pre_agg as (
	select
	a.PLAYER_KEY,
	min(b.config_start)																							as DateRangeStart,
	min(b.config_end)																							as DateRangeEnd,
	min(a.DATE_KEY)																							as playerfirstdate,
	max(a.DATE_KEY)																							as playerlastdate,
	sum(a.slot_theo_win)																						as Slot_Theo,
	sum(a.table_theo_win)																						as Table_Theo,
	sum(a.other_theo_win)																						as Bingo_Theo,
	sum(a.slot_theo_win + a.table_theo_win + a.other_theo_win)																			as Total_Theo,
	sum(a.slot_theo_win + a.table_theo_win + a.other_theo_win) - sum(a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner)												as NetTheo,
	sum(a.slot_actual_win + a.table_actual_win + a.other_actual_win) - sum(a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner)												as NetActualWin,
	sum(a.daily_worth)																							as worth_Gross,
	sum(gaming_days)																							as visits,
	sum(award_FreePlay_Used)																						as FP,
	sum(a.slot_theo_win + a.table_theo_win + a.other_theo_win)/sum(gaming_days)																	as ADT_GrossFP,
	(sum(a.slot_theo_win + a.table_theo_win + a.other_theo_win) - sum(a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner + a.award_PromoChipsAwarded + a.award_CashAwarded_Bingo))/sum(gaming_days)				as ADT_NetFP,
	sum(a.daily_worth)/sum(gaming_days)																					as ADW_GrossFP,
	sum(a.daily_worth - ((a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner) + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo])) / SUM(case when a.slot_theo_win + a.table_theo_win + a.other_theo_win > 0 then 1 else null end)	as ADW_NetFP,
	sum(a.daily_worth - ((a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner) + (a.award_CompsUsed_Other + a.award_CompsUsed_FB + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]))) / sum(gaming_days)			as ADP,
	sum(gaming_days)/count(distinct left(a.DATE_KEY, 6))																			as AMV,
	sum(a.slot_theo_win + a.table_theo_win + a.other_theo_win)/count(distinct left(a.DATE_KEY, 6))															as AMT_GrossFP,
	(sum(a.slot_theo_win + a.table_theo_win + a.other_theo_win) - sum(a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner + a.award_PromoChipsAwarded + a.award_CashAwarded_Bingo )) / count(distinct left(a.DATE_KEY, 6))		as AMT_NetFP,
	sum(a.daily_worth)/count(distinct left(a.DATE_KEY, 6))																			as AMW_Gross,
	sum(a.daily_worth - ((a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner) + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo])) / count(distinct left(a.DATE_KEY, 6))							as AMW_NetFP,
	sum(a.daily_worth - ((a.award_FPAwarded_Total - a.award_FPAwarded_PromoWinner) + (a.award_CompsUsed_Other + a.award_CompsUsed_FB + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]))) / count(distinct left(a.DATE_KEY, 6))	as AMP
	from player.tab_daily_fact a
	inner join config.tab_general_dates b
	on b.config_name = '12 Months'
	and b.config_grain = 'month'
	and a.DATE_KEY between b.config_start and b.config_end
	where a.gaming_days > 0
	group by a.PLAYER_KEY
	having sum(a.slot_theo_win + a.table_theo_win + a.other_theo_win) > 0
)
select a.*, b.netfp_category as ADW_NetFP_Category, c.netfp_category as AMW_NetFP_Category
from pre_agg a
left join player.v_netfp_category_ADW b
on cast(round(a.ADW_NetFP, 0) as int) between b.netfp_min and b.netfp_max
inner join player.v_netfp_category_AMW c
on cast(round(a.AMW_NetFP, 0) as int) between c.netfp_min and c.netfp_max