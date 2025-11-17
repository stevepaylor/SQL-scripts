USE Watson;

CREATE INDEX IX_Log_AssetsActivities_activityDateTimeUtc ON [Log].AssetsActivities(activityDateTimeUtc);
--CREATE INDEX IX_LiveDataIncoming_LiveDataRecords_messageDatetimeUtc ON LiveDataIncoming.LiveDataRecords(messageDatetimeUtc) --index already exists
CREATE INDEX IX_Asset_BleStatusHistory_createdDateTimeUtc ON  Asset.BleStatusHistory(createdDateTimeUtc);
CREATE INDEX IX_Bills_AcceptedNote_createdDatetimeUtc ON Bills.AcceptedNotes(createdDatetimeUtc);
CREATE INDEX IX_Bills_AcceptedTickets_createdDatetimeUtc ON Bills.AcceptedTickets(createdDatetimeUtc);
CREATE INDEX IX_Bills_BillSummary_createdDateTimeUtc ON Bills.BillSummary(createdDateTimeUtc);
CREATE INDEX IX_Bills_AcceptanceSummary_createdDateTimeUtc ON Bills.AcceptanceSummary(createdDateTimeUtc);
CREATE INDEX IX_Bills_RejectionSummary_createdDateTimeUtc ON Bills.RejectionSummary(createdDateTimeUtc);
CREATE INDEX IX_DataCollectIncoming_DataCollectRecords_createdDatetimeUtc ON DataCollectIncoming.DataCollectRecords(createdDatetimeUtc);