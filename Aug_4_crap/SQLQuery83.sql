		SELECT DISTINCT Reservation_ID, l.Account_ID, display_date, 0 Room_Rev, AMOUNT AS Room_Comp, 0 Food_Rev, 0 Food_Comp, 0 Misc_Rev, 0 Misc_Comp, 0 Tier_Discount
		-- SELECT TOP 1000 *
		FROM [dbo].[line_items] l WITH (NOLOCK)
		LEFT JOIN [dbo].[folios] f WITH (NOLOCK) ON l.folio_id=f.id
		WHERE category_id='b8d4a856-e2a8-4f4b-b6a0-56d08f46c295' AND f.name='Comp Folio' AND reason='comp'
		--AND reservation_id='fde8c41c-d7fc-442c-b130-7aaa960b07a1'
		AND display_date between '2025-07-23' and '2025-08-04'
	    AND ISNULL(AMOUNT,0) <> 0 
		--ORDER BY display_date DESC

		UNION ALL


		SELECT DISTINCT Reservation_ID, l.Account_ID, display_date, 0 Room_Rev, 0 Room_Comp, 0 Food_Rev, AMOUNT AS Food_Comp, 0 Misc_Rev, 0 Misc_Comp, 0 Tier_Discount
		-- SELECT TOP 1000 *
		FROM [dbo].[line_items] l WITH (NOLOCK)
		LEFT JOIN [dbo].[folios] f WITH (NOLOCK) ON l.folio_id=f.id
		WHERE category_id='40d46e47-ef46-4d62-957b-bdbb9e2fbaa6' AND f.name='Comp Folio' AND reason='comp'
		--AND reservation_id='fde8c41c-d7fc-442c-b130-7aaa960b07a1'
		AND display_date between '2025-07-23' and '2025-08-04'
	    AND ISNULL(AMOUNT,0) <> 0 
		--ORDER BY display_date DESC

		UNION ALL
		--
		-- Misc Charges

		SELECT DISTINCT Reservation_ID, l.Account_ID, display_date, 0 Room_Rev, 0 Room_Comp, 0 Food_Rev, 0 Food_Comp, 0 Misc_Rev, AMOUNT AS Misc_Comp, 0 Tier_Discount
		FROM [dbo].[line_items] l WITH (NOLOCK)
		LEFT JOIN [dbo].[folios] f WITH (NOLOCK) ON l.folio_id=f.id
		WHERE category_id='6c27156d-41fb-47f7-918e-20bd8d06523f' AND f.name='Comp Folio' AND reason='comp'
		--AND reservation_id='74176317-bb3b-4107-8323-25708b26e94e'
		AND display_date between '2025-07-23' and '2025-08-04'
	    AND ISNULL(AMOUNT,0) <> 0 
		ORDER BY display_date DESC