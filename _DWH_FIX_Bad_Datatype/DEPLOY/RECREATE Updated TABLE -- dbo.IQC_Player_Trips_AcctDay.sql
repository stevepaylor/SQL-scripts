USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQC_Player_Trips_AcctDay_save
FROM dbo.IQC_Player_Trips_AcctDay
GO

DROP TABLE IF EXISTS dbo.[IQC_Player_Trips_AcctDay]
GO

/****** Object:  Table dbo.[IQC_Player_Trips_AcctDay]    Script Date: 8/22/2023 10:43:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.[IQC_Player_Trips_AcctDay](
	[PlayerID] [int] NOT NULL,
	[CasinoCode] [char](4) NOT NULL,
	[TripNumber] [int] NOT NULL,
	[TripBeginDate] [datetime] NULL,
	[TripEndDate] [datetime] NULL,
	[accountingdateID_TripBegin] [int] NULL,
	[accountingdateID_TripEnd] [int] NULL,
	[TripKey] [varchar](30) NOT NULL,
 CONSTRAINT [PK_IQC_Player_Trips_AcctDay] PRIMARY KEY CLUSTERED 
(
	[TripKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO