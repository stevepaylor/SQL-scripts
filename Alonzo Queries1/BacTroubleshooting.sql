select top 100 * from tTableRating
where TranID=10954175114


10 953 985676



DECLARE @Acct INT = 20254906
DECLARE @TranID bigint = 10953985676
---DECLARE @dt smalldatetime
DECLARE @running_sum INT, @temp INT
DECLARE @running_sum2 INT, @temp2 INT





SELECT  
       tr.TranID,
       tr.bet, 
       tr.RatingPeriodMinutes as ratingPeriodMinutes, 
	   tr.Plays as ratingPeriodPlays,
       0 AS RunningTotal,
	   0 AS RunningTotalPlays,
       0 AS gamelevel,
       0 AS gamingdays,
       vp.acct, 
       vp.FirstName, 
       vp.LastName, 
       tr.GamingDt 
INTO #PlayerRating
FROM 
       tTableRating tr INNER JOIN viewPlayersViejas vp ON tr.PlayerId = vp.PlayerId
WHERE tr.gameid in (2,10000505,10000506) and tr.IsVoid=0 and tr.IsOpenItem=0
       AND  acct=@Acct
and tranID>=@TranID and GamingDt>=(select GamingDt from tTableRating where tranID=@TranID)
ORDER BY tr.TranID ASC

UPDATE      #PlayerRating
SET         @temp = RunningTotal = COALESCE(@running_sum, 0) + ratingPEriodMinutes
            , @running_sum = CASE WHEN @temp < 600 THEN @temp ELSE 0 END
OPTION      (FORCE ORDER)

SELECT 
       ROW_NUMBER() OVER (ORDER BY TranID) AS RowNo,
    TranID 
       INTO #Prizelevels
FROM #PlayerRating where RunningTotal >= 600


UPDATE pr SET pr.gamelevel = p.RowNo
FROM #PlayerRating pr INNER JOIN  #Prizelevels p on p.TranID = pr.TranID


DECLARE @i int = 0

WHILE @i <= (SELECT Max(gamelevel) FROM #PlayerRating)
BEGIN
       UPDATE #PlayerRating SET gamelevel = @i WHERE TranID < (Select TranID FROM #Prizelevels WHERE RowNo = @i) and gamelevel = 0
       SET @i =  @i + 1
       --PRINT @i
       CONTINUE
END

UPDATE #PlayerRating SET gamelevel = (SELECT Max(gamelevel) + 1  FROM #PlayerRating) WHERE gamelevel = 0

DECLARE @gamelevel int = 0
WHILE @gamelevel <= (SELECT Max(gamelevel) FROM #PlayerRating)
BEGIN
       DECLARE @mindt date, @maxdt date
       SELECT @mindt = GamingDt from #PlayerRating where TranID = (Select min(tranid) from #PlayerRating where gamelevel = @gamelevel)
       SELECT @maxdt = GamingDt from #PlayerRating where TranID = (Select max(tranid) from #PlayerRating where gamelevel = @gamelevel)
       UPDATE #PlayerRating SET gamingdays = DATEDIFF(day,@mindt,@maxdt) where gamelevel = @gamelevel
       SET @gamelevel =  @gamelevel + 1
       PRINT @gamelevel
       CONTINUE
END



Select * from #PlayerRating



DROP TABLE #PlayerRating
DROP TABLE #Prizelevels