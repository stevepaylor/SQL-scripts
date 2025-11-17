USE [iQ-Gaming]
GO

/****** Object:  Table [player].[tab_player_dim]    Script Date: 6/28/2023 6:28:11 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[player].[tab_player_dim]') AND type in (N'U'))
DROP TABLE [player].[tab_player_dim]
GO

/****** Object:  Table [player].[tab_player_dim]    Script Date: 6/28/2023 6:28:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [player].[tab_player_dim](
	[PLAYER_KEY] [int] IDENTITY(1,1) NOT NULL,
	[player_id] [int] NOT NULL,
	[player_account_number] [int] NOT NULL,
	[player_first_name] [nvarchar](25) NULL,
	[player_last_name] [nvarchar](25) NULL,
	[player_display_name] [nvarchar](100) NULL,
	[player_type] [nvarchar](25) NULL,
	[player_club_level] [nvarchar](25) NULL,
	[player_club_anniversary] [datetime] NULL,
	[player_signup_date] [datetime] NULL,
	[player_address1] [nvarchar](50) NULL,
	[player_address2] [nvarchar](20) NULL,
	[player_city] [nvarchar](50) NULL,
	[player_state] [nvarchar](25) NULL,
	[player_zip] [nvarchar](25) NULL,
	[player_country] [nvarchar](25) NULL,
	[player_email] [nvarchar](255) NULL,
	[player_phone] [nvarchar](25) NULL,
	[player_birthdate] [datetime] NULL,
	[player_gender] [nvarchar](10) NULL,
	[player_host] [nvarchar](50) NULL,
	[player_host_coded_date] [datetime] NULL,
	[player_first_trip_date] [datetime] NULL,
	[player_last_trip_date] [datetime] NULL,
	[player_age] [int] NULL,
	[player_age_category] [nvarchar](25) NULL,
	[player_gaming_type] [nvarchar](25) NULL,
	[player_slot_type] [nvarchar](25) NULL,
	[player_table_type] [nvarchar](25) NULL,
	[player_isbanned] [bit] NULL,
	[player_isinactive] [bit] NULL,
	[player_isclubhold] [bit] NULL,
	[player_isnomail] [bit] NULL,
	[player_frequency] [nvarchar](25) NULL,
	[player_adt_category] [nvarchar](25) NULL,
	[player_lifecycle] [nvarchar](25) NULL,
	[dw_timestamp] [datetime] NOT NULL,
	[timestamp] [timestamp] NOT NULL,
	[player_point_bal] [int] NULL,
	[player_stub_bal] [money] NULL,
	[player_promo2_bal] [money] NULL,
	[player_FPC_bal] [money] NULL,
	[points_bal_club] [int] NOT NULL,
	[behavior_trip] [int] NOT NULL,
	[player_isreturnmail] [bit] NOT NULL,
	[player_isemailsend] [bit] NOT NULL,
	[player_last_club_level] [nvarchar](25) NULL,
	[player_club_level_change_date] [datetime] NULL,
	[player_comp_bal] [money] NOT NULL,
	[player_ismerge] [bit] NOT NULL,
	[player_iscall] [bit] NOT NULL,
	[player_issendtextmessage] [bit] NOT NULL,
	[CompReinvestHist] [money] NOT NULL,
	[CompReinvestHistNoHotel] [money] NOT NULL,
 CONSTRAINT [PK_player_tab_player_dim] PRIMARY KEY CLUSTERED 
(
	[PLAYER_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT (getdate()) FOR [dw_timestamp]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT ((0)) FOR [points_bal_club]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT ((0)) FOR [behavior_trip]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT ((0)) FOR [player_isreturnmail]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT ((0)) FOR [player_isemailsend]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT ((0)) FOR [player_comp_bal]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT ((0)) FOR [player_ismerge]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT ((1)) FOR [player_iscall]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT ((0)) FOR [player_issendtextmessage]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT ((0)) FOR [CompReinvestHist]
GO

ALTER TABLE [player].[tab_player_dim] ADD  DEFAULT ((0)) FOR [CompReinvestHistNoHotel]
GO



USE [iQ-Gaming]
GO

--SET IDENTITY_INSERT [player].[tab_player_dim] ON;  
--GO

INSERT INTO [player].[tab_player_dim]
SELECT --TOP 10 
--[PLAYER_KEY] ,
  [player_id]
, [player_account_number]
, [player_first_name]
, [player_last_name]
, [player_display_name]
, [player_type]
, [player_club_level]
, [player_club_anniversary]
, [player_signup_date]
, [player_address1]
, [player_address2]
, [player_city]
, [player_state]
, [player_zip]
, [player_country]
, [player_email]
, [player_phone]
, [player_birthdate]
, [player_gender]
, [player_host]
, [player_host_coded_date]
, [player_first_trip_date]
, [player_last_trip_date]
, [player_age], [player_age_category]
, [player_gaming_type]
, [player_slot_type]
, [player_table_type]
, [player_isbanned]
, [player_isinactive]
, [player_isclubhold]
, [player_isnomail]
, [player_frequency]
, [player_adt_category]
, [player_lifecycle]
, [dw_timestamp]
, NULL AS [timestamp]
, [player_point_bal]
, [player_stub_bal]
, [player_promo2_bal]
, [player_FPC_bal]
, [points_bal_club]
, [behavior_trip]
, [player_isreturnmail]
, [player_isemailsend]
, [player_last_club_level]
, [player_club_level_change_date]
, [player_comp_bal]
, [player_ismerge]
, [player_iscall]
, [player_issendtextmessage]
, [CompReinvestHist]
, [CompReinvestHistNoHotel]

FROM [MSBIDB02DV].[vDW].[player].[tab_player_dim]
WHERE [dw_timestamp] >= '2018-01-01'
GO