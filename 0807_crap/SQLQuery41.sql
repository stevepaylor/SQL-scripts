USE [StayDWH]
GO

DROP TABLE IF  EXISTS [dbo].[line_items_Delta]
GO

/****** Object:  Table [dbo].[line_items_Delta]    Script Date: 8/7/2025 3:09:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[line_items_Delta](
	[id] [varchar](200) NOT NULL,
	[tenant_id] [varchar](10) NOT NULL,
	[property_id] [varchar](10) NOT NULL,
	[account_id] [varchar](200) NULL,
	[amount] [money] NULL,
	[category_id] [varchar](200) NULL,
	[display_date] [date] NULL,
	[folio_id] [varchar](200) NULL,
	[accounting_item_id] [varchar](200) NULL,
	[ledger_id] [varchar](200) NULL,
	[quantity] [int] NULL,
	[room_revenue] [varchar](5) NULL,
	[subcategory_id] [varchar](200) NULL,
	[user_id] [varchar](200) NULL,
	[ledger_lines_ledger_transaction_id] [varchar](200) NULL,
	[folio_lines_ledger_transaction_id] [varchar](200) NULL,
	[tax_reference_id] [varchar](200) NULL,
	[adjustment_reference_id] [varchar](200) NULL,
	[call_type] [varchar](300) NULL,
	[correction_reference_id] [varchar](200) NULL,
	[description] [varchar](500) NULL,
	[free_allowance_amount] [money] NULL,
	[gateway_type] [varchar](300) NULL,
	[gift_card] [varchar](5) NULL,
	[invalid] [varchar](5) NULL,
	[meal_period_id] [varchar](200) NULL,
	[rate_change_comment] [varchar](500) NULL,
	[reason] [varchar](500) NULL,
	[recurring_charge_id] [varchar](200) NULL,
	[reference] [varchar](500) NULL,
	[refund_reference_id] [varchar](200) NULL,
	[reservation_id] [varchar](200) NULL,
	[reverse_tax_total_charge_amount] [money] NULL,
	[reverse_tax] [varchar](5) NULL,
	[room_charge_posting_type] [varchar](500) NULL,
	[source_id] [varchar](200) NULL,
	[transfer_reference_id] [varchar](200) NULL,
	[pantry_item] [varchar](5) NULL,
	[comp_id] [varchar](200) NULL,
	[check_number] [int] NULL,
	[exclude_tax] [varchar](5) NULL,
	[reference_number] [varchar](200) NULL,
	[comp_reference_id] [varchar](200) NULL,
	[room_id] [varchar](200) NULL,
	[routed] [varchar](5) NULL,
	[source_folio_line_item_id] [varchar](200) NULL,
	[payment_method_id] [varchar](200) NULL,
	[posting_rule_id] [varchar](200) NULL,
	[issuer] [varchar](500) NULL,
	[last_four_digits] [varchar](200) NULL,
	[payment_interface_id] [varchar](200) NULL,
	[revised_adjustment_amount] [money] NULL,
	[is_manage_dispute_adjustment] [varchar](5) NULL,
	[corrected_or_adjusted_amount] [money] NULL,
	[deposit_payment_at_booking] [varchar](5) NULL,
	[auth_code] [varchar](500) NULL,
	[above_property_payment] [varchar](5) NULL,
	[early_departure] [varchar](5) NULL,
	[card_subtype] [varchar](500) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_line_items_delta_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


