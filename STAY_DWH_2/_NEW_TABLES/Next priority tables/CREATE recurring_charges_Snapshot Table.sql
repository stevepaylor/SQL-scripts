--CREATE TABLE public.recurring_charges (
--    id text NOT NULL,
--    account_id text,
--    original_amount numeric(19,2),
--    auto_recurring_item_id text,
--    end_date date,
--    folio_id text,
--    invalid boolean,
--    item_id text,
--    property_id text,
--    original_quantity integer,
--    room_charge boolean,
--    source_id text,
--    start_date date,
--    tenant_id text,
--    arrival_date date,
--    departure_date date,
--    estimated_subtotal numeric(19,2),
--    estimated_tax numeric(19,2),
--    pet_reference_id text,
--    nights integer,
--    frequency_type text,
--    occurrence_days integer[],
--    auto_recurring_item_status text,
--    reference_id text,
--    charge_type text,
--    transport_charge_reference_id text
--);

--ADD CONSTRAINT recurring_charges_pkey PRIMARY KEY (id);

--CREATE INDEX idx_recurring_charges_tenant_id_property_id_account_id ON public.recurring_charges USING btree (tenant_id, property_id, account_id);

--select *
--into StayDWH.dbo.recurring_charges_Snapshot
--from OPENQUERY(Stay_PostgreSQL,'
--select 
--  id --text NOT NULL
--, account_id --text,
--, original_amount --numeric(19,2),
--, auto_recurring_item_id --text,
--, end_date --date,
--, folio_id --text,
--, invalid --boolean,
--, item_id --text,
--, property_id --text,
--, original_quantity --integer,
--, room_charge --boolean,
--, source_id --text,
--, start_date --date,
--, tenant_id --text,
--, arrival_date --date,
--, departure_date --date,
--, estimated_subtotal --numeric(19,2),
--, estimated_tax --numeric(19,2),
--, pet_reference_id --text,
--, nights --integer,
--, frequency_type --text,
----, occurrence_days --integer[],
--, CAST(array_to_string(occurrence_days, '' , ''''*'') as varchar(200)) as occurrence_days
--, auto_recurring_item_status --text,
--, reference_id --text,
--, charge_type --text,
--, transport_charge_reference_id --text
--from stay_prod.public.recurring_charges 
-- LIMIT 5
-- ');

USE [StayDWH]
GO

/****** Object:  Table [dbo].[recurring_charges_Snapshot]    Script Date: 4/27/2024 2:31:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[recurring_charges_Snapshot](
	[id] [text] NOT NULL,
	[account_id] [text] NULL,
	[original_amount] [numeric](19, 2) NULL,
	[auto_recurring_item_id] [text] NULL,
	[end_date] [date] NULL,
	[folio_id] [text] NULL,
	[invalid] [varchar](5) NULL,
	[item_id] [text] NULL,
	[property_id] [text] NULL,
	[original_quantity] [int] NULL,
	[room_charge] [varchar](5) NULL,
	[source_id] [text] NULL,
	[start_date] [date] NULL,
	[tenant_id] [text] NULL,
	[arrival_date] [date] NULL,
	[departure_date] [date] NULL,
	[estimated_subtotal] [numeric](19, 2) NULL,
	[estimated_tax] [numeric](19, 2) NULL,
	[pet_reference_id] [text] NULL,
	[nights] [int] NULL,
	[frequency_type] [text] NULL,
	[occurrence_days] [varchar](200) NULL,
	[auto_recurring_item_status] [text] NULL,
	[reference_id] [text] NULL,
	[charge_type] [text] NULL,
	[transport_charge_reference_id] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

