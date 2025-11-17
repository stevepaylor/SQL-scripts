USE [iQ-Gaming]
GO

-- LINE 59 PARMID 269
UPDATE [dbo].[IQ_Job_Parameters]
   SET [Parm_Value] = 'RPTDB01PR.CMP13_REPL'
 WHERE [Parm_Value] = '[CMKTDB13CPR].[CMP13]'
GO

-----------------------------------------------------------------------------------------------

USE [iQ-Gaming]
GO

-- LINE 1 PROPPARMID 30
UPDATE [dbo].[IQ_Job_Property_Parameters]
   SET [Parm_Value] = 'RPTDB01PR'
 WHERE [Parm_Value] = '[CMKTDB13DPR]'
GO

-- LINE 2 PROPPARMID 31
UPDATE [dbo].[IQ_Job_Property_Parameters]
   SET [Parm_Value] = 'INFODBLS01PR.ig_business'
 WHERE [Parm_Value] = '[INFODB01PR].[ig_business]'
GO

-- LINE 3 PROPPARMID 3
UPDATE [dbo].[IQ_Job_Property_Parameters]
   SET [Parm_Value] = 'INFODBLS01PR.ig_dimension'
 WHERE [Parm_Value] = '[INFODB01PR].[ig_dimension]'
GO

-- LINE 6 PROPPARMID 6
UPDATE [dbo].[IQ_Job_Property_Parameters]
   SET [Parm_Value] = 'INFODBLS01PR'
 WHERE [Parm_Value] = '[INFODB01PR]'
GO

-- LINE 9 PROPPARMID 36
-- LINE 19 PROPPARMID 50
UPDATE [dbo].[IQ_Job_Property_Parameters]
   SET [Parm_Value] = 'RPTDB01PR.CMP13_REPL'
 WHERE [Parm_Value] = '[CMKTDB13DPR].[CMP13]'
GO

-- LINE 33 PROPPARMID 39
UPDATE [dbo].[IQ_Job_Property_Parameters]
   SET [Parm_Value] = '[CASINODBLIS01PR].[vBus]'
 WHERE [Parm_Value] = '[CASIDBLIS01PR].[vBus]'
GO


