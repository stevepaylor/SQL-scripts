--CREATE TABLE public.line_items (
--    id text NOT NULL,
--    account_id text,
--    amount numeric(19,2),
--    category_id text,
--    display_date date,
--    folio_id text,
--    accounting_item_id text,
--    ledger_id text,
--    property_id text,
--    quantity integer,
--    room_revenue boolean,
--    subcategory_id text,
--    tenant_id text,
--    user_id text,
--    ledger_lines_ledger_transaction_id text,
--    folio_lines_ledger_transaction_id text,
--    tax_reference_id text,
--    adjustment_reference_id text,
--    call_type text,
--    correction_reference_id text,
--    description text,
--    free_allowance_amount numeric(19,2),
--    gateway_type text,
--    gift_card boolean,
--    invalid boolean,
--    meal_period_id text,
--    rate_change_comment text,
--    reason text,
--    recurring_charge_id text,
--    reference text,
--    refund_reference_id text,
--    reservation_id text,
--    reverse_tax_total_charge_amount numeric(19,2),
--    reverse_tax boolean,
--    room_charge_posting_type text,
--    source_id text,
--    transfer_reference_id text,
--    pantry_item boolean,
--    comp_id text,
--    check_number bigint,
--    exclude_tax boolean,
--    reference_number text,
--    comp_reference_id text,
--    room_id text,
--    routed boolean,
--    source_folio_line_item_id text,
--    payment_method_id text,
--    posting_rule_id text,
--    issuer text,
--    last_four_digits text,
--    payment_interface_id text,
--    revised_adjustment_amount numeric(19,2),
--    is_manage_dispute_adjustment boolean,
--    corrected_or_adjusted_amount numeric(19,2),
--    deposit_payment_at_booking boolean,
--    auth_code text
--);

--    ADD CONSTRAINT line_items_pkey PRIMARY KEY (id);

--CREATE INDEX idx_line_items_accountid_folioid ON public.line_items USING btree (account_id, folio_id);

--CREATE INDEX idx_line_items_adjustmentreferenceid ON public.line_items USING btree (adjustment_reference_id);

--CREATE INDEX idx_line_items_correctionreferenceid ON public.line_items USING btree (correction_reference_id);

--CREATE INDEX idx_line_items_display_date ON public.line_items USING btree (display_date);

--CREATE INDEX idx_line_items_refundreferenceid ON public.line_items USING btree (refund_reference_id);

--CREATE INDEX idx_line_items_tid_pid_aid_fid ON public.line_items USING btree (tenant_id, property_id, account_id, folio_id);

--CREATE INDEX idx_line_items_tid_pid_folio_lines_ledger_transaction_id ON public.line_items USING btree (tenant_id, property_id, folio_lines_ledger_transaction_id);

--CREATE INDEX idx_line_items_tid_pid_ledger_lines_ledger_transaction_id ON public.line_items USING btree (tenant_id, property_id, ledger_lines_ledger_transaction_id);

--CREATE INDEX idx_line_items_tid_pid_tax_reference_id ON public.line_items USING btree (tenant_id, property_id, tax_reference_id);

--CREATE INDEX idx_line_items_transferreferenceid ON public.line_items USING btree (transfer_reference_id);

--CREATE INDEX idx_lineitems_foliolines ON public.line_items USING btree (folio_lines_ledger_transaction_id);

--CREATE INDEX idx_lineitems_ledgerlines ON public.line_items USING btree (ledger_lines_ledger_transaction_id);

--CREATE INDEX idx_lineitems_resid ON public.line_items USING btree (reservation_id);

--select * into StayDWH.dbo.line_items_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.line_items LIMIT 5');

USE [StayDWH]
GO

/****** Object:  Table [dbo].[line_items_Snapshot]    Script Date: 4/27/2024 12:37:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[line_items_Snapshot] ;
GO

CREATE TABLE [dbo].[line_items_Snapshot](
	[id] [varchar] (200) NOT NULL,
	[account_id] [varchar] (200) NULL,
	[amount] [money] NULL,
	[category_id] [varchar] (200) NULL,
	[display_date] [date] NULL,
	[folio_id] [varchar] (200) NULL,
	[accounting_item_id] [varchar] (200) NULL,
	[ledger_id] [varchar] (200) NULL,
	[property_id] [varchar] (10) NOT NULL,
	[quantity] [int] NULL,
	[room_revenue] [varchar](5) NULL,
	[subcategory_id] [varchar] (200) NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[user_id] [varchar] (200) NULL,
	[ledger_lines_ledger_transaction_id] [varchar] (200) NULL,
	[folio_lines_ledger_transaction_id] [varchar] (200) NULL,
	[tax_reference_id] [varchar] (200) NULL,
	[adjustment_reference_id] [varchar] (200) NULL,
	[call_type] [varchar] (200) NULL,
	[correction_reference_id] [varchar] (200) NULL,
	[description] [varchar] (200) NULL,
	[free_allowance_amount] [money] NULL,
	[gateway_type] [varchar] (200) NULL,
	[gift_card] [varchar](5) NULL,
	[invalid] [varchar](5) NULL,
	[meal_period_id] [varchar] (200) NULL,
	[rate_change_comment] [varchar] (200) NULL,
	[reason] [varchar] (200) NULL,
	[recurring_charge_id] [varchar] (200) NULL,
	[reference] [varchar] (200) NULL,
	[refund_reference_id] [varchar] (200) NULL,
	[reservation_id] [varchar] (200) NULL,
	[reverse_tax_total_charge_amount] [money] NULL,
	[reverse_tax] [varchar](5) NULL,
	[room_charge_posting_type] [varchar] (200) NULL,
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
	[issuer] [varchar] (200) NULL,
	[last_four_digits] [varchar] (200) NULL,
	[payment_interface_id] [varchar] (200) NULL,
	[revised_adjustment_amount] [money] NULL,
	[is_manage_dispute_adjustment] [varchar](5) NULL,
	[corrected_or_adjusted_amount] [money] NULL,
	[deposit_payment_at_booking] [varchar](5) NULL,
	[auth_code] [varchar] (200) NULL,
 CONSTRAINT [PK_line_items_Snapshot_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

