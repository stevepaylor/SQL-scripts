--USE [CMP13]
--GO

--/****** Object:  Index [IDX_tPlayer_Perf]    Script Date: 3/15/2016 10:48:33 AM ******/
--CREATE NONCLUSTERED INDEX [IDX_tPlayer_Perf] ON [dbo].[tPlayer]
--(
--	[IsRetired] ASC,
--	[IsJunket] ASC,
--	[LastName] ASC
--)
--INCLUDE ( 	[PlayerId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--GO

USE [CMP13]
GO

/****** Object:  Index [IDX_tTrip_Perf]    Script Date: 3/15/2016 10:51:01 AM ******/
CREATE NONCLUSTERED INDEX [IDX_tTrip_Perf] ON [dbo].[tTrip]
(
	[TripType] ASC,
	[TripDt] ASC,
	[PlayerId] ASC,
	[CasinoId] ASC
)
INCLUDE ( 	[LastActionDtm],
	[LastTripStartTranCodeGamingDt]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


