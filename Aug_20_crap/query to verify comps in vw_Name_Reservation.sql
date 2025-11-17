USE [StayDWH]
GO

/****** Object:  View [dbo].[vw_Name_Reservation]    Script Date: 8/19/2025 1:25:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO












--CREATE VIEW [dbo].[vw_Name_Reservation] AS
SELECT DISTINCT
rs.date
  ,rv.id Reservation_id
----, rv.property_id
----, rv.tenant_id
----, rv.account_id
----, rv.allocation_id
--, rv.checkin_at AS [ACTUAL_CHECK_IN_DATE]
--, rv.checkout_at AS [ACTUAL_CHECK_OUT_DATE]
--, rv.arrival_date AS [ARRIVAL]
--, rv.early_check_in_time AS [ARRIVAL_TIME]
--, gp.group_code AS [BLOCK_CODE]
--, gp.group_name AS [BLOCK_DESCRIPTION]
--, rv.confirmation_code AS [CONFIRMATION_NO]
--, rv.departure_date AS [DEPARTURE]
--, rv.late_checkout_time AS [DEPARTURE_TIME]
--, g.[value] AS [EMAIL]
--, '' AS [EMAIL_YN]
--, g.gender AS [GENDER]
--, g.iso_code AS [GUEST_COUNTRY]
--, g.country AS [GUEST_COUNTRY_DESC]
--, rv.primary_guest_first_name AS [GUEST_FIRST_NAME]
--, rv.primary_guest_last_name AS [GUEST_NAME]
--, rv.create_time AS [INSERT_DATE]
--, '' AS [MAIL_YN]
--, ms.code AS [MARKET_CODE]
--, '' AS [MEMBERSHIP_EXPIRATION_DATE]
--, vs.code AS [MEMBERSHIP_LEVEL]
--, LTRIM(first_name)+' '+last_name AS [MEMBERSHIP_NAME_ON_CARD]
----, ISNULL(rv.player_id,ISNULL(rl.member_number,0)) AS [MEMBERSHIP_NUMBER]
--, IIF( LEN(IIF(ISNUMERIC(ISNULL(rv.player_id,ISNULL(rl.member_number,'0')))=1,ISNULL(rv.player_id,ISNULL(rl.member_number,'0')),'0')) > 10, '0', IIF(ISNUMERIC(ISNULL(rv.player_id,ISNULL(rl.member_number,'0')))=1,ISNULL(rv.player_id,ISNULL(rl.member_number,'0')),'0')) AS [MEMBERSHIP_NUMBER]
--, gt.[name] AS [MEMBERSHIP_TYPE]
--, ISNULL(rl.member_number,'') AS [NAME_MEMBERSHIP_ID]
--, vs.code AS [NAME_MEMBERSHIP_LEVEL]
--, IIF(ISNUMERIC(ISNULL(rv.player_id,ISNULL(rl.member_number,'0')))=1,ISNULL(rv.player_id,ISNULL(rl.member_number,'0')),'0') AS [NAME_MEMBERSHIP_NUMBER]
--, gt.[name] AS [NAME_MEMBERSHIP_TYPE]
--, DATEDIFF(DAY,rv.arrival_date,rv.departure_date) AS [NIGHTS]
--, '' AS [NO_OF_ROOMS]
--, sb.code AS [ORIGIN_OF_BOOKING]
--, cp.OFFER_STATUS
--, cp.OFFER_TYPE
--, cp.offer_code AS [PROMOTIONS]
--, rp.code [RATE_CODE]
--, rv.update_time AS [RESERVATION_DATE]
--, rv.tenant_id AS [RESORT]
--, rv.[status] AS [RESV_STATUS]
--, rm.room_number AS [ROOM]
--, rm.building_code AS [ROOM_RESORT]
----, rs.date AS [RATE_DATE]
--, ABS(ISNULL([sr].[ROOM_REV],0)) AS [Room_Revenue]
--, ABS(ISNULL([sr].[Food_Rev],0)) AS [FB_Revenue]
--, ABS(ISNULL([sr].[Misc_Rev],0)) AS [Misc_Revenue]
--, ISNULL(ABS([sr].[Total_Rev]),0) AS [Total_Revenue]
, ISNULL(sr.Room_comp,0) Room_Comp
, ISNULL(sr.Food_Comp,0) Food_Comp
, ISNULL(sr.Misc_Comp,0) Misc_Comp
--, ISNULL(sr.Tier_Discount,0) Tier_Discount
--, vs.[name] AS [VIP_DESC]
--, vs.[name] AS [VIP_NAME]
--, vs.code AS [VIP_STATUS]
--, '' as [TOTAL_NIGHTS]
--, '' as [TOTAL_STAY]
--, '' as [LAST_STAY]
--, '' as [TOTAL_NIGHTS_LASTYR]
--, '' as [TOTAL_STAY_LASTYR]
--, '' as [FIRST_STAY_YN]
--, IIF(rt2.type_code IS NULL, rt.type_code, rt2.type_code) AS [ROOM_CATEGORY_LABEL]
--, rs.actual_rate AS [MY_ROOM_RATE]
----, rs.OFFER_AMOUNT
--, rv.confirmation_code AS [RESV_NAME_ID]
--, IIF(rt2.name IS NULL, LEFT(rt.name,CHARINDEX(' ',rt.name)), rm.building_code) AS [ROOM_CLASS]
----, rm.building_code AS [ROOM_CLASS]
--, g.number AS [GUEST_PHONE]
--, g.phone_type AS [PHONE_TYPE]
--, rv.number_of_adults AS [ADULTS]
--, rv.number_of_children AS [CHILDREN]
----, iif(ag.non_registered=0,'Y','N') AS [ACCOMPANYING_YN]
--, '' AS [ACCOMPANYING_YN]
----, ag.name AS [ACCOMPANYING_NAMES]
--, '' AS [ACCOMPANYING_NAMES]
---- SELECT *

FROM dbo.reservations rv WITH (NOLOCK)

LEFT JOIN dbo.booked_reservation_details bd WITH (NOLOCK)
	ON rv.id=bd.reservation_id
LEFT JOIN dbo.room_types rt WITH (NOLOCK)
	ON bd.room_type_id = rt.id

LEFT JOIN dbo.allocations al WITH (NOLOCK)
	ON rv.allocation_id=al.id
LEFT JOIN dbo.vw_rooms rm 
	ON al.room_id=rm.id

LEFT JOIN dbo.room_types rt2 WITH (NOLOCK)
	ON rm.room_type_id = rt2.id

LEFT JOIN dbo.reservation_loyalties rl WITH (NOLOCK) 
	ON rv.id=CAST(rl.reservation_id AS VARCHAR(50))
LEFT JOIN dbo.vip_statuses vs WITH (NOLOCK) 
	ON rv.vip_status_id=vs.id
LEFT JOIN dbo.vw_guests g 
	ON rv.primary_guest_id=g.id
LEFT JOIN dbo.guest_types gt WITH (NOLOCK) 
	ON rv.guest_type_id=gt.id
--LEFT JOIN dbo.additional_guests ag WITH (NOLOCK)
--	ON rv.id=ag.reservation_id
LEFT JOIN dbo.market_segments ms WITH (NOLOCK) 
	ON rv.market_segment_id=ms.id
LEFT JOIN [dbo].[rate_snapshots] rs WITH (NOLOCK)
	ON rv.id=rs.reservation_id
LEFT JOIN dbo.rate_plans rp WITH (NOLOCK) 
	ON rs.rate_plan_id=rp.id 
LEFT JOIN [dbo].[vw_comp_offer_details] cp
	ON rs.reservation_id=cp.reservation_id AND rs.[date]=cp.offer_date

LEFT JOIN [dbo].[vw_Stay_Rev] sr
	ON rs.reservation_id=sr.reservation_id AND rs.[date]=sr.display_date

LEFT JOIN dbo.source_of_businesses sb WITH (NOLOCK) 
	ON rv.source_of_business_id=sb.id
LEFT JOIN dbo.groups gp WITH (NOLOCK) 
	ON rv.group_id=gp.id
WHERE rv.arrival_date > '2024-03-17'
--AND primary_guest_first_name = 'Robyn'
--AND rv.confirmation_code='MJFH2MG57'
--AND ISNULL(rv.player_id,'0') > '1'
--ORDER BY confirmation_no,rate_date

and rs.date BETWEEN '2025-08-28' AND '2025-08-28'

order by rs.date desc

/*
SELECT TOP 100 *   FROM [iQ-Gaming].[Opera_5_0].[NAME_RESERVATION] --WHERE CONFIRMATION_NO=1511813

SELECT TOP 100 * FROM [dbo].[Name_Reservation] --WHERE [RESV_NAME_ID] = '1511813'

SELECT TOP 100 * FROM [dbo].[rate_snapshots] rs WITH (NOLOCK) LEFT JOIN dbo.rate_plans rp WITH (NOLOCK) ON rs.rate_plan_id=rp.id WHERE OFFER_AMOUNT IS NOT NULL--reservation_id='0070fa00-7c26-430d-8376-9f806f61e7f8'
*/

GO


