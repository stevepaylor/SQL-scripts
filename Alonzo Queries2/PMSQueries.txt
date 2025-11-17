-- Postings
select top 10 * from IQH_Hotel_Posting
where reservationID=1390484

---   Empty
select top 10 * from IQH_Hotel_Posting_Ext
where reservationID=1390484

v_IQH_Hotel_Posting

select top 10 * from v_IQH_Hotel_Posting
where reservationID=1390484

-- Folios
select top 10 * from IQH_Hotel_Folios
where reservationID=1390484

-- Folio Extension
select top 100 * from IQH_Hotel_Folios_Ext  where posting_type not in ('MANUAL','RATE CODE')

-- Folios Ext Join
select top 10 * from IQH_Hotel_Folios f inner join IQH_Hotel_Folios_Ext fe
on f.TicketSequence = fe.TicketSequence2
where reservationID=1390484

-- Folios View
---???   needed???

---  Player Stays (Reservations) ---  What about for non players
select top 100 * from [iQ-Gaming].[dbo].[IQH_Hotel_Guests]
---where playerid=''
where playerid=453936



 ----Player Stays (Reservations) - VIEW   Error
 select top 100 * FROM [iQ-Gaming].[dbo].[vIQH_Hotel_Guests]
where playerid=453936

---  Inventory - By Day, By Room Type  ---   HOUSE counts looks strange
select top 100 * from 
[iQ-Gaming].[dbo].[vIQH_Hotel_Inventory]
where AccountingDate='2021-12-19'

---Room Type --    Maybe by Hotel
SELECT TOP (1000) [RoomType]
      ,[RoomDescription]
  FROM [iQ-Gaming].[dbo].[IQH_Hotel_Room_Type]

-- BOTH EMPTY
select top 10 * from  [iQ-Gaming].[dbo].[IQH_Reservation_Source_Snapshot]
GO
select top 10 * from  IQH_Reservation_Inventory_Snapshot

--   Confirmation Number anyhwere?? ---   Will add to reservation level 





