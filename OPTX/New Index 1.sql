USE [SDSVJPRD]
GO

/*
Missing Index Details from SQLQuery3.sql - SDSDB13Cpr.SDSVJPRD (VIEJAS\spaylor (56))
The Query Processor estimates that implementing the following index could improve the query cost by 74.5322%.
*/

/****** Object:  Index [ix_ACCOUNTING_SLIP_ROLLUP_VALUES_SLPRU_GDAY_DATE_covered]    Script Date: 10/16/2023 5:36:54 PM ******/
DROP INDEX [ix_ACCOUNTING_SLIP_ROLLUP_VALUES_SLPRU_GDAY_DATE_covered] ON [ACCOUNTING].[SLIP_ROLLUP_VALUES]
GO

/****** Object:  Index [ix_ACCOUNTING_SLIP_ROLLUP_VALUES_SLPRU_GDAY_DATE_covered]    Script Date: 10/16/2023 5:36:54 PM ******/
CREATE NONCLUSTERED INDEX [ix_ACCOUNTING_SLIP_ROLLUP_VALUES_SLPRU_GDAY_DATE_covered] ON [ACCOUNTING].[SLIP_ROLLUP_VALUES]
(
	[SLPRU_GDAY_DATE] ASC
)
INCLUDE([SLPRUV_SLP_ID],[SLPRU_PTYP_ID],[SLPRU_VALUE],[OptLockVersion],[CREATED_TS]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


/*
Missing Index Details from SQLQuery3.sql - SDSDB13Cpr.SDSVJPRD (VIEJAS\spaylor (56))
The Query Processor estimates that implementing the following index could improve the query cost by 67.5924%.
*/

/*
USE [SDSVJPRD]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [ACCOUNTING].[SLIP_ROLLUP_VALUES] ([SLPRU_GDAY_DATE])
INCLUDE ([SLPRUV_SLP_ID],[SLPRU_PTYP_ID],[SLPRU_VALUE],[OptLockVersion],[CREATED_TS])
GO
*/
