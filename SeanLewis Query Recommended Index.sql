/*
Missing Index Details from SQLQuery19.sql - MSBIDB02dv.SteveTest (VIEJAS\spaylor (88))
The Query Processor estimates that implementing the following index could improve the query cost by 85.2008%.
*/

USE [vDW]
GO
CREATE NONCLUSTERED INDEX [NCIndex_player_tab_award_fact_IsVoid_GamingDt]
ON [player].[tab_award_fact] ([IsVoid],[GamingDt])
INCLUDE ([player_id],[PrizeCode],[PrizeName],[award_CompsUsed_Hotel_Mktg],[award_CompsUsed_FB],[award_CompsUsed_Other],[award_FPAwarded_NonPts],[award_PromoChipsAwarded],[award_CashAwarded_Bingo],[EmpID])
GO

