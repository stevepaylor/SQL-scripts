SELECT top 100 [RESV_NAME_ID]
      ,[MEMBERSHIP_NUMBER]
      ,[RATE_DATE]
      ,[Room_Comp]
      ,[Food_Comp]
      ,[Misc_Comp]
      ,[RATE_CODE]
      ,[PROMOTIONS]
      ,[ROOM_CATEGORY_LABEL]
  FROM DWHDB01PR.[StayDWH].[dbo].[iQ_Gaming_Hotel_Transactions]

  ORDER BY [RATE_DATE] DESC

SELECT top 100 [RESV_NAME_ID]
      ,[MEMBERSHIP_NUMBER]
      ,[RATE_DATE]
      ,[Room_Comp]
      ,[Food_Comp]
      ,[Misc_Comp]
      ,[RATE_CODE]
      ,[PROMOTIONS]
      ,[ROOM_CATEGORY_LABEL]
  FROM [StayDWH].[dbo].[iQ_Gaming_Hotel_Transactions]

    ORDER BY [RATE_DATE] DESC