SELECT 
       [playerID],
       [GamingDate],
       [Award_CompsUsed_Hotel_Finance],
       [Award_CompsUsed_Hotel_MKTG],
       [Hotel_CompsNoRooms_GrossAmount]
FROM [iQ-Gaming].[dbo].[v_IQC_Awards]
WHERE playerID = 74 AND GamingDate >= '1/1/2024' AND (Award_CompsUsed_Hotel_Finance + Award_CompsUsed_Hotel_MKTG) > 0


SELECT 
       [PlayerId],
       [BusinessDate],
       [Award_CompsUsed_Hotel_MKTG],
       [Award_CompsUsed_Hotel_Finance],
       [Hotel_CompsNoRooms_GrossAmount]
FROM [iQ-Gaming].[dbo].[v_IQC_Player_Daily_Hotel]
WHERE PlayerId = 74 AND BusinessDate >= '1/1/2024'
