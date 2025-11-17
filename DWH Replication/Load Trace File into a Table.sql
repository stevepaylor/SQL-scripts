USE DBA
GO

INSERT INTO temp_trc 
--SELECT [TextData], [BinaryData], [DatabaseID], [TransactionID], [LineNumber], [NTUserName], [NTDomainName], [HostName], [ClientProcessID], [ApplicationName], [LoginName], [SPID], [Duration], [StartTime], [EndTime], [Reads], [Writes], [CPU], [Permissions], [Severity], [EventSubClass], [ObjectID], [Success], [IndexID], [IntegerData], [ServerName], [EventClass], [ObjectType], [NestLevel], [State], [Error], [Mode], [Handle], [ObjectName], [DatabaseName], [FileName], [OwnerName], [RoleName], [TargetUserName], [DBUserName], [LoginSid], [TargetLoginName], [TargetLoginSid], [ColumnPermissions], [LinkedServerName], [ProviderName], [MethodName], [RowCounts], [RequestID], [XactSequence], [EventSequence], [BigintData1], [BigintData2], [GUID], [IntegerData2], [ObjectID2], [Type], [OwnerID], [ParentName], [IsSystem], [Offset], [SourceDatabaseID], [SqlHandle], [SessionLoginName], [PlanHandle], [GroupID]
SELECT *
FROM fn_trace_gettable('E:\Profiler_Traces\Trace_Durations_3.trc', default);  
GO  