--UPDATE CMP13.dbo.tPlayerAddress
--SET 
--  PostalCode = NULL
--, PostalCodeId = NULL

--WHERE PostalCode NOT LIKE '[0-9][0-9][0-9][0-9][0-9]%' 
--  AND PostalCode <> ''
--  AND PostalCode IS NOT NULL
--  AND CountryName = 'USA'
--  AND stateid IS NOT NULL 
--  AND stateid <> '0'
--  AND country = 'usa'

--SELECT *
--INTO CMP13.dbo.tPlayerAddress_SAVE
--FROM CMP13.dbo.tPlayerAddress 

select *
From CMP13.dbo.tPlayerAddress 
where PostalCode not like '[0-9][0-9][0-9][0-9][0-9]%' 
and PostalCode <> ''
and PostalCode is not null
and CountryName = 'USA'
and stateid is not null 
and stateid <> '0'
and country = 'usa'
order by CreatedDtm desc
