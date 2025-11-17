                           DECLARE @i int = 1
                           -- Update the player's ratings using a cursor to loop through the JUNKET_COMMISSIONS_ARCHIVE table 
                           DECLARE commission_cursor CURSOR
                           FOR
                                  SELECT PLAYER_ID, EVENT_ID, ARRIVAL_TS, DEPARTURE_TS FROM JUNKET_COMMISSIONS_ARCHIVE WITH(NOLOCK) --WHERE THEORETICAL_WIN_TOTAL IS NULL 
                                  WHERE EVENT_ID = 194864
                           OPEN commission_cursor;
                           DECLARE @PLAYER_ID int;
                           DECLARE @EVENT_ID int;
                           DECLARE @ARRIVAL_TS datetime;
                           DECLARE @DEPARTURE_TS datetime
                           FETCH NEXT FROM commission_cursor INTO @PLAYER_ID, @EVENT_ID, @ARRIVAL_TS, @DEPARTURE_TS;
						   PRINT @PLAYER_ID
						   PRINT @EVENT_ID
						   PRINT @ARRIVAL_TS
						   PRINT @DEPARTURE_TS
                           WHILE (@@FETCH_STATUS = 0)
                           BEGIN
                                  -- Get the ratings for that player during the specified date range 
                                  DECLARE @THEORETICAL_WIN_TOTAL money 
                                  EXECUTE p_player_rating_get @PLAYER_ID, @ARRIVAL_TS, @DEPARTURE_TS, @THEORETICAL_WIN_TOTAL OUT
       
                                  -- Update the JUNKET_COMMISSIONS_ARCHIVE table with the player's THEORETICAL_WIN_AMT
                                  Select @i,@PLAYER_ID, @ARRIVAL_TS, @DEPARTURE_TS, @THEORETICAL_WIN_TOTAL
                                  --IF @THEORETICAL_WIN_TOTAL is null
                                  --   BEGIN
                                  --     SET @THEORETICAL_WIN_TOTAL = 0
                                  --   END
                                  --UPDATE JUNKET_COMMISSIONS_ARCHIVE WITH(ROWLOCK) SET THEORETICAL_WIN_TOTAL = @THEORETICAL_WIN_TOTAL WHERE PLAYER_ID = @PLAYER_ID AND EVENT_ID = @EVENT_ID
                                  SET @i = @i+1
                                  FETCH NEXT FROM commission_cursor INTO @PLAYER_ID, @EVENT_ID, @ARRIVAL_TS, @DEPARTURE_TS;
								  
								  PRINT @PLAYER_ID
						          PRINT @EVENT_ID
						          PRINT @ARRIVAL_TS
						          PRINT @DEPARTURE_TS
                           END;
                           CLOSE commission_cursor;
                           DEALLOCATE commission_cursor;
