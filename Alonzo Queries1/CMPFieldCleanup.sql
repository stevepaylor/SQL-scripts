select count(*) from tPlayerAddress --2231
where Address2='NULL'

---Update tPlayerAddress set Address2='' where Address2='NULL'

select count(*) from tPlayerAddress --268
where Address1='NULL'

---Update tPlayerAddress set Address1='' where Address1='NULL'


select count(*)  from tPlayerAddress --6
where City='NULL'

---Update tPlayerAddress set City='' where City='NULL'

select count(*) from tPlayerAddress --7
where PostalCode='NULL'

---Update tPlayerAddress set PostalCode='' where PostalCode='NULL'


select Count(*) from tPlayer where LastName='NULL' --8
---update tPlayer set LastName='' where  LastName='NULL'





