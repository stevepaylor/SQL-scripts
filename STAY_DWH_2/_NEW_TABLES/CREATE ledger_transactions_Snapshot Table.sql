--CREATE TABLE public.ledger_transactions (
--    id text NOT NULL,
--    create_time timestamp without time zone,
--    destination_account_id text,
--    destination_ledger_id text,
--    folio_id text,
--    posting_calendar_date_time timestamp without time zone,
--    posting_property_date date,
--    property_id text,
--    source_account_id text,
--    source_ledger_id text,
--    tenant_id text,
--    transaction_item_type text,
--    type text,
--    update_time timestamp without time zone,
--    auto_recurring_item_id text,
--    folio_line_type text,
--    distributed boolean,
--    comp_transaction_type text,
--    comp_authorizer_id text,
--    comp_department_id text,
--    comp_source_line_item_id text,
--    comp_source_item_id text,
--    parent_id text,
--    comp_authorizer_type text,
--    comp_tax_posting_type text,
--    check_number bigint,
--    name text,
--    comp_offer_id text,
--    ledger_transaction_history_id text,
--    adjustment_type text,
--    adjusted_by text,
--    ar_dispute_id text,
--    source_charge_id text,
--    originated_account_id text
--);

--ADD CONSTRAINT ledger_transactions_pkey PRIMARY KEY (id);

--CREATE INDEX idx_ledger_transactions_destination_account_id ON public.ledger_transactions USING btree (destination_account_id);

--CREATE INDEX idx_ledger_transactions_tid_pid_parentid ON public.ledger_transactions USING btree (tenant_id, property_id, parent_id);

--CREATE INDEX idx_ledger_transactions_tid_pid_posting_property_date ON public.ledger_transactions USING btree (tenant_id, property_id, posting_property_date);

--select * into StayDWH.dbo.ledger_transactions_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.ledger_transactions LIMIT 5');

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[ledger_transactions_Snapshot] ;
GO

CREATE TABLE [dbo].[ledger_transactions_Snapshot](
	[id] [varchar] (200) NOT NULL,
	[create_time] [datetime2](7) NULL,
	[destination_account_id] [varchar] (200) NULL,
	[destination_ledger_id] [varchar] (200) NULL,
	[folio_id] [varchar] (200) NULL,
	[posting_calendar_date_time] [datetime2](7) NULL,
	[posting_property_date] [date] NULL,
	[property_id] [varchar] (10) NOT NULL,
	[source_account_id] [varchar] (200) NULL,
	[source_ledger_id] [varchar] (200) NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[transaction_item_type] [varchar] (200) NULL,
	[type] [varchar] (200) NULL,
	[update_time] [datetime2](7) NULL,
	[auto_recurring_item_id] [varchar] (200) NULL,
	[folio_line_type] [varchar] (200) NULL,
	[distributed] [varchar](5) NULL,
	[comp_transaction_type] [varchar] (200) NULL,
	[comp_authorizer_id] [varchar] (200) NULL,
	[comp_department_id] [varchar] (200) NULL,
	[comp_source_line_item_id] [varchar] (200) NULL,
	[comp_source_item_id] [varchar] (200) NULL,
	[parent_id] [varchar] (200) NULL,
	[comp_authorizer_type] [varchar] (200) NULL,
	[comp_tax_posting_type] [varchar] (200) NULL,
	[check_number] [int] NULL,
	[name] [varchar] (200) NULL,
	[comp_offer_id] [varchar] (200) NULL,
	[ledger_transaction_history_id] [varchar] (200) NULL,
	[adjustment_type] [varchar] (200) NULL,
	[adjusted_by] [varchar] (200) NULL,
	[ar_dispute_id] [varchar] (200) NULL,
	[source_charge_id] [varchar] (200) NULL,
	[originated_account_id] [varchar] (200) NULL,
 CONSTRAINT [PK_ledger_transactions_Snapshot_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

