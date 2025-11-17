USE [iQ-Gaming]
GO

/****** Object:  Table [config].[tab_player_id_pull]    Script Date: 6/28/2023 7:41:36 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[config].[tab_player_id_pull]') AND type in (N'U'))
DROP TABLE [config].[tab_player_id_pull]
GO

/****** Object:  Table [config].[tab_player_id_pull]    Script Date: 6/28/2023 7:41:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [config].[tab_player_id_pull](
	[player_id] [int] NOT NULL,
 CONSTRAINT [PK_config_tab_player_id_pull] PRIMARY KEY CLUSTERED 
(
	[player_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO [iQ-gaming].[config].[tab_player_id_pull]
SELECT *
FROM [MSBIDB02DV].[vDW].[config].[tab_player_id_pull]
GO