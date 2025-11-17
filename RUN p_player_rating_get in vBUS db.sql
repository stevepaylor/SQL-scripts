USE [vBus]
GO

DECLARE @RC int
DECLARE @PLAYER_ID int
DECLARE @ARRIVAL_TS datetime
DECLARE @DEPARTURE_TS datetime
DECLARE @THEORETICAL_WIN_TOTAL money

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[p_player_rating_get] 
   @PLAYER_ID
  ,@ARRIVAL_TS
  ,@DEPARTURE_TS
  ,@THEORETICAL_WIN_TOTAL OUTPUT
GO


