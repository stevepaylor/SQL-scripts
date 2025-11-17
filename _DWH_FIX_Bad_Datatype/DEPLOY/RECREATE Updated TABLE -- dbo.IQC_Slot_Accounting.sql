USE [iQ-Gaming]
GO

DROP TABLE IF EXISTS dbo.IQC_Slot_Accounting_save
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQC_Slot_Accounting_save
FROM dbo.IQC_Slot_Accounting
GO

DROP TABLE IF EXISTS dbo.IQC_Slot_Accounting
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.IQC_Slot_Accounting(
	AssetNumber varchar(50) NOT NULL,
	LocationID varchar(50) NULL,
	GamingDateID int NOT NULL,
	GamingDate datetime NOT NULL,
	ConfigID int NOT NULL,
	Plays int NULL,
	DaysOnFloor smallint NULL,
	ActualCoinIn money NULL,
	MeteredCoinIn money NULL,
	ActualCoinOut money NULL,
	MeteredCoinOut money NULL,
	Jackpots money NULL,
	Variance money NULL,
	ActualSoftDrop money NULL,
	MeteredSoftDrop money NULL,
	ActualHardDrop money NULL,
	MeteredHardDrop money NULL,
	ActualTicketDrop money NULL,
	MeteredTicketDrop money NULL,
	Fills money NULL,
	ActualTicketIn money NULL,
	MeteredTicketIn money NULL,
	ActualTicketOut money NULL,
	MeteredTicketOut money NULL,
	ExtraCreditUsed money NULL,
	Bonus money NULL,
	ActualWin money NULL,
	MeteredWin money NULL,
	LeaseFees money NULL,
	ActualAdjustedWin money NULL,
	MeteredAdjustedWin money NULL,
	FreePlay_Used money NULL,
	FreePlay_In money NULL,
	FreePlay_Out money NULL,
	CasinoCode char(4) NULL,
	ManualUpdate bit NULL,
	TheoreticalWin money NULL,
	SourceSystem varchar(50) NULL,
	LoadDTTM datetime NULL
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique internal casino identifier for the Slot machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'AssetNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Location of the Slot machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'LocationID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the Gaming Date (lookup to iQ_Calendar)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'GamingDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Gaming Date for the accounting record     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'GamingDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Config Identifier  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ConfigID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The number of Games (handle pulls) for the machine for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'Plays'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'If the slot machine is active then 1, else 0     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'DaysOnFloor'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Actual (counted) Coin In for the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ActualCoinIn'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Metered (machine) Coin In     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'MeteredCoinIn'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Actual (counted) Coin Out for the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ActualCoinOut'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Metered (machine) Coin Out     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'MeteredCoinOut'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Jackpots for the machine for the accounting record     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'Jackpots'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The calculated variance for the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'Variance'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Actual (counted) Soft Drop (Bills) for the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ActualSoftDrop'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Metered (machine) Soft Drop     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'MeteredSoftDrop'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Actual (counted) Hard Drop (Coins) for the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ActualHardDrop'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Metered (machine) Hard Drop     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'MeteredHardDrop'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Actual (counted) Ticket Drop for the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ActualTicketDrop'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Metered (machine) Ticket Drop     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'MeteredTicketDrop'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The amount of Fills for the machine for the accounting record     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'Fills'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Actual (counted) Tickets In for the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ActualTicketIn'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Metered (machine) Tickets In     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'MeteredTicketIn'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Actual (counted) Tickets Out for the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ActualTicketOut'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Metered (machine) Tickets Out     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'MeteredTicketOut'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The amount of Extra Credits issued by the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ExtraCreditUsed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The total Bonus amount issued from the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'Bonus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Actual Win of the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ActualWin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Metered Win of the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'MeteredWin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The amount of lease fees (if applicable) for th3e accounting record     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'LeaseFees'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Actual Adjusted (less Variance) Win of the machine      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ActualAdjustedWin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Metered Adjusted (less variance) Win of the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'MeteredAdjustedWin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Total amount of Free Play used on the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'FreePlay_Used'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The amount of Free Play transferred In to the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'FreePlay_In'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The amount of Free Play transferred Out of the machine     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'FreePlay_Out'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Casino Code for the summarized data     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'CasinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'True/false if the record has been updated manually     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'ManualUpdate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Theoretical Win for the Slot machine for the accounting record     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'TheoreticalWin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System for the data     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'SourceSystem'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date data row was loaded to the table     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting', @level2type=N'COLUMN',@level2name=N'LoadDTTM'
GO

-- reload the table after dropping and recreating with schema changes
INSERT INTO dbo.IQC_Slot_Accounting
SELECT *
FROM dbo.IQC_Slot_Accounting_save
GO
