select *
from sys.objects
where object_id = 2025526745

--DBCC CHECKTABLE('player.tab_award_fact', 59)

USE [vDW]
GO

/****** Object:  Index [NCIndex_timestamp]    Script Date: 3/8/2023 8:18:24 AM ******/
DROP INDEX [NCIndex_timestamp] ON [player].[tab_award_fact]
GO

/****** Object:  Index [NCIndex_timestamp]    Script Date: 3/8/2023 8:18:25 AM ******/
CREATE NONCLUSTERED INDEX [NCIndex_timestamp] ON [player].[tab_award_fact]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

