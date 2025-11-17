--CREATE TABLE public.accounts (
--    id text NOT NULL,
--    name text,
--    number text,
--    property_id text,
--    tenant_id text,
--    account_status text,
--    account_type text,
--    create_time timestamp without time zone,
--    reference_id text,
--    update_time timestamp without time zone,
--    user_id text,
--    default_payment_method_id text,
--    credit_limit numeric(19,2)
--);

--ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);

--CREATE INDEX idx_accounts_account_status ON public.accounts USING btree (account_status);

--CREATE INDEX idx_accounts_rid ON public.accounts USING btree (reference_id);

--CREATE INDEX idx_accounts_tenant_id_property_id_account_type ON public.accounts USING btree (tenant_id, property_id, account_type);

--CREATE INDEX idx_accounts_tid_pid_number ON public.accounts USING btree (tenant_id, property_id, number);

--select * into StayDWH.dbo.accounts_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.accounts LIMIT 5');

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[accounts_Snapshot] ;
GO

CREATE TABLE [dbo].[accounts_Snapshot](
	[id] [varchar] (200) NOT NULL,
	[name] [varchar] (200) NULL,
	[number] [varchar] (200) NULL,
	[property_id] [varchar] (10) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[account_status] [varchar] (200) NULL,
	[account_type] [varchar] (200) NULL,
	[create_time] [datetime2](7) NULL,
	[reference_id] [varchar] (200) NULL,
	[update_time] [datetime2](7) NULL,
	[user_id] [varchar] (200) NULL,
	[default_payment_method_id] [varchar] (200) NULL,
	[credit_limit] [money] NULL,
 CONSTRAINT [PK_accounts_Snapshot__tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO