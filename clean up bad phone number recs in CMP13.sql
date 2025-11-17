Select 
  tp.*
, em.FirstName
, em.LastName
, em.Position

From CMP13.dbo.tplayerphone tp
left join CMP13.dbo.tEmp em 
on tp.CreatedBy = em.empid 

where phonenumber not like '__________'
 and phonenumber <> '1'

Order by tp.CreatedDtm

--INSERT INTO CMP13.dbo.tplayerphone 

--Select *

--From CMP13.dbo.tplayerphone_SAVE

--WHERE PlayerId NOT IN (SELECT PlayerId from CMP13.dbo.tplayerphone)

--970464 rows affected)
--970453 rows affected)
--(970359 rows affected)
