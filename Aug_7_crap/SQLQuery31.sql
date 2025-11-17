TRUNCATE TABLE [iQ-Gaming].[CMP_13-1].[tSlotGatewayReceive_Staging]
GO

--INSERT INTO [iQ-Gaming].[CMP_13-1].[tSlotGatewayReceive_Staging]
SELECT *
INTO [iQ-Gaming].[CMP_13-1].[tSlotGatewayReceive_Staging]
FROM CMPDBLIS01PR. [CMP13].[dbo].[tSlotGatewayReceive]

--SELECT count(*)
--FROM CMPDBLIS01PR.[CMP13].[dbo].[tSlotGatewayReceive]

--tSlotGatewayReceive_HIST