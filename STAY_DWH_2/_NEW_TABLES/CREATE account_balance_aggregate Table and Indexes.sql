--CREATE TABLE public.account_balance_aggregate (
--    date date,
--    tenant_id text,
--    property_id text,
--    account_id text,
--    sub_total numeric,
--    tax numeric,
--    paid numeric,
--    total numeric,
--    last_updated_at timestamp with time zone,
--    historic boolean,
--    ledger_name text,
--    recurring_charge boolean,
--    rr_charges numeric,
--    rr_transfers numeric,
--    nrr_charges numeric,
--    nrr_transfers numeric,
--    rr_charges_tax numeric,
--    rr_transfers_tax numeric,
--    nrr_charges_tax numeric,
--    nrr_transfers_tax numeric,
--    rr_routing_charges numeric,
--    nrr_routing_charges numeric,
--    rr_routing_charges_tax numeric,
--    nrr_routing_charges_tax numeric
--);

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[account_balance_aggregate] ;
GO

CREATE TABLE [dbo].[account_balance_aggregate](
	[date] [date] NOT NULL,
	[tenant_id] [varchar](10) NOT NULL,
	[property_id] [varchar](10) NOT NULL,
	[account_id] [varchar](200) NOT NULL,
	[ledger_name] [varchar](200) NOT NULL,

	[last_updated_at] [datetime2](7) NULL,
	[historic] [int] NULL,
	[recurring_charge] [int] NULL,
	[sub_total] [money] NULL,
	[tax] [money] NULL,
	[paid] [money] NULL,
	[total] [money] NULL,
	[rr_charges] [money] NULL,
	[rr_transfers] [money] NULL,
	[nrr_charges] [money] NULL,
	[nrr_transfers] [money] NULL,
	[rr_charges_tax] [money] NULL,
	[rr_transfers_tax] [money] NULL,
	[nrr_charges_tax] [money] NULL,
	[nrr_transfers_tax] [money] NULL,
	[rr_routing_charges] [money] NULL,
	[nrr_routing_charges] [money] NULL,
	[rr_routing_charges_tax] [money] NULL,
	[nrr_routing_charges_tax] [money] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
-- CONSTRAINT [PK_account_balance_aggregate_date_tenant_id_property_id_account_id_ledger_name] PRIMARY KEY CLUSTERED 
--(
--	[date] ASC,
--	[tenant_id] ASC,
--	[property_id] ASC,
--	[account_id] ASC,
--	[ledger_name] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--CREATE INDEX idx_account_balance_aggregate_aid_pid_date_idx ON public.account_balance_aggregate USING btree (account_id, property_id, date);
CREATE NONCLUSTERED INDEX [IX__account_balance_aggregate_account_id_property_id_date] ON [dbo].[account_balance_aggregate]
(
	[account_id] ASC,
	[property_id] ASC,
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_account_balance_aggregate_tid_pid_aid ON public.account_balance_aggregate USING btree (tenant_id, property_id, account_id);
CREATE NONCLUSTERED INDEX [IX__account_balance_aggregate_tenant_id_property_id_account_id] ON [dbo].[account_balance_aggregate]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--CREATE INDEX idx_accountbalancesaggregate_tid_pid_date ON public.account_balance_aggregate USING btree (tenant_id, property_id, date);
CREATE NONCLUSTERED INDEX [IX__account_balance_aggregate_tenant_id_property_id_date] ON [dbo].[account_balance_aggregate]
(
	[tenant_id] ASC,
	[property_id] ASC,
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX__account_balance_aggregate_date_tenant_id_property_id_account_id_ledger_name] ON [dbo].[account_balance_aggregate]
(
	[date] ASC,
	[tenant_id] ASC,
	[property_id] ASC,
	[account_id] ASC,
	[ledger_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO