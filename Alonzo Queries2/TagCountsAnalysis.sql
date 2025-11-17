select count(*) from ttag   --  113684
select count(*) from ttag   --  104919
where IsInactive=1

select count(*) from ttag   --  78288
where IsInactive=1 and year(createddtm)<=2018

select count(*) from tplayertag tpt inner join ttag tt on tpt.TagId = tt.TagId  --  28670414
where tt.IsInactive=1 and year(tt.createddtm)<=2018



select count(*) from tplayertag   --  43,788,609
select count(*) from tplayertag   --  9,282,903
where IsInactive=1


select count(*) from tplayertag tpt inner join ttag tt on tpt.TagId = tt.TagId  --  39,188,339
where tt.IsInactive=1

select count(*) from tplayertag tpt inner join ttag tt on tpt.TagId = tt.TagId  --  8727071
where tt.IsInactive=1 and tpt.IsInactive=1

select top 1000 * from ttag   --  104919
where IsInactive=1

select * from ttag where tagcode='VenkatTest6132019'
and IsInactive=0


select top 100 * from temp
where lastname like 'Jones'