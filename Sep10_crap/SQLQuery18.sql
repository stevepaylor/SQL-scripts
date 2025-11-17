TRUNCATE TABLE [StayDWH].[dbo].[iQ_Gaming_Hotel_Transactions]
GO

INSERT INTO [StayDWH].[dbo].[iQ_Gaming_Hotel_Transactions]
SELECT *
FROM DWHDB01PR.[StayDWH].[dbo].[iQ_Gaming_Hotel_Transactions]