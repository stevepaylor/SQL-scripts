select top 10 postdtm, ModifiedDTM,datediff(d,postdtm, ModifiedDTM), * from tTableRating
where datediff(d,postdtm, ModifiedDTM)>30
and year(postdtm)>=2020


select postdtm, ModifiedDTM,datediff(d,postdtm, ModifiedDTM), * from tSlotRating
where datediff(d,postdtm, ModifiedDTM)>30
and year(postdtm)>=2020

select top 100 * from temp where EmpNum='17784'
-- Trevor Hewey

Voided, Memo 10810143653 - Void Reason - Void requested by Linda Carr and Aze Araneta - TH17784