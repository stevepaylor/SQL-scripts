select 'QA - vHotel' as 'Table / View', count(*) as 'RowCount'
FROM [iQ-Gaming].[Opera_5_0].[vHotel]

UNION

select 'PR - vHotel' as 'Table / View', count(*) as 'RowCount' 
FROM DWHDB01PR.[iQ-Gaming].[Opera_5_0].[vHotel]

UNION

select 'QA - RESERVATIONS_NIGHTS' as 'Table / View', count(*) as 'RowCount'
from [iQ-Gaming].[Opera_5_0].RESERVATIONS_NIGHTS

UNION

select 'PR - RESERVATIONS_NIGHTS' as 'Table / View', count(*) as 'RowCount'
from DWHDB01PR.[iQ-Gaming].[Opera_5_0].RESERVATIONS_NIGHTS

UNION

select 'QA - NAME_RESERVATION' as 'Table / View', count(*) as 'RowCount'
FROM [iQ-Gaming].Opera_5_0.NAME_RESERVATION

UNION

select 'PR - NAME_RESERVATION' as 'Table / View', count(*) as 'RowCount'
FROM DWHDB01PR.[iQ-Gaming].Opera_5_0.NAME_RESERVATION

UNION

select 'QA - tableau.player_dim' as 'Table / View', count(*) as 'RowCount'
FROM [iQ-Gaming].tableau.player_dim

UNION

select 'PR - tableau.player_dim' as 'Table / View', count(*) as 'RowCount'
FROM DWHDB01PR.[iQ-Gaming].tableau.player_dim