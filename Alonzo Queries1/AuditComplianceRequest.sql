select top 1000 * from tplayernote
where Ref1 like '%b-noti%' or ref1 like '%notice%'
and IsOpenItem=0


select top 10000 noteid, Playerid, Ref1, REPLACE(Ref1, '28', '24'),  PostDTM from tplayernote

---update tplayernote set ref1=REPLACE(Ref1, '28', '24')
where (Ref1 like '%24[%]%' or ref1 like '%24 [%]%')
and IsOpenItem=1
and noteid  not in
(5266, 19872,38154, 52671,75633,80679,464231,465562,10073745,10078662,798958, 10306041)




Withhold @ 28%. B-Notice ltr snt 10/12/07 rtnd from PO; undeliverable. Stop withholding only after guest signs & returns a new W9. JmanaigreA&C

 REPLACE('SQL Tutorial', 'T', 'M');