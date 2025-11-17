USE [AdventureWorksLT2019]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[v_CustomerLite]
AS
SELECT dbo.CustomerLite.*
FROM dbo.CustomerLite
GO


