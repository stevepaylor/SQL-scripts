


--Player worth in PLayer_DIM

select 

       [player_id],
       [player_account_number],
       [player_first_name],
       [player_last_name],
       [player_club_level],
       [player_host],
       ADP_3monthLGD,
       AMP_3monthLGD

into #Player_Worth
from [msbidb01dv].[vdw].[tableau].[player_dim]


--Hotel Room Stay

select distinct

       [nights],
       [MEMBERSHIP_NUMBER] as 'Acct',
       [ARRIVAL],
       [Departure],
       [NO_OF_ROOMS],
       [ORIGIN_OF_BOOKING],
       [PROMOTIONS],
       [RATE_CODE],
       [BLOCK_CODE],
       [BLOCK_DESCRIPTION],
       [RESERVATION_DATE],
       [ROOM_Category_Label],
       [ROOM_CLASS]

into #HotelRoom
FROM [msbidb01dv].[OperaDM].[dbo].[NAME_RESERVATION]
where (arrival between '2021-12-28' and '2021-12-31') and (departure between '2022-1-1' and '2022-1-4') and resv_status <> 'Cancelled' 

group by 

       [MEMBERSHIP_NUMBER],
       [ARRIVAL],
       [Departure],
       [nights],
       [NO_OF_ROOMS],
       [ORIGIN_OF_BOOKING],
       [PROMOTIONS],
       [RATE_CODE],
       [BLOCK_CODE],
       [BLOCK_DESCRIPTION],
       [RESERVATION_DATE],
       [ROOM_Category_Label],
       [ROOM_CLASS]

--Daily Facts info for Theo/Actual

select
       [player_account_number],
       [slot_theo_win],
       [table_theo_win],
       [other_theo_win],
       [slot_actual_win],
       [table_actual_win],
       [other_actual_win]

into #Daily_Facts
FROM [msbidb01dv].[vDW].[tableau].[player_daily_fact]
where [gaming_date] >= '2021-07-01'

--NYE Tag

Select distinct 

       PlayerID,
       TagCode

into #NYETAG
from [cmktdb13cpr].[cmp13].[dbo].[viewPlTagsViejas]
where TagCode = 'P2112NYEGALAQUAL'

--Full report with all temp tables into one
select 
       h.Acct as 'Account Number',
       pw.[player_first_name] 'First Name',
       pw.[player_last_name] 'Last Name',
       pw.[player_club_level] 'Tier',
       pw.[player_host] 'Host',

       format(pw.ADP_3monthLGD, 'C') 'ADP',
       format(pw.AMP_3monthLGD, 'C') 'AMP',
       format(sum(df.slot_theo_win + df.table_theo_win + df.other_theo_win), 'C') 'Total Theo',
       format(sum(df.slot_actual_win + df.table_actual_win + df.other_actual_win), 'C') 'Total Actual Win',
       convert(varchar, h.[ARRIVAL], 1) as 'Arrival Date',
       convert(varchar, h.[Departure], 1) as 'Departure Date',

       h.[nights] 'Number of Nights',
       h.[ROOM_Category_Label] 'Room Type',

       case when h.[PROMOTIONS] is null then '' else h.[promotions] end as 'Host that Comp''d Room',
       h.[RATE_CODE],

       case when tg.TagCode is not null then '' else 'No NYE Gala Tag' end as 'NYE Gala Tag',

       case when (pw.ADP_3monthLGD < 450 and h.[ROOM_CLASS] like 'WHS') then 'Not Eligible for Willows'
       when (pw.ADP_3monthLGD >= 450 and h.[ROOM_CLASS] like 'VCR') then 'Eligible for Willows'
       when (pw.ADP_3monthLGD < 200 and h.[ROOM_CLASS] like 'VCR') then 'Not Eligible for Viejas' else '' end 'Hotel Room Eligibility'


from #HotelRoom h
left join #Player_Worth pw on pw.player_Account_number = h.Acct
left join #Daily_Facts df on h.Acct = df.player_Account_number
left join #NYETAG tg on pw.player_id = tg.PlayerId
where pw.player_account_number is not null

group by 
       h.Acct,
       pw.[player_first_name],
       pw.[player_last_name],
       pw.[player_club_level],
       pw.[player_host],
       pw.ADP_3monthLGD,
       pw.AMP_3monthLGD,
       h.[nights],
       h.[ARRIVAL],
       h.[Departure],
       h.[PROMOTIONS],
       h.[RATE_CODE],
      h.[ROOM_Category_Label],
       h.[ROOM_CLASS],
       tg.TagCode
       
order by [Arrival Date]

drop table #Player_Worth
drop table #HotelRoom
drop table #NYETAG
drop table #Daily_Facts