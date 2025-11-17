USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQH_Hotel_Guests_save
FROM dbo.IQH_Hotel_Guests
GO

DROP TABLE IF EXISTS [dbo].[IQH_Hotel_Guests]
GO

/****** Object:  Table [dbo].[IQH_Hotel_Guests]    Script Date: 8/21/2023 4:38:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQH_Hotel_Guests](
	[reservationID] [varchar](20) NOT NULL,
	[playerID] [bigint] NULL,
	[salutation] [varchar](12) NULL,
	[firstName] [varchar](40) NULL,
	[lastName] [varchar](40) NULL,
	[gender] [char](1) NULL,
	[eMail] [varchar](100) NULL,
	[phone] [varchar](20) NULL,
	[arrivalDate] [datetime] NULL,
	[arrivalDateID] [smallint] NULL,
	[departureDate] [datetime] NULL,
	[departureDateID] [smallint] NULL,
	[reservationDate] [datetime] NULL,
	[reservationDateID] [smallint] NULL,
	[ReservationType] [varchar](20) NULL,
	[ReservationStatus] [varchar](20) NULL,
	[sourceOfBusinessCode] [varchar](10) NULL,
	[NumberOfRooms] [int] NULL,
	[NumberOfPersonsOnReservation] [int] NULL,
	[NumberOfChildrenType1] [int] NULL,
	[NumberOfChildrenType2] [int] NULL,
	[NumberOfChildrenType3] [int] NULL,
	[wingCode] [varchar](10) NULL,
	[Confirmation_No] [nvarchar](50) NULL,
	[promotion_code] [varchar](25) NULL,
	[market_code] [varchar](5) NULL,
	[market_main_group] [varchar](10) NULL,
	[roomType] [varchar](10) NULL,
	[SuiteID] [varchar](5) NULL,
	[bookingCode] [varchar](20) NULL,
	[groupType] [char](2) NULL,
	[modifiedDate] [datetime] NULL,
	[modifiedDateID] [smallint] NULL,
	[testAccount] [smallint] NULL,
	[casinoCode] [char](4) NULL,
	[manualUpdate] [smallint] NULL,
	[LoadDttm] [datetime] NULL,
	[FB_Revenue] [money] NULL,
	[Room_Revenue] [money] NULL,
	[Total_Revenue] [money] NULL,
	[My_Room_Rate] [money] NULL,
	[TicketType] [char](2) NULL,
	[TicketSequence] [decimal](7, 0) NULL,
	[ManuallyPosted] [char](1) NULL,
	[AddressLine1] [varchar](100) NULL,
	[AddressLine2] [varchar](100) NULL,
	[City] [varchar](40) NULL,
	[State] [char](2) NULL,
	[ZipCode] [varchar](10) NULL,
	[Zip4] [char](4) NULL,
	[Country] [varchar](25) NULL,
	[Market] [varchar](25) NULL,
	[Distance] [smallint] NULL,
	[LocalPatron] [char](1) NULL,
	[BadAddress] [tinyint] NULL,
	[matchNameCode] [varchar](200) NULL,
	[matchAddressCode] [varchar](200) NULL,
	[Room] [varchar](10) NULL,
	[block_code] [varchar](25) NULL,
	[block_description] [varchar](50) NULL
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source system Reservation identifier the Guest record     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'reservationID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerID from the casino system     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'playerID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ex: Mr, Mrs, etc. if available from the Source System     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'salutation'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The First Name of the Guest     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'firstName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Last Name of the Guest     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'lastName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Gender of the Guest - M, F, U (Unknown)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'gender'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email address of the Guest     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'eMail'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Guest Phone Number     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'phone'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Arrival Date of the Guest for the Reservation     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'arrivalDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the Arrival Date (lookup to iQ_Calendar)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'arrivalDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Departure Date of the Guest for the Reservation     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'departureDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the Departure Date (lookup to iQ_Calendar)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'departureDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the Reservation was made     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'reservationDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the Reservation Date (lookup to iQ_Calendar)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'reservationDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reservation Type.  Ex:  I – Individual, C – Group, etc.     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'ReservationType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reservation Status     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'ReservationStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source of Business code (lookup to iQH_Source_of_Business)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'sourceOfBusinessCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of Rooms on the reservation     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'NumberOfRooms'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of people on the reservation     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'NumberOfPersonsOnReservation'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System grouping of Children by Age (Group 1)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'NumberOfChildrenType1'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System grouping of Children by Age (Group 2)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'NumberOfChildrenType2'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System grouping of Children by Age (Group 3)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'NumberOfChildrenType3'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Wing Code of the Hotel for the Reservation (lookup to iQH_Wing_Code)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'wingCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Confirmation Number  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'Confirmation_No'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Promotion Code  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'promotion_code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Market Code  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'market_code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Market Main Group  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'market_main_group'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Room Type for the Reservation (lookup to iQH_Room_Type)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'roomType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Code identifying the room as a Suite     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'SuiteID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Booking or Group code     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'bookingCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The source system Group Type code on the reservation     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'groupType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Modified Date for the Guest record     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'modifiedDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the Modified Date (lookup to iQ_Calendar)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'modifiedDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indicator identifying the Guest as a Test Account     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'testAccount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Property (casino) code for the Hotel     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'casinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'True/false if the record has been updated manually     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'manualUpdate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date data row was loaded to the table     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'LoadDttm'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'FB Revenue  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'FB_Revenue'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Room Revenue  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'Room_Revenue'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Revenue  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'Total_Revenue'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'My_Room_Rate  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'My_Room_Rate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TicketType  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'TicketType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TicketSequence  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'TicketSequence'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ManuallyPosted  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'ManuallyPosted'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AddressLine1  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'AddressLine1'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AddressLine2  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'AddressLine2'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'City  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'City'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'State  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'State'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ZipCode  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'ZipCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Zip4  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'Zip4'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Country  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'Country'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Market  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'Market'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Distance  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'Distance'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LocalPatron  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'LocalPatron'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BadAddress  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'BadAddress'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'matchNameCode  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'matchNameCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'matchAddressCode  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'matchAddressCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'block_code  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'block_code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'block_description  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQH_Hotel_Guests', @level2type=N'COLUMN',@level2name=N'block_description'
GO


