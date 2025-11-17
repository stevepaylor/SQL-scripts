/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [SlotGatewayReceiveId]
      ,[InterfaceName]
      ,[RequestMessage]
      ,[ResponseMessage]
      ,[ReceivedDtm]
      ,[ProcessedDtm]
      ,[PostedBy]
      ,[IsProcessed]
      ,[ErrorMsg]
      ,[ErrorMsgDtl]
      ,[MsgChecksum2]
      ,[RelatedRecieveId]
      ,[AcctNo]
      ,[DataRowVersion]
  --FROM [CMP13].[dbo].[tSlotGatewayReceive]
	--FROM [CMP13].[dbo].[tSlotGatewayReceive_12112019]
	--FROM [CMP13].[dbo].[tSlotGatewayReceive_121319_1]
	--FROM [CMP13].[dbo].[tSlotGatewayReceive_121319_2]
	FROM [CMP13].[dbo].[tSlotGatewayReceive_bkUP02272017]


WHERE ReceivedDtm >= '2020-11-01'
  AND ReceivedDtm < '2021-03-01'

	ORDER BY [ReceivedDtm] 