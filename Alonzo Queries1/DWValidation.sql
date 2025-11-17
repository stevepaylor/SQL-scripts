select player_club_level, count(*) as TotalCountByGamingDTDW from [tableau].[player_daily_fact] pdf
where gaming_date='2021-02-25 00:00:00.000' and gaming_days=1
group by player_club_level
order by player_club_level asc

Go 

select ClubStatus, count(*) as TotalCountByGamingDTCMP from  cmktdb13cpr.cmp13.[dbo].[tTrip] tt inner join cmktdb13cpr.cmp13.[dbo].[viewplayersViejas] vpv
on tt.playerid = vpv.playerid
where tripDt='2021-02-25' and actionDays=1
group by ClubStatus
order by ClubStatus asc




--- DW
select gaming_days, * from [tableau].[player_daily_fact] pdf
where gaming_date='2021-02-25 00:00:00.000' and player_club_level='GOLD'
---group by player_club_level
---order by player_club_level asc
and player_account_number not in 
(
select acct from  cmktdb13cpr.cmp13.[dbo].[tTrip] tt inner join cmktdb13cpr.cmp13.[dbo].[viewplayersViejas] vpv
on tt.playerid = vpv.playerid
where tripDt='2021-02-25' and ClubStatus='GOLD'
)

Go 

--- CMP
select top 100 * from  cmktdb13cpr.cmp13.[dbo].[tTrip] tt inner join cmktdb13cpr.cmp13.[dbo].[viewplayersViejas] vpv
on tt.playerid = vpv.playerid
where tripDt='2021-02-25' and ClubStatus='TRIBAL_GOLD'
---group by ClubStatus
---order by ClubStatus asc



select top 100 * from cmktdb13cpr.cmp13.[dbo].ttrip
where  tripDt='2021-02-25'


