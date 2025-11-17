USE [iQ-Gaming]
GO

select
 CASt(convert(varchar(10), a.DATE_KEY) AS datetime)	AS gaming_date
,b.player_id
,a.[award_HotelReservations]
,a.[award_CompsUsed_Hotel_Finance]
,a.[award_CompsUsed_Hotel_Mktg]
,a.[award_CompsUsed_Hotel_Folio]
,a.[award_CompsUsed_Total_Finance]
,a.[award_CompsUsed_Total_Mktg]

from player.tab_daily_fact a (nolock)
inner JOIN tableau.player_dim b (nolock) on a.player_id = b.player_id and a.PLAYER_KEY = b.PLAYER_KEY

--where CASt(convert(varchar(10), a.DATE_KEY) AS datetime) BETWEEN '2025-08-24' AND '2025-08-26'
where CASt(convert(varchar(10), a.DATE_KEY) AS datetime) = '2025-08-25'

GO