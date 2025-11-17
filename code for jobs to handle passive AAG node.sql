USE [vBus]
GO

IF DATABASEPROPERTYEX('vBus', 'Updateability') = 'READ_WRITE'
BEGIN

   UPDATE [EVENTS] SET DEPARTURE_TS = DATEADD(day,DATEDIFF(day,-1,ARRIVAL_TS),'07:30:00')
   WHERE GROUP_CD in ('v1','v2','v3','v4','v5')
   AND DEPARTURE_TS is NULL

  END
ELSE
BEGIN
   PRINT 'Database vBus is not writeable.  Mode is -- ' + CAST(DATABASEPROPERTYEX('vBus', 'Updateability') AS VARCHAR(20)) + '.  -- Skipping processing.'
END
GO

UPDATE [EVENTS] SET DEPARTURE_TS = DATEADD(day,DATEDIFF(day,-1,ARRIVAL_TS),'07:30:00')
WHERE GROUP_CD in ('v1','v2','v3','v4','v5')
AND DEPARTURE_TS is NULL