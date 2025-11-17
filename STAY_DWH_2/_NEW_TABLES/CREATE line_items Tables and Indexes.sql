USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[line_items] ;
GO

CREATE TABLE [dbo].[line_items](
	[id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[account_id] [varchar] (200) NULL,
	[amount] [money] NULL,
	[category_id] [varchar] (200) NULL,
	[display_date] [date] NULL,
	[folio_id] [varchar] (200) NULL,
	[accounting_item_id] [varchar] (200) NULL,
	[ledger_id] [varchar] (200) NULL,
	[quantity] [int] NULL,
	[room_revenue] [varchar](5) NULL,
	[subcategory_id] [varchar] (200) NULL,
	[user_id] [varchar] (200) NULL,
	[ledger_lines_ledger_transaction_id] [varchar] (200) NULL,
	[folio_lines_ledger_transaction_id] [varchar] (200) NULL,
	[tax_reference_id] [varchar] (200) NULL,
	[adjustment_reference_id] [varchar] (200) NULL,
	[call_type] [varchar] (300) NULL,
	[correction_reference_id] [varchar] (200) NULL,
	[description] [varchar] (500) NULL,
	[free_allowance_amount] [money] NULL,
	[gateway_type] [varchar] (300) NULL,
	[gift_card] [varchar](5) NULL,
	[invalid] [varchar](5) NULL,
	[meal_period_id] [varchar] (200) NULL,
	[rate_change_comment] [varchar] (500) NULL,
	[reason] [varchar] (500) NULL,
	[recurring_charge_id] [varchar] (200) NULL,
	[reference] [varchar] (500) NULL,
	[refund_reference_id] [varchar] (200) NULL,
	[reservation_id] [varchar] (200) NULL,
	[reverse_tax_total_charge_amount] [money] NULL,
	[reverse_tax] [varchar](5) NULL,
	[room_charge_posting_type] [varchar] (500) NULL,
	[source_id] [varchar] (200) NULL,
	[transfer_reference_id] [varchar] (200) NULL,
	[pantry_item] [varchar](5) NULL,
	[comp_id] [varchar] (200) NULL,
	[check_number] [int] NULL,
	[exclude_tax] [varchar](5) NULL,
	[reference_number] [varchar] (200) NULL,
	[comp_reference_id] [varchar] (200) NULL,
	[room_id] [varchar] (200) NULL,
	[routed] [varchar](5) NULL,
	[source_folio_line_item_id] [varchar] (200) NULL,
	[payment_method_id] [varchar] (200) NULL,
	[posting_rule_id] [varchar] (200) NULL,
	[issuer] [varchar] (500) NULL,
	[last_four_digits] [varchar] (200) NULL,
	[payment_interface_id] [varchar] (200) NULL,
	[revised_adjustment_amount] [money] NULL,
	[is_manage_dispute_adjustment] [varchar](5) NULL,
	[corrected_or_adjusted_amount] [money] NULL,
	[deposit_payment_at_booking] [varchar](5) NULL,
	[auth_code] [varchar] (500) NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_line_items_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_line_items_accountid_folioid ON public.line_items USING btree (account_id, folio_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_account_id_folio_id] ON StayDWH.dbo.[line_items]
(
	[account_id] ASC,
	[folio_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_line_items_adjustmentreferenceid ON public.line_items USING btree (adjustment_reference_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_adjustment_reference_id] ON StayDWH.dbo.[line_items]
(
	[adjustment_reference_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_line_items_correctionreferenceid ON public.line_items USING btree (correction_reference_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_correction_reference_id] ON StayDWH.dbo.[line_items]
(
	[correction_reference_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_line_items_display_date ON public.line_items USING btree (display_date);
CREATE NONCLUSTERED INDEX [NCIX_line_items_display_date] ON StayDWH.dbo.[line_items]
(
	[display_date] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_line_items_refundreferenceid ON public.line_items USING btree (refund_reference_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_refund_reference_id] ON StayDWH.dbo.[line_items]
(
	[refund_reference_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_line_items_tid_pid_aid_fid ON public.line_items USING btree (tenant_id, property_id, account_id, folio_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_tenant_id_property_id_account_id_folio_id] ON StayDWH.dbo.[line_items]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[account_id] ASC,
	[folio_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_line_items_tid_pid_folio_lines_ledger_transaction_id ON public.line_items USING btree (tenant_id, property_id, folio_lines_ledger_transaction_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_tenant_id_property_id_folio_lines_ledger_transaction_id] ON StayDWH.dbo.[line_items]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[folio_lines_ledger_transaction_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_line_items_tid_pid_ledger_lines_ledger_transaction_id ON public.line_items USING btree (tenant_id, property_id, ledger_lines_ledger_transaction_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_tenant_id_property_id_ledger_lines_ledger_transaction_id] ON StayDWH.dbo.[line_items]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[ledger_lines_ledger_transaction_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_line_items_tid_pid_tax_reference_id ON public.line_items USING btree (tenant_id, property_id, tax_reference_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_tenant_id_property_id_tax_reference_id] ON StayDWH.dbo.[line_items]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[tax_reference_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_line_items_transferreferenceid ON public.line_items USING btree (transfer_reference_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_transfer_reference_id] ON StayDWH.dbo.[line_items]
(
	[transfer_reference_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_lineitems_foliolines ON public.line_items USING btree (folio_lines_ledger_transaction_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_folio_lines_ledger_transaction_id] ON StayDWH.dbo.[line_items]
(
	[folio_lines_ledger_transaction_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_lineitems_ledgerlines ON public.line_items USING btree (ledger_lines_ledger_transaction_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_ledger_lines_ledger_transaction_id] ON StayDWH.dbo.[line_items]
(
	[ledger_lines_ledger_transaction_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_lineitems_resid ON public.line_items USING btree (reservation_id);
CREATE NONCLUSTERED INDEX [NCIX_line_items_reservation_id] ON StayDWH.dbo.[line_items]
(
	[reservation_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
