SELECT
      count([PlayerId]) guests
      --,[IsVoid]
      ,[Ref1]
      --,[Ref2]
      ,[PriorityCode]
      --,[IsOpenItem]

  FROM [CMP13].[dbo].[tPlayerNote]
  where 
  (
  ref1 like '%update address%' or 
  ref1 like '%bad address%' or 
  ref1 like '%Host needs to get her mailing address%' or 
  ref1 like '%PLEASE UPDATE ADDRESS%' or
  Ref1 like '*expired id%' or
  Ref1 like 'No email%' or 
  ref1 like 'greeted%' or
  ref1 like '%undeliverable email%' or
  ref1 like 'Guest has opted-out%' or
  ref1 like '%upgraded to%' or 
  ref1 like '%Please confirm guest address and put notes in CMP%' or
  ref1 like '***Please update contact info, ty***Sam L.' or
  ref1 like 'Please obtain contact information-Nate' or
  ref1 like 'added contact cel # -Tina W' or
  ref1 like 'claims to receive WOK if she brings in flyer we will accommodate; contact E&P. once settled delete this note' or
  ref1 like 'contact shop,dec.bd,blakjak,nye' or
  ref1 like 'CONTACTED - OFFERED food comp' or
  ref1 like 'CONTACTED / Stivan' or
  ref1 like 'Contacted issued food' or
  ref1 like 'update id & contact info ty!' or
  ref1 like 'Brought In Guest / UpTier to PLAT / Sign up /Add contact -Tina W' or
  ref1 like 'Add /Updated contact cell #-Tina W' or
  ref1 like 'Please obtain updated contact information-Nate' or
  ref1 like 'contact april bacc' or
  ref1 like 'contact shop,dec.bd,blakjak' or
  ref1 like 'ccontacted' or
 ref1 like 'Contacted - Invited her to Valentines Day Dinner.' or
 ref1 like 'Contacted 30 Day Inactive' or
 ref1 like 'Contacted guest 5/14/2019' or
 ref1 like 'Contacted guest by letter-Luz' or
 ref1 like 'contacted guest via email- FERRERI' or
 ref1 like 'contacted guest Via Email telemarketing-Alopez' or
 ref1 like 'Contacted guest via phone - telemarketing - Rich 16939' or
 ref1 like 'contacted guest watching play' or
 ref1 like 'contacted made points' or
 ref1 like 'contacted tier match status made 60 day points' or
 ref1 like 'Contacted Guest -telemarketing LL' or
 ref1 like 'Contacted Guest -Telemarketing LL 16595' or
 ref1 like 'Contacted guest via phone call- Rae' or
 ref1 like 'Greeted guest in pit, obtained contact info - MSpellman' or
 ref1 like 'Contacted guest on floor' or
ref1 like 'contacted guest.  Carmela' or
ref1 like 'contacted/ issued fpc' or
ref1 like '***ALL FPC*** Please contact TINA Wong x5278 or 619.322.3172 -Tina W' or
ref1 like 'Please obtain updated contact number-Nate' or
ref1 like 'update contact info - settle after' or
ref1 like 'update contact info ty' or
ref1 like 'contact mar bj' or
ref1 like 'Contacted - Invitred guest to the Shopping Event' or
ref1 like 'contacted- birthday bash' or
ref1 like 'LEFT VOICEMAIL GIVING GUEST CONTACT INFO - CA 12077' or
ref1 like 'Please update contact info-ALejandra' or
ref1 like 'Contacted via email- SFerreri' or
ref1 like 'Add / UpDated contact cel # -TIna W' or
ref1 like 'Called Guest left voice mail with contact information - Gabriel Cobian' or
ref1 like 'contact nye' or
ref1 like 'contacted- gave fp based on loss' or
ref1 like 'contacted- greeted player' or
ref1 like 'Contacted - 07/09/2021' or
ref1 like 'Greeted guest in pit, obtain contact, issued comp-Nate' or
ref1 like 'Greeted guest on casino floor and obtain contact-Nate' or
ref1 like 'CONTACTED-EXPLAINED TO PLAYER TIER MATCH PROCESS AND THE 60 DAY TRIAL PERIOD TO MAINTAIN THE GOLD STATUS.' or
ref1 like 'CONTACTED-FOLLOWED UP WITH PLAYER' or
ref1 like 'verified contact info. Carmela' or
ref1 like '*** ALL / ANY / BACC COMP CONTACT TINA 619.322.3172 or Ex 5278 ***' or
ref1 like 'Contacted issued fpc' or
ref1 like 'Brought In Guest / Match /Sign up / Added contact cel # -Tina W' or
ref1 like 'Contacted guest by phone-Luz' or
ref1 like 'updated contact cell #- tina w' or
ref1 like 'contact host apon guest arrival. Host will pick up VOC gift cards from high limit V-Booth' or
ref1 like 'update contact info' or
ref1 like 'Contacted (KJohnston #10385)' or
ref1 like 'CONTACTED/ STEPHANIE STODDARD' or
ref1 like 'contact abc' or
ref1 like 'contact blakjak,nye' or
ref1 like 'contact jan.blakjak' or
ref1 like 'Called Guest left voice mail contact information - Gabriel Cobian' or
ref1 like 'Contacted guest- LL 16595' or
ref1 like 'Contacted by Michael' or
ref1 like 'Contacted Guest Via Email telemarketing--Alopez' or
ref1 like 'Added contact cel # -Tina W' or
ref1 like 'contacted- 30 day inactive' or
ref1 like 'Contacted guest via telemarketing--Alopez' or
ref1 like 'contacted march bj' or
ref1 like 'Contacted tier match eval' or
ref1 like 'For any additional FP or questions, please contact Database Marketing at 1929' or
ref1 like 'contacted' or
ref1 like 'contact march bj' or
ref1 like 'Contact Player Dev.  August Shopping Event Invite located in PD office.  Settle note once invitation is given to guest.' or
ref1 like 'contact feb bd' or
ref1 like 'Guest has a NYE Invite in Player Development office - please contact a host and remove note when delivered.' or
ref1 like 'contact bacc feb.' or
ref1 like 'Contacted Guest- Laikyn' or
ref1 like 'contact nov bday' or
ref1 like 'Contacted guest- telemarketing LL 16595' or
ref1 like 'contact nov bacc' or
ref1 like 'CONTACTED. Stivan' or
ref1 like 'Guest''s invitation delivered to Host Office. Please contact Host. Settle note after.' or
ref1 like 'Contacted guest by phone - Luz' or
ref1 like 'Requal envelope & New Player Club Card at Player Development office - please contact a host and remove note when delivered.' or
ref1 like 'contacted' or
ref1 like 'contacted guest. Carmela' or
ref1 like 'contacted guest' or
ref1 like 'Contacted - KJohnston #10385' or
ref1 like 'contacted guest' or
ref1 like 'Contacted guest (KJohnston #10385)' or
ref1 like 'Add/Updated contact cel # -Tina W' or
ref1 like 'contact nye' or
ref1 like 'Starting 6/1, if playing blackjack, please contact PBX and ask for the host on duty' or
ref1 like 'Contacted issued fpc' or
ref1 like 'contact nye concert' or
ref1 like 'contacted guest.  Carmela' or
ref1 like 'contact blkjk jan.' or
ref1 like 'Contacted- Player has been informed of tier match policy/and guidelines. Player is aware of gold tier benefits.' or
ref1 like 'Contacted Guest by phone-Luz' or
ref1 like 'Contacted guest and let know I will be taking over for Shawn. keisner' or
ref1 like 'contact shop event' or
ref1 like 'contacted mv' or
ref1 like 'Add/Updated contact cel #-Tina W' or
ref1 like 'Add/Updated contact Cell # -Tina W' or
ref1 like 'Starting 6/1, if playing blackjack, please contact PBX and ask for the host on duty.' or
ref1 like 'Contacted Guest- Laikyn' or
ref1 like 'Contacted Guest- telemarketing LL' or
ref1 like 'CALLED GUEST GAVE CONTACT INFORMATION - GABRIEL COBIAN' or
ref1 like 'Birthday invitation at Player Development office - please contact a host and remove note when delivered.' or
ref1 like 'Add contact cel # -Tina W' or
ref1 like 'contacted guest-FERRERI' or
ref1 like 'Please update guests contact information- Laikyn' or
ref1 like 'contact march bd' or
ref1 like 'CONTACTED - NATE' or
ref1 like 'contact blakjak' or
ref1 like 'Contacted guest - Rae' or
ref1 like 'Updated contact cell #' or
ref1 like 'Contacted - Invited guest to the Shopping Event' or
ref1 like 'Add/Updated contact cell #-Tina W' or
ref1 like 'contacted' or
ref1 like 'contact guest // waleed shorees' or
ref1 like 'Updated contact cell # - Tina W' or
ref1 like 'PLEASE UPDATE CONTACT INFORMATION FROM MX BEFORE ISSUING PLAYERS CARD - GABRIEL COBIAN' or
ref1 like 'contacted about points' or
ref1 like 'Greeted Guest gave contact information - Gabriel Cobian' or
ref1 like 'updated contact cel #' or
ref1 like 'contact birth b' or
ref1 like 'contact shop,dec.bd' or
ref1 like 'Contacted guest by email - Luz' or
ref1 like 'contact blkj jan.' or
ref1 like 'updated contact cell # -tina w' or
ref1 like 'CONTACTED-EXPLAINED TO PLAYER TIER MATCH PROCESS AND THE 60 DAY TRIAL PERIOD TO MAINTAIN THE GOLD STATUS.- CHARLIE' or
ref1 like 'PLEASE UPDATE CONTACT INFORMATION - GABRIEL COBIAN' or
ref1 like 'Contacted guest - KJohnston #10385' or
ref1 like 'Please update guests contact information-Laikyn' or
ref1 like 'Contacted guest about the Birthday Bash' or
ref1 like 'Contacted with Gold status and offers' or
ref1 like 'contact shop,dec.bd,nye' or
ref1 like 'update contact info ty!' or
ref1 like 'Updated contact cel #-Tina W' or
ref1 like 'Contacted guest via email - rich 16939' or
ref1 like 'Contacted Guest-Laikyn' or
ref1 like 'Updated contact cel # - Tina W' or
ref1 like 'please update guest contact information- Laikyn' or
ref1 like 'Contacted guest Risa' or
ref1 like 'pls get contact info - cec 12077' or
ref1 like 'Contacted guest via email - telemarketing - Rich 16939' or
ref1 like 'please get contact info' or
ref1 like 'contacted guest via email-FERRERI' or
ref1 like 'Contacted - Berling Concert' or
ref1 like 'Updated contact cell #-Tina W' or
ref1 like 'contact dec.bd' or
ref1 like 'Contacted nov bday' or
ref1 like 'contactec' or
ref1 like 'Contacted tier eval' or
ref1 like 'contact mar.bj' or
ref1 like 'PLEASE UPDATE CONTACT INFO-Alejandra' or
ref1 like 'contacted guest  Risa' or
ref1 like 'Greeted guest in pit, obtain contact-Nate' or
ref1 like 'reached out to guest and gave contact info - cec 12077' or
ref1 like 'updated contact cel # -tina w' or
ref1 like 'contacted guest Carmela' or
ref1 like 'PLEASE UPDATE CONTACT INFO' or
ref1 like 'contact birthday' or
ref1 like 'Please obtain updated contact info-Nate' or
ref1 like 'contact mar bd' or
ref1 like 'contacted happy birthday' or
ref1 like 'Contacted guest - Rae' or
ref1 like 'Contacted guest on casino floor - KJohnston #10385' or
ref1 like 'PLS GET CONTACT INFO - CA 12077' or
ref1 like 'contacted guest via email.  Carmela' or
ref1 like 'Add contact cel #-Tina W' or
ref1 like 'pls get guest contact info - cec 12077' or
ref1 like 'Contacted - sent email' or
ref1 like 'Contacted guest - telemarketing LL 16595' or
ref1 like 'Contacted guest - mailed letter (KJohnston #10385)' or
ref1 like 'Contacted - Invited guest to the shopping event.' or
ref1 like 'contacted guest via phone.  Carmela' or
ref1 like 'Add/Updated contact cell # - Tina W' or
ref1 like 'CALLED GUEST LEFT CONTACT INFORMATION - GABRIEL COBIAN' or
ref1 like 'Contacted - sent email' or
ref1 like 'contacted guest via email' or
ref1 like 'PLS GET GUEST CONTACT INFO - CA 12077' or
ref1 like 'Contacted guest by email-Luz' or
ref1 like 'contact shop, dec.bd' or
ref1 like 'contacted guest via phone telemarketing--Alopez' or
ref1 like 'contacted guest Carmela' or
ref1 like 'Contacted guest Telemarketing--Alopez' or
ref1 like 'Contacted - 07/08/2021' or
ref1 like 'Contacted with offers to drive trip' or
ref1 like 'contact marbd' or
ref1 like 'Please obtain contact info-Nate' or
ref1 like 'Contacted guest- Rae' or
ref1 like 'contacted points' or
ref1 like 'Contact Nate for all FPC comps at Ext 5237 or 619-494-4797' or
ref1 like 'CONTACTED. Stivan' or
ref1 like 'CONTACTED-followed up with player on tier match process' or
ref1 like 'Contacted guest - called (KJohnston #10385)' or
ref1 like 'Contacted guest to introduce myself- Rae' or
ref1 like 'Starting 6/1, if playing blackjack, please contact PBX and ask for the host on duty.' or
ref1 like 'Contacted - Today, 07/06/2021' or
ref1 like 'contact' or
ref1 like 'Added Contact cel # -Tina W' or
ref1 like 'contacted guest-keisner' or
ref1 like 'update contact info' or
ref1 like 'Add contact cell # -Tina W' or
ref1 like 'Starting 6/1, if playing blackjack, please contact PBX and ask for the host on duty' or
ref1 like 'Contacted by Stivan' or
ref1 like 'contact jan blakjak' or
ref1 like '***Please update contact info, thank you***Sam L.' or
ref1 like 'Contacted - Sunday, July 4th' or
ref1 like 'contacted-' or
ref1 like 'updated contact information  Risa' or
ref1 like 'Contacted guest on casino floor (KJohnston #10385)' or
ref1 like 'Contacted guest email Telemarketing--Alopez' or
ref1 like 'CONTACTED- NATE' or
ref1 like 'PLS GET CONTACT INFO- CA 12077' or
ref1 like 'Add/Updated contact cel -Tina W' or
ref1 like 'ADD contact cel # / Email -Tina W' or
ref1 like 'CONTACTED, JAY' or
ref1 like 'Contacted - introduced myself' or
ref1 like 'Contacted Guest- email- Telemarketing LL 16595' or
ref1 like 'contact over 30 inactive' or
ref1 like 'Contacted guest- Rae' or
ref1 like 'Please update contact information - Gabriel Cobian' or
ref1 like ' bday & offers' or
ref1 like 'Updated contact address -Tina W' or
ref1 like 'Contacted Guest-Telemarketing LL 16595' or
ref1 like 'Contacted - Issued $100 FPC' or
ref1 like 'Contacted guest by phone -Luz' or
ref1 like 'Contacted - Invited guest to the Birthday Bash Event' or
ref1 like 'Contacted issued food comp' or
ref1 like 'guest not hosted. contacted guest. Carmela' or
ref1 like 'contacted via email' or
ref1 like 'contacted- bday & offers' or
ref1 like 'Please update contact information- Laikyn' or
ref1 like 'Contacted - Sat. July 3rd' or
ref1 like 'Add/Updated contact cel#-Tina W' or
ref1 like 'contacted guest. Carmela' or
ref1 like 'contact jan,blakjak' or
ref1 like 'Contacted guest by phone Luz' or
ref1 like 'Contacted Guest- Laikyn 16595' or
ref1 like 'spoke with guest over phone, gave contact info - ca 12077' or
ref1 like 'COntacted Via Telemarketing--Alopez' or
ref1 like 'contacted guest via email- SFERRERI' or
ref1 like 'Brought In Guest / uptier to PLAT / Add contact -Tina W' or
ref1 like 'contact birth' or
ref1 like 'Contacted email telemarketing--Alopez' or
ref1 like 'CONTACTED, ISSUED BDAY FPC' or
ref1 like 'Contacted guest via email- telemarketing LL 16595' or
ref1 like 'Add/Updated contact # -Tina W' or
ref1 like 'Contacted tier eval 60 day points earned' or
ref1 like 'COntacted via email Telemarketing--Alopez' or
ref1 like 'CONTACTED - Gave card and offered food comp' or
ref1 like 'CONTACTED - Gave food comp' or
ref1 like 'contacted-explained to player about the tier match process and the 60 day trial period to maintain the gold status.-charlie' or
ref1 like 'contacted via email' or
ref1 like 'get contact info - cec 12077' or
ref1 like 'contact feb  bd' or
ref1 like 'as of today guest is not coded.  contacted guest.  Carmela' or
ref1 like 'Starting 6/1, if playing blackjack, please contact PBX and ask for the host on duty ' or
ref1 like 'contacted bday bash' or
ref1 like 'Contacted and let know I will be taking over for Shawn- Keisner' or
ref1 like 'contacted guest- telemarketing- LL 16595' or
ref1 like 'Contacted Guest- SFERRERI' or
ref1 like 'contact over 30days inactive' or
ref1 like 'contact birthday bash' or
ref1 like 'get contact info' or
ref1 like 'Please update guest contact information-Laikyn' or
ref1 like 'contact bacc feb.' or
ref1 like 'Add/Updated contact cell #- Tina W' or
ref1 like 'Contacted guest- Telemarketing 16595' or
ref1 like 'Contacted booked hotel stay' or
ref1 like 'PLS GET GUEST CONTACT INFO- CA 12077' or
ref1 like 'Contacted guest - Rae' or
ref1 like 'COntacted guest and introduce myself--Alopez' or
ref1 like 'Contacted issued fpc & cigs' or
ref1 like 'Contacted Luz' or
ref1 like 'Contacted rsvp''d bday' or
ref1 like 'contacted/ issued fpc' or
ref1 like 'contacted guest via mail.  Carmela' or
ref1 like 'contacted guest, not coded-FERRERI' or
ref1 like 'Free play allowed only if reinvestmemt is under target. Contact host for questions' or
ref1 like 'Greeted guest on floor, obtain contact-Nate' or
ref1 like 'Contacted on 8.19.2021' or
ref1 like 'Added contact cel #-Tina W' or
ref1 like 'Add/ Updated contact cel # -Tina W' or
ref1 like 'Add/contact cel # -Tina W' or
ref1 like 'Brought in GUest / UpTier to PLAT / Sign up / Add contact -Tina W' or
ref1 like 'CONTACTED' or
ref1 like 'Contacted - issd FPC' or
ref1 like 'Contacted guest, introduced myself- Rae' or
ref1 like 'CONTACTED, BDAY' or
ref1 like 'contacted this guest.  Carmela' or
ref1 like 'PLEASE UPDATE CONTACT INFO- GILBERT O' or
ref1 like 'CONTACT' or
ref1 like '***PLEASE ADD CONTACT #***-Tina W' or
ref1 like 'Greeted Guest casino floor gave contact information - Gabriel Cobian' or
ref1 like 'UPDATED CONTACT CEL #- TINA W' or
ref1 like 'Contacted - 07/07/2021' or
ref1 like 'Add/Updated contact Cel# -Tina W' or
ref1 like 'ADD CONTACT CEL / EMAIL -TINA W' or
ref1 like 'Add/Contact cell # -Tina W' or
ref1 like 'Add / UpDated contact cell # -Tina W' or
ref1 like 'SPOKE WITH GUEST OVER PHONE, INTRODUCED MYSELF AND GAVE CONTACT INFO- CA 12077' or
ref1 like 'Contacted left voicemail' or
ref1 like 'Contacted Hostables' or
ref1 like 'contacted- bday bash' or
ref1 like 'Contacted tier match eval - guest earned 60 day points' or
ref1 like 'Contacted, Invite guest to the Birthday Event 2/22/22' or
ref1 like 'SPOKE WITH GUEST OVER PHONE, INTRODUCED MYSELF AND GAVE CONTACT INFO -CA 12077' or
ref1 like 'Contacted guest - LL 16595' or
ref1 like 'Contacted Guest Via Telemarketing - MSpellman' or
ref1 like 'CONTACTED, JG' or
ref1 like 'Add contact # -Tina W' or
ref1 like 'Add/Updated contact #-Tina W' or
ref1 like 'Added contact # -Tina W' or
ref1 like 'Greeted guest in pit, obtain contact, offered hotel-Nate' or
ref1 like 'Updated Contact Cell No. - Tina W' or
ref1 like 'Updated Contact Cell Number - Tina W' or
ref1 like 'UpTier to GOLD / Add contact cel # -Tina W' or
ref1 like 'please update contact info' or
ref1 like 'contacted mv' or
ref1 like 'contact feb bd' or
ref1 like 'contact nov bacc' or
ref1 like 'Contacted guest by phone (KJohnston #10385)' or
ref1 like 'Greeted guest on casino floor, obtain contact-Nate' or
ref1 like 'contacted at machine'

  )
  and isvoid = 0
  group by ref1, PriorityCode

  having count(playerid) >= 3
  order by count(playerid)