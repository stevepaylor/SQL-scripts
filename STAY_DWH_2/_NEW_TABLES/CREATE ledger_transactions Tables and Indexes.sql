USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[ledger_transactions] ;
GO

CREATE TABLE [dbo].[ledger_transactions](
	[id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[create_time] [datetime2](7) NULL,
	[destination_account_id] [varchar] (200) NULL,
	[destination_ledger_id] [varchar] (200) NULL,
	[folio_id] [varchar] (200) NULL,
	[posting_calendar_date_time] [datetime2](7) NULL,
	[posting_property_date] [date] NULL,
	[source_account_id] [varchar] (200) NULL,
	[source_ledger_id] [varchar] (200) NULL,
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
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_ledger_transactions_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_ledger_transactions_destination_account_id ON public.ledger_transactions USING btree (destination_account_id);
CREATE NONCLUSTERED INDEX [NCIX_ledger_transactions_destination_account_id] ON StayDWH.dbo.[ledger_transactions]
(
	[destination_account_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_ledger_transactions_tid_pid_parentid ON public.ledger_transactions USING btree (tenant_id, property_id, parent_id);
CREATE NONCLUSTERED INDEX [NCIX_ledger_transactions_tenant_id_property_id_parent_id] ON StayDWH.dbo.[ledger_transactions]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[parent_id] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_ledger_transactions_tid_pid_posting_property_date ON public.ledger_transactions USING btree (tenant_id, property_id, posting_property_date);
CREATE NONCLUSTERED INDEX [NCIX_ledger_transactions_tenant_id_property_id_posting_property_date] ON StayDWH.dbo.[ledger_transactions]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[posting_property_date] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
