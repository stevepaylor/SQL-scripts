


  Select confirmation_no, * from 
  [iQ-Gaming].[dbo].[IQH_Hotel_Guests]
  where arrivalDate between '2022-02-05 00:00:00.000' and '2022-02-05 23:59:59.000'

  select top 1000 confirmation_no, * from msbidb02dv.operadm.dbo.name_reservation
  where arrival between '2022-02-05 00:00:00.000' and '2022-02-05 23:59:59.000'
  and confirmation_no not in
  (
  Select confirmation_no from 
  [iQ-Gaming].[dbo].[IQH_Hotel_Guests]
  where arrivalDate between '2022-02-05 00:00:00.000' and '2022-02-05 23:59:59.000'
  )

  Select confirmation_no, arrivalDate, * from 
  [iQ-Gaming].[dbo].[IQH_Hotel_Guests]
  where confirmation_no in (1299526,1302499)

  GO

  select * from IQH_Hotel_Posting
   where reservationID in (1396747,1399976)

  select top 1000 confirmation_no, * from msbidb02dv.operadm.dbo.name_reservation 
  where confirmation_no in (1299526,1302499)

  --- Mapping to Player
    Select confirmation_no, * from 
  [iQ-Gaming].[dbo].[IQH_Hotel_Guests] r left join CMKTDB13CPR.CMP13.dbo.viewplayersviejas vp on r.playerID = vp.playerid
  where arrivalDate between '2022-02-05 00:00:00.000' and '2022-02-05 23:59:59.000'









