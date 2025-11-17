USE [StayDWH]
GO

/****** Object:  View [dbo].[vw_Stay_Rev]    Script Date: 8/4/2025 1:27:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vw_Stay_Rev] AS

SELECT DISTINCT sr.Reservation_ID
			, sr.Account_ID
			, rv.Confirmation_Code
			, ISNULL(rv.player_id,rl.member_number) Acct
			, sr.Display_Date
			, SUM(sr.Room_Rev) Room_Rev
			, SUM(sr.Room_Comp) Room_Comp
			, SUM(sr.Food_Rev) Food_Rev
			, SUM(sr.Food_Comp) Food_Comp
			, SUM(sr.Misc_Rev) Misc_Rev
			, SUM(sr.Misc_Comp) Misc_Comp
			, SUM(sr.Tier_Discount) Tier_Discount
			, SUM(sr.Room_rev + sr.Food_Rev + sr.Misc_Rev) Total_Rev
			, SUM(sr.Room_Comp + sr.Food_Comp + sr.Misc_Comp) Total_Comp
FROM (
		--
		-- Hotel Room
		--
		SELECT DISTINCT Reservation_ID, Account_ID, display_date, AMOUNT AS Room_Rev, 0 Room_Comp, 0 Food_Rev, 0 Food_Comp, 0 Misc_Rev, 0 Misc_Comp, 0 Tier_Discount
		-- SELECT *
		FROM [dbo].[line_items] WITH (NOLOCK)
		WHERE ledger_id='GUEST' AND category_id='b8d4a856-e2a8-4f4b-b6a0-56d08f46c295'
		--AND reservation_id='fde8c41c-d7fc-442c-b130-7aaa960b07a1'
		AND display_date > '2024-03-17'
		UNION ALL
		SELECT DISTINCT Reservation_ID, l.Account_ID, display_date, 0 Room_Rev, AMOUNT AS Room_Comp, 0 Food_Rev, 0 Food_Comp, 0 Misc_Rev, 0 Misc_Comp, 0 Tier_Discount
		-- SELECT TOP 1000 *
		FROM [dbo].[line_items] l WITH (NOLOCK)
		LEFT JOIN [dbo].[folios] f WITH (NOLOCK) ON l.folio_id=f.id
		WHERE category_id='b8d4a856-e2a8-4f4b-b6a0-56d08f46c295' AND f.name='Comp Folio' AND reason='comp'
		--AND reservation_id='fde8c41c-d7fc-442c-b130-7aaa960b07a1'
		AND display_date > '2024-03-17'
		UNION ALL
		--
		-- Food and Beverages
		--
		SELECT DISTINCT Reservation_ID, Account_ID, display_date, 0 Room_Rev, 0 Room_Comp, AMOUNT AS Food_Rev, 0 Food_Comp, 0 Misc_Rev, 0 Misc_Comp, 0 Tier_Discount
		-- SELECT *
		FROM [dbo].[line_items] WITH (NOLOCK)
		WHERE ledger_id='GUEST' AND category_id='40d46e47-ef46-4d62-957b-bdbb9e2fbaa6'
		--AND accounting_item_id NOT IN('7be1e924-149b-4d0c-a9a0-f050325e003a') -- Tier Discount 7be1e924-149b-4d0c-a9a0-f050325e003a
		--AND reservation_id='fde8c41c-d7fc-442c-b130-7aaa960b07a1'
		AND display_date > '2024-03-17'
		UNION ALL
		SELECT DISTINCT Reservation_ID, l.Account_ID, display_date, 0 Room_Rev, 0 Room_Comp, 0 Food_Rev, AMOUNT AS Food_Comp, 0 Misc_Rev, 0 Misc_Comp, 0 Tier_Discount
		-- SELECT TOP 1000 *
		FROM [dbo].[line_items] l WITH (NOLOCK)
		LEFT JOIN [dbo].[folios] f WITH (NOLOCK) ON l.folio_id=f.id
		WHERE category_id='40d46e47-ef46-4d62-957b-bdbb9e2fbaa6' AND f.name='Comp Folio' AND reason='comp'
		--AND reservation_id='fde8c41c-d7fc-442c-b130-7aaa960b07a1'
		AND display_date > '2024-03-17'
		UNION ALL
		--
		-- Misc Charges
		--
		SELECT DISTINCT Reservation_ID, Account_ID, display_date, 0 Room_Rev, 0 Room_Comp, 0 Food_Rev, 0 Food_Comp, AMOUNT AS Misc_Rev, 0 Misc_Comp, 0 Tier_Discount
		-- SELECT *
		FROM [dbo].[line_items] WITH (NOLOCK)
		WHERE ledger_id='GUEST' AND category_id='6c27156d-41fb-47f7-918e-20bd8d06523f'
		--AND accounting_item_id NOT IN('7be1e924-149b-4d0c-a9a0-f050325e003a') -- Tier Discount 7be1e924-149b-4d0c-a9a0-f050325e003a
		--AND reservation_id='57587b7c-348c-4dc2-92b3-1cde6c10ea34'
		AND display_date > '2024-03-17'
		UNION ALL
		SELECT DISTINCT Reservation_ID, l.Account_ID, display_date, 0 Room_Rev, 0 Room_Comp, 0 Food_Rev, 0 Food_Comp, 0 Misc_Rev, AMOUNT AS Misc_Comp, 0 Tier_Discount
		-- SELECT TOP 1000 *
		FROM [dbo].[line_items] l WITH (NOLOCK)
		LEFT JOIN [dbo].[folios] f WITH (NOLOCK) ON l.folio_id=f.id
		WHERE category_id='6c27156d-41fb-47f7-918e-20bd8d06523f' AND f.name='Comp Folio' AND reason='comp'
		--AND reservation_id='74176317-bb3b-4107-8323-25708b26e94e'
		AND display_date > '2024-03-17'
		UNION ALL
		--
		-- Tier Discounts
		--
		SELECT DISTINCT Reservation_ID, l.Account_ID, display_date, 0 Room_Rev, 0 Room_Comp, 0 Food_Rev, 0 Food_Comp, 0 Misc_Rev, 0 Misc_Comp, AMOUNT AS Tier_Discount
		-- SELECT TOP 1000 *
		FROM [dbo].[line_items] l WITH (NOLOCK)
		WHERE ledger_id='GUEST' AND [description] = 'Tier Discount'-- accounting_item_id='7be1e924-149b-4d0c-a9a0-f050325e003a' 
		--AND reservation_id='74176317-bb3b-4107-8323-25708b26e94e'
		AND display_date > '2024-03-17'
) sr
LEFT JOIN [dbo].[reservations] rv WITH (NOLOCK) on sr.Reservation_ID=rv.id
LEFT JOIN [dbo].[reservation_loyalties] rl WITH (NOLOCK) ON sr.Reservation_ID=rl.reservation_id

GROUP BY sr.Reservation_ID, sr.Account_ID, rv.confirmation_code, ISNULL(rv.player_id,rl.member_number), Display_Date
--ORDER BY sr.Reservation_ID, sr.Account_ID

/*

SELECT DISTINCT [id],[tenant_id],[property_id],[name],[code] FROM [StayDWH].[dbo].[categories] WITH (NOLOCK) ORDER BY [name]

SELECT tenant_id, property_id, account_id, ledger_id, category_id, subcategory_id, accounting_item_id, reason, description, display_date, amount
FROM [dbo].[line_items] WITH (NOLOCK)
WHERE category_id='40d46e47-ef46-4d62-957b-bdbb9e2fbaa6'
--WHERE reservation_id='fde8c41c-d7fc-442c-b130-7aaa960b07a1'
--WHERE ledger_id='GUEST' --AND ( description LIKE '%tip%' OR description LIKE '%gratuity%') --category_id='6c27156d-41fb-47f7-918e-20bd8d06523f'
--AND category_id='6c27156d-41fb-47f7-918e-20bd8d06523f'
--AND reservation_id='57587b7c-348c-4dc2-92b3-1cde6c10ea34'
AND display_date > '2024-03-17'
ORDER BY ledger_id, category_id, subcategory_id, accounting_item_id, display_date


SELECT DISTINCT reservation_id, confirmation_code, display_date, SUM(amount) [ROOM_REVENUE]
FROM [StayDWH].[dbo].[vw_Line_items]
WHERE cg_code='ROOMS' AND ledger_id='GUEST' --AND destination_ledger_id='GUEST'
--AND confirmation_code = '23CBTPWBX'
GROUP BY reservation_id, confirmation_code, display_date

SELECT DISTINCT reservation_id, confirmation_code, display_date, SUM(amount) [ROOM_COMP]
FROM [StayDWH].[dbo].[vw_Line_items]
WHERE f_name='Comp Folio' AND li_reason='Comp' AND cg_code='ROOMS'
--AND confirmation_code = '6GJKCQWC4'
GROUP BY reservation_id, confirmation_code, display_date

SELECT DISTINCT reservation_id, confirmation_code, display_date, SUM(amount) [FB_REVENUE]
FROM [StayDWH].[dbo].[vw_Line_items]
WHERE cg_code='FNB' AND ledger_id='GUEST' --AND destination_ledger_id='GUEST'
--AND confirmation_code = '23CBTPWBX'
GROUP BY reservation_id, confirmation_code, display_date

SELECT DISTINCT reservation_id, confirmation_code, display_date, SUM(amount) Food_Comp
FROM [StayDWH].[dbo].[vw_Line_items]
WHERE cg_code='FNB' AND f_name='Comp Folio' AND li_reason='comp' --AND ledger_id='GUEST'
--AND confirmation_code = '23CBTPWBX'
GROUP BY reservation_id, confirmation_code, display_date

SELECT DISTINCT reservation_id, confirmation_code, display_date, SUM(amount) [SPA_REVENUE]
FROM [StayDWH].[dbo].[vw_Line_items]
WHERE cg_code='SPA' AND ledger_id='GUEST' --AND destination_ledger_id='GUEST'
--AND confirmation_code = '23CBTPWBX'
GROUP BY reservation_id, confirmation_code, display_date

SELECT DISTINCT reservation_id, confirmation_code, display_date, SUM(amount) [SPA_COMP]
FROM [StayDWH].[dbo].[vw_Line_items]
WHERE f_name='Comp Folio' AND li_reason='Comp' AND cg_code='SPA'
--AND confirmation_code = '6GJKCQWC4'
GROUP BY reservation_id, confirmation_code, display_date

SELECT DISTINCT reservation_id, confirmation_code, display_date, SUM(amount) Tier_Discount
FROM [StayDWH].[dbo].[vw_Line_items]
WHERE ai_code='TDSC' AND ledger_id='GUEST'
--AND confirmation_code = '23CBTPWBX'
GROUP BY reservation_id, confirmation_code, display_date

SELECT DISTINCT subcategory_id, name
FROM accounting_items WITH (NOLOCK)
WHERE status='ACTIVE'
--WHERE category_id='dcfa49d7-1ec1-4ffa-847d-bfb1036c1ef7' AND subcategory_id IN('746eec9c-89af-447e-9dd3-471d690e2146','5515b75f-9b30-48b8-b1d6-d76cc6a28862','05320f24-75e0-43f8-bb3b-661716d797d8','1a132f49-7d41-40b4-98c5-c2db6a32a750')
--name LIKE '%ameri%'

*/

GO

