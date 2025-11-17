--Step 1: Create a new table in StayDWH that has the necessary columns for iQ-Gaming 

CREATE TABLE StayDWH.dbo.iQ_Gaming_Hotel_Transactions
(
  [RESV_NAME_ID] VARCHAR(200) NOT NULL,
[MEMBERSHIP_NUMBER] VARCHAR(200) NOT NULL,
[RATE_DATE] DATE NOT NULL,
[Room_Comp] MONEY NULL DEFAULT 0,
[Food_Comp] MONEY NULL DEFAULT 0,
[Misc_Comp] MONEY NULL DEFAULT 0,
[RATE_CODE] NVARCHAR(200) NOT NULL,
[PROMOTIONS] VARCHAR(200) NULL,
[ROOM_CATEGORY_LABEL] VARCHAR(200) NULL
);

--Step 2: Create a clustered index on this table as below: (DO NOT put a PK on the table)

CREATE CLUSTERED INDEX IX_iQ_Gaming_Hotel_Transactions ON StayDWH.dbo.iQ_Gaming_Hotel_Transactions(RESV_NAME_ID, MEMBERSHIP_NUMBER, RATE_DATE);

CREATE NONCLUSTERED INDEX [NCIX_ROOM_CATEGORY_LABEL] ON StayDWH.[dbo].[iQ_Gaming_Hotel_Transactions](ROOM_CATEGORY_LABEL ASC);


--Step 3: Run the StayDWH import from the Hotel system. Once the import is finished, run the following commands:

BEGIN TRANSACTION;

TRUNCATE TABLE StayDWH.dbo.iQ_Gaming_Hotel_Transactions;

INSERT INTO StayDWH.dbo.iQ_Gaming_Hotel_Transactions(RESV_NAME_ID, MEMBERSHIP_NUMBER, RATE_DATE, Room_Comp, Food_Comp, Misc_Comp, RATE_CODE, PROMOTIONS,ROOM_CATEGORY_LABEL)
SELECT SW.RESV_NAME_ID,
SW.MEMBERSHIP_NUMBER,
SW.RATE_DATE,
SW.Room_Comp,
SW.Food_Comp,
SW.Misc_Comp,
SW.RATE_CODE,
SW.Promotions,
SW.ROOM_CATEGORY_LABEL
FROM [DWHDB01PR].[StayDWH].[dbo].vw_Name_Reservation_CARL SW   --This view does not have NOLOCK, so no possibility of a dirty read
WHERE SW.OFFER_STATUS = 'REDEEMED'
AND SW.RATE_DATE BETWEEN DATEADD(MONTH, -3, GETDATE()) AND GETDATE()
AND (ISNULL(SW.Food_Comp,0) <> 0 OR ISNULL(SW.Misc_Comp,0) <> 0 OR ISNULL(SW.Room_comp,0) <> 0)

COMMIT TRANSACTION;

--The query above should populate the table very quickly, so reading this table (i.e. SELECT) without a NOLOCK should run extremely fast. 3 months worth of data will result in roughly 30k records, which isn't a lot

--Step 4: I will change the Stay import in iQ-Gaming to use the table above (iQ_Gaming_Hotel_Transactions) instead of the [StayDWH].[dbo].vw_Name_Reservation or [StayDWH].[dbo].vw_Name_Reservation_CARL

DROP TABLE IF EXISTS #Stay_Hotel_Transactions

SELECT SW.Room_comp, SW.Food_Comp + SW.Misc_Comp AS Room_Charges, SW.RATE_DATE, Q.DateId,
CASE WHEN SW.Room_comp = 0 THEN 0 ELSE HCR.WD_Rate END AS WD_Rate,  
CASE WHEN SW.Room_comp = 0 THEN 0 ELSE HCR.WE_Rate END AS WE_Rate, ISNULL(PC.PlayerId, 0) AS PlayerId, SW.RESV_NAME_ID, HCR.RoomCode,
SW.Rate_Code,
SW.Promotions,
ROOM_CATEGORY_LABEL

INTO #Stay_Hotel_Transactions

FROM [StayDWH].[dbo].iQ_Gaming_Hotel_Transactions SW 
LEFT JOIN [iQ-Gaming].[CMP_13-1].tPlayerCard PC ON SW.MEMBERSHIP_NUMBER = PC.Acct
LEFT JOIN [iQ-Gaming].[VCR].[HotelCompRate] HCR ON SW.ROOM_CATEGORY_LABEL = HCR.ROOMCODE
INNER JOIN [iQ-Gaming].[dbo].IQ_Calendar Q ON SW.RATE_DATE = Q.CalendarDate 

WHERE ISNULL(PC.PlayerId, 0) <> 0

SELECT TOP 1000 *
FROM #Stay_Hotel_Transactions 


--FINAL COMMENT: 

--The apporach above should enable us to turn on the StayDWH imports more frequently again (hopefully the previous days transactions will be available when the iQ-Gaming daily job runs).

--MARKETING AND FINANCE:  

--If you are running ad-hoc queries during the day against the StayDWH I suggest you use vw_Name_Reservation_CARL. This query will give you transactional consistency. 
--If the query times out you can assume that an update transaction is currently locking one or more of the underlying tables in the query. If you use any query with READ UNCOMMITTED OR NOLOCK
--then expect dirty reads. 








