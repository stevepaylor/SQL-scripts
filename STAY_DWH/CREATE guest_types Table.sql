------------------------------------------------------------------
-- guest_types
------------------------------------------------------------------
USE [StayDWH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[guest_types] ;
GO

CREATE TABLE [dbo].[guest_types](
	[tenant_id] [varchar](200) NOT NULL,
	[property_id] [varchar](200) NOT NULL,
	[id] [varchar](200) NOT NULL,
	[name] [varchar](200) NULL,
	[code] [varchar](200) NULL,
	[gl_code] [varchar](200) NULL,
	[active] [int] NULL,
	[Local_ETL_Inserted_TS] [datetime] NULL,
	[Local_ETL_Updated_TS] [datetime] NULL,
 CONSTRAINT [PK_guest_types_id] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC ,
	[property_id] ASC ,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



--CREATE TABLE public.guest_types (
--    tenant_id text NOT NULL,
--    property_id text NOT NULL,
--    id text NOT NULL,
--    name text,
--    code text,
--    gl_code text,
--    active boolean
--);

--ADD CONSTRAINT guest_type_pkey PRIMARY KEY (tenant_id, property_id, id);
