USE CMP13
SELECT  CASE WHEN  ( ISNULL(sum(basepts),0) < 0  )  THEN 0 ELSE ISNULL(sum(basepts),0)  END
	FROM viewAccum1Day a
	INNER JOIN tPlayerCard (nolock) pc on pc.PlayerId = a.PlayerID	
	WHERE Accumulator = 'DP' --AND 
--		Acct = @Acct AND 
--		PeriodBeginDtm = (SELECT TOP 1 CurrentLocnGamingDt from tLocn WHERE LocnId=@LocnId)
----		PeriodBeginDtm = (SELECT TOP 1 LastGamingDt from tLocn WHERE LocnId=@LocnId)
