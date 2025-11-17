SELECT * 
FROM DWHDB01PR.StayDWH.dbo.flash_aggregate_FIX

TRUNCATE TABLE StayDWH.dbo.flash_aggregate

INSERT INTO StayDWH.dbo.flash_aggregate
SELECT * 
FROM DWHDB01PR.StayDWH.dbo.flash_aggregate_FIX