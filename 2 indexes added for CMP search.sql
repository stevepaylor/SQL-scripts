/*
Missing Index Details from ExecutionPlan1.sqlplan
The Query Processor estimates that implementing the following index could improve the query cost by 34.0568%.
*/

/*
USE [CMP13]
GO
CREATE NONCLUSTERED INDEX [IDX_tTrip_PlayerId_TripType_LastActionGamingDt]
ON [dbo].[tTrip] ([PlayerId],[TripType],[LastActionGamingDt])
INCLUDE ([TripId],[LastActionDtm])
GO
*/

/*
Missing Index Details from ExecutionPlan2.sqlplan
The Query Processor estimates that implementing the following index could improve the query cost by 28.2853%.
*/

/*
USE [CMP13]
GO
CREATE NONCLUSTERED INDEX [IDX_tWsProfileSetting_DataGroup_DataName]
ON [dbo].[tWsProfileSetting] ([DataGroup],[DataName])
INCLUDE ([WsProfileId],[DataVal])
GO
*/