DROP TABLE #bemails

select
PlayerId,
emailaddress
INTO #bemails
from tPlayerEmail where
patindex ('%[ &'',":;!+=\/()<>]*%', emailaddress) > 0  -- Invalid characters
or patindex ('[@.-_]%', emailaddress) > 0   -- Valid but cannot be starting character
or patindex ('%[@.-_]', emailaddress) > 0   -- Valid but cannot be ending character
or emailaddress not like '%@%.%'   -- Must contain at least one @ and one .
or emailaddress like '%..%'        -- Cannot have two periods in a row
or emailaddress like '%@%@%'       -- Cannot have two @ anywhere
or emailaddress like '%.@%' or emailaddress like '%@.%' -- Cant have @ and . next to each other
or emailaddress like '%.cm' or emailaddress like '%.co' -- Unlikely. Probably typos 
or emailaddress like '%.or' or emailaddress like '%.ne' -- Missing last letter
or emailaddress like '%no@vi%' -- no@viejas.com
or emailaddress like '%viejas%' -- Viejas
--228001
Select * from #bemails

Select emailaddress, count(*) FROM #bemails group by emailaddress order by 2 desc

DELETE tpe from tPlayerEmail tpe INNER JOIN #bemails be on tpe.PlayerId = be.PlayerId and 
tpe.EmailAddress = be.EmailAddress -- (209297 

UPDATE tp
SET ModifiedDtm = GETUTCDATE() 
FROM tPlayer tp INNER JOIN #bemails e on e.PlayerId = tp.PlayerId 



Select top 10 * from tPlayer
209503

Select emailaddress FROM #bemails where emailaddress like '%gmail' OR emailaddress like '%@c%' OR  emailaddress like '%hotmail'
OR  emailaddress like '%yahoo'

Sek


