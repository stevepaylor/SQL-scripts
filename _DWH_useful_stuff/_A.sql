USE SystemMaintDB
GO

DROP PROCEDURE IF EXISTS dbo.usp_CMP13_vs_DWHDB01QA_Variance_Email
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.usp_CMP13_vs_DWHDB01QA_Variance_Email 
AS



1.	CMP13 / Prod DWH
2.	CMP13 / QA DWH (This one)
3.	CMP13 / RDS PROD
4.	CMP13 / RDS QA
5.	Old DWH / Prod DWH 
6.	Old DWH / QA DWH (next)
7.	Prod DWH / Prod RDS
8.	QA DWH / QA RDS
