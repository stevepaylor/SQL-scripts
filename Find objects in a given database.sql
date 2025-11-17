select *
from sys.objects
WHERE type = 'U'
  AND [name] LIKE 'g%'

ORDER BY [name]

--WHERE [name] LIKE '%global_flags%'

--select DISTINCT
--  type
--, type_desc
--from sys.objects