USE [iQ-Gaming]
GO

/****** Object:  View [Opera_5_0].[vHotel2]    Script Date: 9/20/2024 3:09:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER   VIEW [Opera_5_0].[vHotel2] AS

SELECT r.RESORT as h_resort
      ,r.RESV_STATUS as h_reservationStatus
      ---,rn.BUSINESS_DATE as 'h_stayDate'
	  ,Case when  rn.BUSINESS_DATE is NULL 
			then convert(varchar,ARRIVAL,101)
			else rn.BUSINESS_DATE
		END
		as h_stayDate
	  ,Case when rn.RESV_STATUS is NULL 
			then r.RESV_STATUS 
			else rn.RESV_STATUS
		END
		as hd_reservationStatus 
      ,convert(varchar,ARRIVAL,101) As h_arrivalDate
      ,ARRIVAL_TIME As h_arrivalTime
      ,r.NIGHTS as h_numberNights
      ,convert(varchar,DEPARTURE,101) As h_departureDate
      ,DEPARTURE_TIME as h_departureTime
      ,GUEST_NAME as h_guestName
      ,GUEST_FIRST_NAME as h_guestFirstName
      ,ACTUAL_CHECK_IN_DATE as h_actualCheckinDate
      ,ACTUAL_CHECK_OUT_DATE as h_actualCheckoutDate
      ,MEMBERSHIP_NUMBER as h_membershipNumber
      ,MEMBERSHIP_TYPE as h_membershipType
      ,MEMBERSHIP_LEVEL as h_membershipLevel
      ,rn.MARKET_CODE as hd_marketCode
      ,rn.RATE_CODE as hd_rateCode
      --,RESERVATION_DATE
      ---,cast(rn.ROOM_REVENUE/iif(NIGHTS=0,1,NIGHTS) as money)  as h_roomRevenue
	  ,rn.ROOM_REVENUE as hd_roomRevenue
	  ,rn.FOOD_REVENUE as hd_foodRevenue
	  ,rn.PACKAGE_ROOM_REVENUE as hd_packageRoomRevenue
	  ,rn.PACKAGE_FOOD_REVENUE as hd_packageFoodRevenue
	  ,rn.TOTAL_ROOM_TAX as hd_totalRoomTax
	  ,rn.TOTAL_FOOD_TAX as hd_totalFoodTax
	  ,rn.TOTAL_PACKAGE_REVENUE as hd_totalPackageRevenue
	  ,rn.TOTAL_REVENUE as hd_totalRevenue
	  ,rn.TOTAL_TAX as hd_totalTax
	  ,rn.CASH_ROOM_REVENUE as hd_cashRoomRevenue
	  ,rn.COMP_ROOM_REVENUE as hd_compRoomRevenue
      ,r.EMAIL as h_email
      ---,ACTIVE_YN
      ,r.VIP_STATUS as h_vipStatus
      ,VIP_NAME as h_vipName
      --,VIP_DESC
      --,NAME_MEMBERSHIP_NUMBER
      --,NAME_MEMBERSHIP_TYPE
      ,NAME_MEMBERSHIP_LEVEL as h_membershipLevelName
      ,GENDER as h_gender
      --,NAME_MEMBERSHIP_ID
      --,MEMBERSHIP_EXPIRATION_DATE
      --,MEMBERSHIP_NAME_ON_CARD
      --,EMAIL_YN
      --,MAIL_YN
      ,ROOM_RESORT as h_roomResort
      ,CONFIRMATION_NO as h_confirmationNo
      --,GUEST_COUNTRY
      --,GUEST_COUNTRY_DESC
      ,rn.ROOM as hd_room
      ,ROOM_CATEGORY_LABEL as h_roomCategoryLabel
      ,MY_ROOM_RATE as h_myRoomRate
      ,NO_OF_ROOMS as h_numberRooms
	  ,BLOCK_CODE as h_blockCode
      ,BLOCK_DESCRIPTION as h_blockDescription
    , ORIGIN_OF_BOOKING as h_originOfBooking
    , PROMOTIONS as h_promotions
    , convert(varchar,r.INSERT_DATE,101) as h_reservationDate
    ---, cast(FB_REVENUE/iif(NIGHTS=0,1,NIGHTS) as money) as h_fbRevenue
	, rn.GUEST_FB_REVENUE as h_fbRevenue
    , DATEDIFF(dd,r.INSERT_DATE,ARRIVAL) as h_bookingWindow
    ,TOTAL_NIGHTS as h_totalNights
    ,TOTAL_STAY as h_totalStay
    ,LAST_STAY  as h_lastStay
    ,TOTAL_NIGHTS_LASTYR as h_totalNightsLastYear
    ,TOTAL_STAY_LASTYR as h_totalStayLastYear
    ,FIRST_STAY_YN  as h_firstStayYN
    ,r.Resv_Name_ID AS h_reservationID
    ,rn.ROOM_CLASS as hd_roomClass
    ,CASE
          WHEN left(ROOM_CATEGORY_LABEL,1) ='W' then 'Willows'
          ELSE 'Viejas'
          END
    As 'h_hotelName'  

         --,isnull((select SUM(slot_theo_win+table_theo_win+ other_theo_win) from tableau.player_daily_fact where Gaming_date between convert(varchar,r.ARRIVAL,101) and convert(varchar,r.DEPARTURE,101)  and player_account_number=r.MEMBERSHIP_NUMBER group by tableau.player_daily_fact.player_account_number),0) as StayTheoWIN
         ,isnull(b.theo_win, 0) as h_stayTheoWIN

         --,isnull((select SUM(slot_actual_win+table_actual_win+ other_actual_win) from tableau.player_daily_fact where Gaming_date between convert(varchar,getdate(),101) and convert(varchar,getdate(),101)  and player_account_number=r.MEMBERSHIP_NUMBER group by tableau.player_daily_fact.player_account_number),0) as ActualWIN
         ,isnull(b.actual_win, 0) as h_stayActualWIN

         ,isnull(c.ADT_win,0) as h_guestADT6Months
         ,isnull(d.ADT_win,0) as h_guestADT12Months
         ,isnull(f.ADT_win,0) as h_guestADT18Months


         ,isnull(c.ADA_win,0) as h_guestADA6Months
         ,isnull(d.ADA_win,0) as h_guestADA12Months
         ,isnull(f.ADA_win,0) as h_guestADA18Months

         ,CASE 
                WHEN rn.MARKET_CODE In  ('CP', 'CR', 'DC', 'DR', 'RC', 'PC', 'EX', 'EC', 'TR', 'TC', 'PR', 'CE') then 'CAS'
                WHEN rn.MARKET_CODE In  ('RN', 'RA', 'GR', 'RS' ) then 'GEN'
                WHEN rn.MARKET_CODE In  ('GB', 'GC', 'GA', 'GP', 'GV', 'GL', 'GW', 'GS' ) then 'GRP'
                WHEN rn.MARKET_CODE In  ('AR', 'HSE', 'PSBY') then 'INT'
                ELSE ''
                END
                As 'hd_marketGroup'


       ,isnull(b.theo_win, 0)/nullif(r.NIGHTS, 0) as 'h_theoPerNight'
       ,isnull(b.actual_win, 0)/nullif(r.NIGHTS, 0) as 'h_actualPerNight'

       --,0 as 'h_theoPerNight'
       --,0 as 'h_actualPerNight'
       
	   --- Check on this 
	   ---,rn.RESV_INDX as 'h_dateIndex'


       ,r.GUEST_PHONE as 'h_guestPhoneNumber'
       ,r.PHONE_TYPE as 'h_guestPhoneType'
       ,vp.*


       FROM Opera_5_0.NAME_RESERVATION r
       ---inner join Opera_5_0.Reservations rn on r.RESV_NAME_ID = rn.RESV_NAME_ID
	   left join Opera_5_0.OBI_RESERVATION_STAT_DAILY rn on r.RESV_NAME_ID = rn.RESV_NAME_ID
       left join  tableau.player_dim vp on vp.player_account_number = r.NAME_MEMBERSHIP_NUMBER
       outer apply player.hotel_play(vp.PLAYER_KEY, cast(convert(varchar(10), r.ARRIVAL, 112) as int), cast(convert(varchar(10), r.DEPARTURE, 112) as int)) b
       outer apply player.hotel_play(vp.PLAYER_KEY, cast(convert(varchar(10), dateadd(MM, -6, r.ARRIVAL), 112) as int), cast(convert(varchar(10), r.DEPARTURE, 112) as int)) c
       outer apply player.hotel_play(vp.PLAYER_KEY, cast(convert(varchar(10), dateadd(MM, -12, r.ARRIVAL), 112) as int), cast(convert(varchar(10), r.DEPARTURE, 112) as int)) d
       outer apply player.hotel_play(vp.PLAYER_KEY, cast(convert(varchar(10), dateadd(MM, -18, r.ARRIVAL), 112) as int), cast(convert(varchar(10), r.DEPARTURE, 112) as int)) f

GO


