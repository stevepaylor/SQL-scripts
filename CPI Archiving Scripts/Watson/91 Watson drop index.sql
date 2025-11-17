USE Watson;

DROP INDEX IX_Call_BvCalls_createdDatetimeUtc ON [Call].BvCalls;
DROP INDEX IX_Log_AssetsActivities_activityDateTimeUtc ON [Log].AssetsActivities;
DROP INDEX IX_Asset_BleStatusHistory_createdDateTimeUtc ON  Asset.BleStatusHistory;
DROP INDEX IX_Bills_AcceptedNote_createdDatetimeUtc ON Bills.AcceptedNotes;
DROP INDEX IX_Bills_AcceptedTickets_createdDatetimeUtc ON Bills.AcceptedTickets;
DROP INDEX IX_Bills_BillSummary_createdDateTimeUtc ON Bills.BillSummary;
DROP INDEX IX_Bills_AcceptanceSummary_createdDateTimeUtc ON Bills.AcceptanceSummary;
DROP INDEX IX_Bills_RejectionSummary_createdDateTimeUtc ON Bills.RejectionSummary;
DROP INDEX IX_DataCollectIncoming_DataCollectRecords_createdDatetimeUtc ON DataCollectIncoming.DataCollectRecords;