USE [DBA]
GO

/****** Object:  Index [CIDX_CollectionTime_BlockedById_ProcessId]    Script Date: 4/15/2019 10:32:29 AM ******/
DROP INDEX [CIDX_CollectionTime_BlockedById_ProcessId] ON [dbo].[WhoIsBlocking] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [CIDX_CollectionTime_BlockedById_ProcessId]    Script Date: 4/15/2019 10:32:29 AM ******/
CREATE CLUSTERED INDEX [CIDX_CollectionTime_BlockedById_ProcessId] ON [dbo].[WhoIsBlocking]
(
	[CollectionTime] ASC,
	[BlockedById] ASC,
	[ProcessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


