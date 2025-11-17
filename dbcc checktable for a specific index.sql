

SELECT *
FROM SYS.objects
WHERE object_id = 151372004

USE CMP13
SELECT * 
FROM SYS.indexes
WHERE object_id = 151372004


DBCC CHECKTABLE ('tSlotRating_SWD_230331_Copy',1);
GO

--DBCC CHECKTABLE ('player.tab_award_fact',59);
--GO
