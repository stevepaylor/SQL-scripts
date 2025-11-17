--CREATE TABLE public.deposit_policies (
--    id text NOT NULL,
--    tenant_id text,
--    property_id text,
--    policy_type text,
--    code text,
--    name text,
--    description text,
--    charge_type text,
--    days integer,
--    entire_stay boolean,
--    fixed_fee numeric(19,2),
--    percent_of_entire_stay numeric(19,2),
--    tax_included boolean,
--    active boolean,
--    subscribed_for_email_notification boolean,
--    notify_before_days integer,
--    subscribed_for_payment_status_notification boolean
--);

--ADD CONSTRAINT deposit_policy_pkey PRIMARY KEY (id);

--CREATE INDEX idx_deposit_policies_tid_pid_id ON public.deposit_policies USING btree (tenant_id, property_id, id);

--select * into StayDWH.dbo.deposit_policies_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.deposit_policies LIMIT 5');

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[deposit_policies_Snapshot] ;
GO

CREATE TABLE [dbo].[deposit_policies_Snapshot](
	[id] [varchar] (200) NOT NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[policy_type] [varchar] (200) NULL,
	[code] [varchar] (200) NULL,
	[name] [varchar] (200) NULL,
	[description] [varchar] (200) NULL,
	[charge_type] [varchar] (200) NULL,
	[days] [int] NULL,
	[entire_stay] [varchar](5) NULL,
	[fixed_fee] [money] NULL,
	[percent_of_entire_stay] [money] NULL,
	[tax_included] [varchar](5) NULL,
	[active] [varchar](5) NULL,
	[subscribed_for_email_notification] [varchar](5) NULL,
	[notify_before_days] [int] NULL,
	[subscribed_for_payment_status_notification] [varchar](5) NULL
 CONSTRAINT [PK_deposit_policies_Snapshot_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO