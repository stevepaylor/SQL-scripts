SELECT 
  s.PostalCodeId as old_PostalCodeId
, a.PostalCodeId
, s.PostalCode  as old_PostalCode
, a.PostalCode

FROM tPlayerAddress_SAVE s

JOIN tPlayerAddress a
ON s.PlayerId = a.PlayerId
AND s.ContactTypeId = a.ContactTypeId

WHERE s.PostalCode NOT LIKE '[0-9][0-9][0-9][0-9][0-9]%' 
  AND s.PostalCode <> ''
  AND s.PostalCode IS NOT NULL
  AND s.CountryName = 'USA'
  AND s.stateid IS NOT NULL 
  AND s.stateid <> '0'
  AND s.country = 'usa'

ORDER BY s.CreatedDtm DESC

--(4960 rows affected)
