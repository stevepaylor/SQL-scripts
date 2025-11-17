--USE [ig_business]
--GO

--/****** Object:  View [dbo].[Check_Discount_Detail_v]    Script Date: 4/3/2016 9:57:39 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


--CREATE VIEW [dbo].[Check_Discount_Detail_v]
--AS
--SELECT CAST([transaction_data_id] AS int) AS transaction_data_id
--      ,CAST([discount_dim_id] AS int) AS discount_dim_id
--      ,[discount_sequence_id]
--      ,[authorizing_emp_dim_id]
--      ,[discount_amount]
--      ,[extra_text]
--  FROM [ig_business].[dbo].[Check_Discount_Detail]

--GO

--EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
--Begin DesignProperties = 
--   Begin PaneConfigurations = 
--      Begin PaneConfiguration = 0
--         NumPanes = 4
--         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
--      End
--      Begin PaneConfiguration = 1
--         NumPanes = 3
--         Configuration = "(H (1 [50] 4 [25] 3))"
--      End
--      Begin PaneConfiguration = 2
--         NumPanes = 3
--         Configuration = "(H (1 [50] 2 [25] 3))"
--      End
--      Begin PaneConfiguration = 3
--         NumPanes = 3
--         Configuration = "(H (4 [30] 2 [40] 3))"
--      End
--      Begin PaneConfiguration = 4
--         NumPanes = 2
--         Configuration = "(H (1 [56] 3))"
--      End
--      Begin PaneConfiguration = 5
--         NumPanes = 2
--         Configuration = "(H (2 [66] 3))"
--      End
--      Begin PaneConfiguration = 6
--         NumPanes = 2
--         Configuration = "(H (4 [50] 3))"
--      End
--      Begin PaneConfiguration = 7
--         NumPanes = 1
--         Configuration = "(V (3))"
--      End
--      Begin PaneConfiguration = 8
--         NumPanes = 3
--         Configuration = "(H (1[56] 4[18] 2) )"
--      End
--      Begin PaneConfiguration = 9
--         NumPanes = 2
--         Configuration = "(H (1 [75] 4))"
--      End
--      Begin PaneConfiguration = 10
--         NumPanes = 2
--         Configuration = "(H (1[66] 2) )"
--      End
--      Begin PaneConfiguration = 11
--         NumPanes = 2
--         Configuration = "(H (4 [60] 2))"
--      End
--      Begin PaneConfiguration = 12
--         NumPanes = 1
--         Configuration = "(H (1) )"
--      End
--      Begin PaneConfiguration = 13
--         NumPanes = 1
--         Configuration = "(V (4))"
--      End
--      Begin PaneConfiguration = 14
--         NumPanes = 1
--         Configuration = "(V (2))"
--      End
--      ActivePaneConfig = 0
--   End
--   Begin DiagramPane = 
--      Begin Origin = 
--         Top = 0
--         Left = 0
--      End
--      Begin Tables = 
--         Begin Table = "Check_Discount_Detail"
--            Begin Extent = 
--               Top = 6
--               Left = 38
--               Bottom = 125
--               Right = 242
--            End
--            DisplayFlags = 280
--            TopColumn = 0
--         End
--      End
--   End
--   Begin SQLPane = 
--   End
--   Begin DataPane = 
--      Begin ParameterDefaults = ""
--      End
--   End
--   Begin CriteriaPane = 
--      Begin ColumnWidths = 11
--         Column = 1440
--         Alias = 900
--         Table = 1170
--         Output = 720
--         Append = 1400
--         NewValue = 1170
--         SortType = 1350
--         SortOrder = 1410
--         GroupBy = 1350
--         Filter = 1350
--         Or = 1350
--         Or = 1350
--         Or = 1350
--      End
--   End
--End
--' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Check_Discount_Detail_v'
--GO

--EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Check_Discount_Detail_v'
--GO

----------------------------------------------------------------------------------------------
USE [ig_business]
GO

/****** Object:  View [dbo].[Check_Item_Detail_v]    Script Date: 4/3/2016 9:57:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[Check_Item_Detail_v]
AS
SELECT CAST([transaction_data_id] AS int) AS transaction_data_id
      ,CAST([menu_item_dim_id] AS int) AS menu_item_dim_id
      ,[menu_item_status]
      ,CAST([void_reason_dim_id] AS int) AS void_reason_dim_id
      ,[menu_item_sales_amount]
      ,[menu_item_discount_amount]
      ,[menu_item_quantity]
      ,[emp_dim_id]
      ,[consumed_quantity]
      ,[consumed_cost_amount]
      ,[consumed_weight_amount]
      ,[revenue_cost_amount]
      ,[revenue_weight_amount]
      ,[revenue_quantity]
      ,[calculated_gross_sales_amount]
      ,[calculated_discount_amount]
      ,[sku]
      ,[price]
      ,[hide_on_rrv_report]
  FROM [ig_business].[dbo].[Check_Item_Detail]

GO

-------------------------------------------------------------------------------------
--USE [ig_business]
--GO

--/****** Object:  View [dbo].[Check_Sales_Detail_v]    Script Date: 4/3/2016 9:58:21 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


--CREATE VIEW [dbo].[Check_Sales_Detail_v]
--AS
--SELECT     CAST(transaction_data_id AS int) AS transaction_data_id, tendered_business_period_dim_id, posted_business_period_dim_id, opened_business_period_dim_id, 
--                      adjusted_business_period_dim_id, profit_center_dim_id, server_emp_dim_id, meal_period_dim_id, check_type_dim_id, event_dim_id, check_number, 
--                      associated_check_number, sales_gross_amount, num_covers, discount_amount, tax_amount, tender_amount, gratuity_amount, tip_amount, service_charge_amount, 
--                      transaction_data_tag, table_number, refund_flag, num_seconds_open, cashier_emp_dim_id, opened_date_time, tendered_date_time, opened_terminal_id, 
--                      tendered_terminal_id, rounded_amount, opened_terminal_dim_id, tendered_terminal_dim_id, void_state, void_reason_dim_id, authorizing_emp_dim_id, 
--                      discount_state, taxable_sales_amount, non_taxable_sales_amount, is_vat_flag, vat_gratuity_amount, vat_service_charge_amount, account_receivable_number, 
--                      tax_invoice_number
--FROM         dbo.Check_Sales_Detail


--GO

--EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
--Begin DesignProperties = 
--   Begin PaneConfigurations = 
--      Begin PaneConfiguration = 0
--         NumPanes = 4
--         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
--      End
--      Begin PaneConfiguration = 1
--         NumPanes = 3
--         Configuration = "(H (1 [50] 4 [25] 3))"
--      End
--      Begin PaneConfiguration = 2
--         NumPanes = 3
--         Configuration = "(H (1 [50] 2 [25] 3))"
--      End
--      Begin PaneConfiguration = 3
--         NumPanes = 3
--         Configuration = "(H (4 [30] 2 [40] 3))"
--      End
--      Begin PaneConfiguration = 4
--         NumPanes = 2
--         Configuration = "(H (1 [56] 3))"
--      End
--      Begin PaneConfiguration = 5
--         NumPanes = 2
--         Configuration = "(H (2 [66] 3))"
--      End
--      Begin PaneConfiguration = 6
--         NumPanes = 2
--         Configuration = "(H (4 [50] 3))"
--      End
--      Begin PaneConfiguration = 7
--         NumPanes = 1
--         Configuration = "(V (3))"
--      End
--      Begin PaneConfiguration = 8
--         NumPanes = 3
--         Configuration = "(H (1[56] 4[18] 2) )"
--      End
--      Begin PaneConfiguration = 9
--         NumPanes = 2
--         Configuration = "(H (1 [75] 4))"
--      End
--      Begin PaneConfiguration = 10
--         NumPanes = 2
--         Configuration = "(H (1[66] 2) )"
--      End
--      Begin PaneConfiguration = 11
--         NumPanes = 2
--         Configuration = "(H (4 [60] 2))"
--      End
--      Begin PaneConfiguration = 12
--         NumPanes = 1
--         Configuration = "(H (1) )"
--      End
--      Begin PaneConfiguration = 13
--         NumPanes = 1
--         Configuration = "(V (4))"
--      End
--      Begin PaneConfiguration = 14
--         NumPanes = 1
--         Configuration = "(V (2))"
--      End
--      ActivePaneConfig = 0
--   End
--   Begin DiagramPane = 
--      Begin Origin = 
--         Top = 0
--         Left = 0
--      End
--      Begin Tables = 
--         Begin Table = "Check_Sales_Detail"
--            Begin Extent = 
--               Top = 6
--               Left = 38
--               Bottom = 276
--               Right = 290
--            End
--            DisplayFlags = 280
--            TopColumn = 29
--         End
--      End
--   End
--   Begin SQLPane = 
--   End
--   Begin DataPane = 
--      Begin ParameterDefaults = ""
--      End
--   End
--   Begin CriteriaPane = 
--      Begin ColumnWidths = 11
--         Column = 1440
--         Alias = 900
--         Table = 1170
--         Output = 720
--         Append = 1400
--         NewValue = 1170
--         SortType = 1350
--         SortOrder = 1410
--         GroupBy = 1350
--         Filter = 1350
--         Or = 1350
--         Or = 1350
--         Or = 1350
--      End
--   End
--End
--' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Check_Sales_Detail_v'
--GO

--EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Check_Sales_Detail_v'
--GO

---------------------------------------------------------------------------------------
USE [ig_business]
GO

/****** Object:  View [dbo].[Check_Tender_Detail_v]    Script Date: 4/3/2016 9:58:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[Check_Tender_Detail_v]
AS
SELECT CAST([transaction_data_id] AS int) AS transaction_data_id
      ,[tender_dim_id]
      ,[tender_sequence_id]
      ,[credit_type_id]
      ,[tender_amount]
      ,[change_amount]
      ,[received_amount]
      ,[breakage_amount]
      ,[tip_amount]
      ,[additional_tender_data]
      ,[coupon_dim_id]
      ,[authorizing_emp_dim_id]
      ,[coupon_quantity]
      ,[posting_account]
      ,[ar_ti_val]
  FROM [ig_business].[dbo].[Check_Tender_Detail]

GO


