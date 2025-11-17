


  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 10000 
          --convert(varchar,[DEPARTURE], 101)
         [RESORT]
      ,[RESV_STATUS]
      ,convert(varchar,[ARRIVAL],101) As Arrival
      ,[ARRIVAL_TIME]
      ,[NIGHTS]
      ,convert(varchar,[DEPARTURE],101) As Departure
      ,[DEPARTURE_TIME]
      ,[GUEST_NAME]
      ,[GUEST_FIRST_NAME]
      ,[ACTUAL_CHECK_IN_DATE]
      ,[ACTUAL_CHECK_OUT_DATE]
      ,[MEMBERSHIP_NUMBER]
      ,[MARKET_CODE]
      ,[RATE_CODE]
      ,[ROOM_REVENUE]
      ,[TOTAL_REVENUE]
      ,[EMAIL]
      ,[GENDER]
      ,[ROOM_RESORT]
      ,[CONFIRMATION_NO]
      ,[ROOM]
      ,[ROOM_CATEGORY_LABEL]
      , convert(varchar,[INSERT_DATE],101) as [RESERVATION_DATE]
      , DATEDIFF(dd,[INSERT_DATE],[ARRIVAL]) as [Booking Window]
      ,[Resv_Name_ID] AS h_reservationID   
      , vp.player_account_number
	  ---,(Select max(gamingdt) as LastContacted from cmktdb13cpr.cmp13.dbo.tplayernote where ref1 like 'Contacted%' and IsVoid=0 and playerid=vp.playerid) as LastContacted
	  ,vp.player_club_level
	  ,vp.player_host
	  ,vp.player_geo_distance
	  ,vp.player_birthdate
	  ,vp.player_isbanned
	  ,vp.player_isclubhold
	  ,vp.ADP_3monthLGD
	  ,vp.AMP_3monthLGD
      
       FROM [NAME_RESERVATION] r
       left join  [vDW].[tableau].[player_dim] vp on vp.player_account_number = r.NAME_MEMBERSHIP_NUMBER
  ---where convert(varchar,[DEPARTURE], 101)  > '03/12/2017' and RESV_STATUS='CHECKED OUT' and ROOM<8999
  where [ARRIVAL]  >=convert(varchar,getdate()-8, 101) and  [ARRIVAL]<=convert(varchar,getdate(), 101)
  and (vp.player_host LIKE +'%' +  @Host + '%') AND (vp.player_club_level LIKE + '%' + @ClubLevel + '%')


