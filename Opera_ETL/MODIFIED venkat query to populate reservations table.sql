USE [OperaData_Temp]
GO

TRUNCATE TABLE RESERVATIONS;
DECLARE db_cursor CURSOR FOR SELECT RESV_NAME_ID,NIGHTS,ARRIVAL from NAME_RESERVATION ----;
DECLARE @ResvID NVARCHAR(20);
DECLARE @Arrival DATE;
DECLARE @nights INT;
OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @ResvID, @nights, @Arrival;
WHILE @@FETCH_STATUS = 0  
BEGIN  
    IF @nights = 0
          SET @nights = 1
       DECLARE @i int
       SET @i = 0
       WHILE @i<@nights
              BEGIN
                  INSERT INTO dbo.RESERVATIONS
				  (RESV_NAME_ID
				  ,RESV_DATE
				  ,RESV_INDX)
				  VALUES
				  (@ResvID
				  ,DATEADD(d,@i,CAST(@Arrival as DATE))
				  ,@i+1)
				   
  --                   SELECT RESV_NAME_ID,DATEADD(d,@i,CAST(@Arrival as date)) AS RESV_DATE,@i+1 RESV_INDX FROM NAME_RESERVATION WHERE RESV_NAME_ID = @ResvID 

                     SET @i=@i+1
              END

       FETCH NEXT FROM db_cursor INTO @ResvID, @nights, @Arrival;
END;
CLOSE db_cursor;
DEALLOCATE db_cursor;
