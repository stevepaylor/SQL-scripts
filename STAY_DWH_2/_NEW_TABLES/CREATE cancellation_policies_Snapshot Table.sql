--CREATE TABLE public.cancellation_policies (
--    id text NOT NULL,
--    code text,
--    accounting_item_id text,
--    description text,
--    days_before_arrival integer,
--    days_after_booking integer,
--    arrival_time integer,
--    flat_fee numeric(19,2),
--    percentage numeric(19,2),
--    nights integer,
--    match_deposit_policy boolean,
--    tax_inclusive boolean,
--    active boolean,
--    tenant_id text,
--    property_id text,
--    policy_type text,
--    reference_id text
--);

--ADD CONSTRAINT cancellation_policy_pkey PRIMARY KEY (id);

--CREATE INDEX idx_cancellation_policies_tid_pid_id ON public.cancellation_policies USING btree (tenant_id, property_id, id);

--select * into StayDWH.dbo.cancellation_policies_Snapshot from OPENQUERY(Stay_PostgreSQL,'select * from stay_prod.public.cancellation_policies LIMIT 5');

USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[cancellation_policies_Snapshot] ;
GO

CREATE TABLE [dbo].[cancellation_policies_Snapshot](
	[id] [varchar] (200) NOT NULL,
	[code] [varchar] (200) NULL,
	[accounting_item_id] [varchar] (200) NULL,
	[description] [varchar] (200) NULL,
	[days_before_arrival] [int] NULL,
	[days_after_booking] [int] NULL,
	[arrival_time] [int] NULL,
	[flat_fee] [money] NULL,
	[percentage] [money] NULL,
	[nights] [int] NULL,
	[match_deposit_policy] [varchar](5) NULL,
	[tax_inclusive] [varchar](5) NULL,
	[active] [varchar](5) NULL,
	[tenant_id] [varchar] (10) NOT NULL,
	[property_id] [varchar] (10) NOT NULL,
	[policy_type] [varchar] (200) NULL,
	[reference_id] [varchar] (200) NULL,
 CONSTRAINT [PK_cancellation_policies_Snapshot_tenant_id_property_id_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
	[property_id] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
