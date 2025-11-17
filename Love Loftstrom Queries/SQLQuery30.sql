USE CMP13
GO

DECLARE 

	@StartDate DateTime = '12/01/2016',
	@EndDate DateTime = '12/31/2016'

IF OBJECT_ID(N'tempdb.dbo.#AccountsWithSetupDt') IS NOT NULL

BEGIN
	DROP TABLE #AccountsWithSetupDt
END

IF OBJECT_ID(N'tempdb.dbo.#CSRSignups') IS NOT NULL

BEGIN
	DROP TABLE #CSRSignups
END

IF OBJECT_ID(N'tempdb.dbo.#NewSignups') IS NOT NULL

BEGIN
	DROP TABLE #NewSignups
END

IF OBJECT_ID(N'tempdb.dbo.#TripsData') IS NOT NULL

BEGIN
	DROP TABLE #TripsData
END

IF OBJECT_ID(N'tempdb.dbo.#LargestLoss') IS NOT NULL

BEGIN
	DROP TABLE #LargestLoss
END

IF OBJECT_ID(N'tempdb.dbo.#LargestLossWithGamingDT') IS NOT NULL

BEGIN
	DROP TABLE #LargestLossWithGamingDT
END


SELECT DISTINCT

	CONVERT(VARCHAR, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), tp.SetupDtm), 101) AS SetupDt,
	tp.PlayerID,
	p.Acct,
	p.ClubStatus,
	tp.FirstName

INTO #AccountsWithSetupDt

FROM viewPlayersViejas AS p
INNER JOIN tPlayer AS tp
ON p.PlayerId = tp.PlayerID 

WHERE
	
	tp.FirstName <> 'VIEJAS CASINO';

SELECT DISTINCT 

	MIN(CONVERT(VARCHAR, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), a.PostDtm), 101)) AS SetupDt,
	a.Acct

INTO #CSRSignups

FROM tAudit AS a
INNER JOIN tAuditDtl AS ad
ON a.AuditID = ad.AuditId

WHERE

	ad.DataName = 'FirstNameOld'
	AND ad.DataValue = 'VIEJAS CASINO'

GROUP BY

	a.Acct;

SELECT

	CASE WHEN c.Acct IS NOT NULL THEN c.SetupDt ELSE a.SetupDt END AS SetupDtm,
	a.PlayerID,
	a.Acct,
	CASE WHEN a.ClubStatus = 'INACTIVE' THEN 'Bronze' ELSE a.ClubStatus END AS ClubStatus

INTO #NewSignups

FROM #AccountsWithSetupDt AS a
LEFT OUTER JOIN #CSRSignups AS c
ON a.Acct = c.Acct 

WHERE 

	CASE WHEN c.Acct IS NOT NULL THEN c.SetupDt ELSE a.SetupDt END BETWEEN @StartDate AND @EndDate
	AND a.PlayerID NOT IN
(
	SELECT [dbo].[tplayergroup].[PlayerId] 
	FROM [dbo].[tPlayerGroup]
	WHERE [GroupId] IN ('3554','3560')
);

SELECT

	GamingDt,
	PlayerId,
	Acct,
	[Actual Win (All Games)] AS ActualWin

INTO #TripsData

FROM [CASIVC08PR\CASIVC08PR].dmMarketing.dbo.Trips

WHERE

	GamingDt BETWEEN @StartDate AND @EndDate;

------------------------------------------------------------------------------------------------------------------------------
-- Build temp table to hold just Acct and the LargestLoss aggregation column
------------------------------------------------------------------------------------------------------------------------------
SELECT 	
	n.Acct,
    COALESCE(MAX(tr.ActualWin),0) AS LargestLoss

INTO #LargestLoss

FROM #NewSignups AS n
LEFT OUTER JOIN #TripsData AS tr
ON n.Acct = tr.Acct

GROUP BY
	n.Acct

ORDER BY
	n.Acct

------------------------------------------------------------------------------------------------------------------------------
-- Build temp table to hold Acct the MAX GamingDt and the LargestLoss aggregation column
------------------------------------------------------------------------------------------------------------------------------
SELECT 	
	n.Acct,
	CASE WHEN tr.GamingDt IS NULL THEN n.SetupDtm ELSE tr.GamingDt END AS GamingDate,
    COALESCE(MAX(tr.ActualWin),0) AS LargestLoss

INTO #LargestLossWithGamingDT

FROM #NewSignups AS n
LEFT OUTER JOIN #TripsData AS tr
ON n.Acct = tr.Acct

GROUP BY
	n.Acct,
	CASE WHEN tr.GamingDt IS NULL THEN n.SetupDtm ELSE tr.GamingDt END

ORDER BY
	n.Acct,
	GamingDate,
	LargestLoss 

------------------------------------------------------------------------------------------------------------------------------
-- Final query joins the first temp table to the second one on Acct and LargestLoss aggregated column to pull in the GamingDt
--
-- Note: Found that there were a number of accounts that had the same amount of loss on different gaming dates.  Taking the MAX
-- GamingDT fixes the duplication issue - Force the use of a subquery rather than a join
------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT
	l.Acct,
	GamingDT = (SELECT MAX(GamingDate) FROM #LargestLossWithGamingDT WHERE ACCT = l.Acct AND LargestLoss = l.LargestLoss), -- returns the most recent data with that loss amount
	l.LargestLoss

FROM #LargestLoss AS l

ORDER BY
	l.LargestLoss DESC,
	l.Acct,
	GamingDT
