USE CMP13
GO

DECLARE @PlayerID int = 32078 ;        
DECLARE @CasinoID NVARCHAR(MAX) = N'3' ;        
DECLARE @TripID Bigint = 111069898 ;  
DECLARE @wkIsShowTableRatingsInDetail bit = 0 ;         
          
BEGIN          
IF @TripID =0  
        
BEGIN          
   IF @wkIsShowTableRatingsInDetail = 0          
      BEGIN          
      Exec spPlRatingsByDetails  @PlayerId=@PlayerID,@CasinoID=@CasinoId
	  END           

   ELSE            --@wkIsShowTableRatingsInDetail = 1          
	   BEGIN          
       Exec  spPlRatingsConsolidatedByDetails  @PlayerId=@PlayerID,@CasinoID=@CasinoId 
       END
   END      

ELSE 
    -- IF @TripDt IS NOT NULL 
BEGIN          
   IF @wkIsShowTableRatingsInDetail = 0          
       BEGIN          
       Exec  spPlRatingsByTripDate   @PlayerId=@PlayerId,@CasinoID = @CasinoID , @TripID=@TripID  
    END	  
   ELSE    --@wkIsShowTableRatingsInDetail = 1          
	   BEGIN          
       Exec  spPlRatingsConsolidatedByTripDate   @PlayerId=@PlayerId,@CasinoID = @CasinoID ,  @TripID=@TripID       
	   END 
END       

END