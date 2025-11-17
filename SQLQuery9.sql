USE [CMP13]
GO

/****** Object:  Index [IDX_tAccum1DayPts_ModifiedDtm]    Script Date: 5/15/2023 3:28:26 PM ******/
CREATE NONCLUSTERED INDEX [IDX_tAccum1DayPts_ModifiedDtm] ON [dbo].[tAccum1DayPts]
(
[ModifiedDtm] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [IDX_tAccum1DayBet_ModifiedDtm]    Script Date: 5/15/2023 3:28:26 PM ******/
CREATE NONCLUSTERED INDEX [IDX_tAccum1DayBet_ModifiedDtm] ON [dbo].[tAccum1DayBet]
(
[ModifiedDtm] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [IDX_tAccum1DayComp_ModifiedDtm]    Script Date: 5/15/2023 3:28:26 PM ******/
CREATE NONCLUSTERED INDEX [IDX_tAccum1DayComp_ModifiedDtm] ON [dbo].[tAccum1DayComp]
(
[ModifiedDtm] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

/****** Object:  Index [IDX_tAccum1DayPromo1_ModifiedDtm]    Script Date: 5/15/2023 3:28:26 PM ******/
CREATE NONCLUSTERED INDEX [IDX_tAccum1DayPromo1_ModifiedDtm] ON [dbo].[tAccum1DayPromo1]
(
[ModifiedDtm] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

/****** Object:  Index [IDX_tAccum1DayPromo2_ModifiedDtm]    Script Date: 5/15/2023 3:28:26 PM ******/
CREATE NONCLUSTERED INDEX [IDX_tAccum1DayPromo2_ModifiedDtm] ON [dbo].[tAccum1DayPromo2]
(
[ModifiedDtm] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

/****** Object:  Index [IDX_tAccum1DayStubs_ModifiedDtm]    Script Date: 5/15/2023 3:28:26 PM ******/
CREATE NONCLUSTERED INDEX [IDX_tAccum1DayStubs_ModifiedDtm] ON [dbo].[tAccum1DayStubs]
(
[ModifiedDtm] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

/****** Object:  Index [IDX_tPlayerStubBal_ModifiedDtm]    Script Date: 5/15/2023 3:28:26 PM ******/
CREATE NONCLUSTERED INDEX [IDX_tPlayerStubBal_ModifiedDtm] ON [dbo].[tPlayerStubBal]
(
[ModifiedDtm] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [IDX_tPlayerPointBal_ModifiedDtm]    Script Date: 5/15/2023 3:28:26 PM ******/
CREATE NONCLUSTERED INDEX [IDX_tPlayerPointBal_ModifiedDtm] ON [dbo].[tPlayerPointBal]
(
[ModifiedDtm] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
