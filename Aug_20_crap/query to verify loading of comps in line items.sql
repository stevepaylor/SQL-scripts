DROP TABLE IF EXISTS STAYDWH.dbo.line_items_comp_verify
GO

SELECT DISTINCT
  display_date
, Reservation_ID
, category_id
, f.name
, reason
, AMOUNT Room_Comp
, 0 Food_Comp
, 0 Misc_Comp
		
INTO STAYDWH.dbo.line_items_comp_verify

FROM [dbo].[line_items] l WITH (NOLOCK)
lEFT JOIN [dbo].[folios] f WITH (NOLOCK) ON l.folio_id=f.id
WHERE category_id='b8d4a856-e2a8-4f4b-b6a0-56d08f46c295' AND f.name='Comp Folio' AND reason='comp'
AND display_date > DATEADD(DAY,-3,GETDATE())

UNION ALL

SELECT DISTINCT
  display_date
, Reservation_ID
, category_id
, f.name
, reason
, 0 Room_Comp
, AMOUNT Food_Comp
, 0 Misc_Comp

FROM [dbo].[line_items] l WITH (NOLOCK)
LEFT JOIN [dbo].[folios] f WITH (NOLOCK) ON l.folio_id=f.id
WHERE category_id='40d46e47-ef46-4d62-957b-bdbb9e2fbaa6' AND f.name='Comp Folio' AND reason='comp'
AND display_date > DATEADD(DAY,-3,GETDATE())

UNION ALL

SELECT DISTINCT
  display_date
, Reservation_ID
, category_id
, f.name
, reason
, 0 Room_Comp
, 0 Food_Comp
, AMOUNT Misc_Comp

FROM [dbo].[line_items] l WITH (NOLOCK)
LEFT JOIN [dbo].[folios] f WITH (NOLOCK) ON l.folio_id=f.id
WHERE category_id='6c27156d-41fb-47f7-918e-20bd8d06523f' AND f.name='Comp Folio' AND reason='comp'
AND display_date > DATEADD(DAY,-3,GETDATE())

ORDER BY display_date DESC
GO

--SELECT *
--FROM STAYDWH.dbo.line_items_comp_verify
--GO

SELECT
  [display_date]
, [Reservation_ID]
--, [category_id]
, [name] as folio_name
, [reason]
, MAX([Room_Comp]) as Total_Room_Comp
, MAX([Food_Comp]) as Total_Food_Comp
, MAX([Misc_Comp]) as Total_Misc_Comp
, COUNT(*) as Number_of_Comps

FROM STAYDWH.dbo.line_items_comp_verify

GROUP BY
  [display_date]
, [Reservation_ID]
--, [category_id]
, [name]
, [reason]

ORDER BY
  [display_date] DESC
, [Reservation_ID]
--, [category_id]
, [name]
, [reason]

GO
