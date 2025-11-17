USE [SystemMaintDB]
GO

/****** Object:  Table [dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver]    Script Date: 7/16/2023 6:21:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER TABLE [dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver] 
DROP CONSTRAINT [DF__Repl_ETL___Activ__49C3F6B7]
GO

ALTER TABLE [dbo].[Repl_ETL_Table_RowCount_Keys_Validation_Driver] ADD  DEFAULT ('N') FOR [InactiveFlag]
GO

