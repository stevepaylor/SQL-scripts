-- run these backup commands on the primary noded

backup database CMPAPI to disk='\\CMKTDB13BPR\SQLBackup\CMPAPI.BAK'
GO

backup database CMPSDS to disk='\\CMKTDB13BPR\SQLBackup\CMPSDS.BAK'
GO

backup database dbInfogenesis to disk='\\CMKTDB13BPR\SQLBackup\dbInfogenesis.BAK'
GO

backup database PrintManager to disk='\\CMKTDB13BPR\SQLBackup\PrintManager.BAK'
GO

backup database TV13 to disk='\\CMKTDB13BPR\SQLBackup\TV13.BAK'
GO

backup database TVAlert13 to disk='\\CMKTDB13BPR\SQLBackup\TVAlert13.BAK'
GO

backup database vCMSUpdate to disk='\\CMKTDB13BPR\SQLBackup\vCMSUpdate.BAK'
GO

backup database ZipCodes to disk='\\CMKTDB13BPR\SQLBackup\ZipCodes.BAK'
GO

backup log CMPAPI to disk='\\CMKTDB13BPR\SQLBackup\CMPAPI.TRN'
GO

backup log CMPSDS to disk='\\CMKTDB13BPR\SQLBackup\CMPSDS.TRN'
GO

backup log dbInfogenesis to disk='\\CMKTDB13BPR\SQLBackup\dbInfogenesis.TRN'
GO

backup log PrintManager to disk='\\CMKTDB13BPR\SQLBackup\PrintManager.TRN'
GO

backup log TV13 to disk='\\CMKTDB13BPR\SQLBackup\TV13.TRN'
GO

backup log TVAlert13 to disk='\\CMKTDB13BPR\SQLBackup\TVAlert13.TRN'
GO

backup log vCMSUpdate to disk='\\CMKTDB13BPR\SQLBackup\vCMSUpdate.TRN'
GO

backup log ZipCodes to disk='\\CMKTDB13BPR\SQLBackup\ZipCodes.TRN'
GO

-- run these restore and HR commands on the primary noded

restore log CMP13 from disk='\\CMKTDB13BPR\SQLBackup\CMP13.trn' with norecovery
go

alter database CMP13 set HADR availability group= CMKTAG13pr
go