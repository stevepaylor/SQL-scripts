CREATE INDEX [IX_JPX_KioskDispense_jackpotID_dispenseType_9937D] 
ON [EveriTitle31].[dbo].[JPX_KioskDispense] ([jackpotID], [dispenseType])

CREATE INDEX [IX_JPX_KioskDispense_jackpotID_kioskAssetID_kioskWorkstationID_69405] 
ON [EveriTitle31].[dbo].[JPX_KioskDispense] ([jackpotID],[kioskAssetID], [kioskWorkstationID])

CREATE INDEX [IX_JPX_KioskRedeem_propertyId_redeemCode_redeemStatus_C9943] 
ON [EveriTitle31].[dbo].[JPX_KioskRedeem] ([propertyId], [redeemCode], [redeemStatus])

CREATE INDEX [IX_JPX_KioskRedeem_redeemCode_B6212] 
ON [EveriTitle31].[dbo].[JPX_KioskRedeem] ([redeemCode])

CREATE INDEX [IX_JPX_KioskRedeem_redeemStatus_createdBy_createdAt_A479D] 
ON [EveriTitle31].[dbo].[JPX_KioskRedeem] ([redeemStatus], [createdBy],[createdAt]) INCLUDE ([redeemCode], [requestAmount], [dispensedAmount], [activeAt])

CREATE INDEX [IX_JPX_KioskRedeem_propertyId_redeemCode_redeemStatus_AD7BA] 
ON [EveriTitle31].[dbo].[JPX_KioskRedeem] ([propertyId], [redeemCode], [redeemStatus]) INCLUDE ([ID], [jackpotIDs], [requestAmount], [dispensedAmount], [createdAt], [createdBy], [activeKioskWorkstation], [activeAt])

CREATE INDEX [IX_JX_TaxForms_jxid_propertyId_isVoid_F477B] 
ON [EveriTitle31].[dbo].[JX_TaxForms] ([jxid], [propertyId], [isVoid]) INCLUDE ([ID], [patronID], [transDate], [taxFormType], [taxFormJSON], [taxFormSig], [createdAt], [createdBy])

CREATE INDEX [IX_JX_TaxForms_jxid_propertyId_isVoid_AC940] 
ON [EveriTitle31].[dbo].[JX_TaxForms] ([jxid], [propertyId], [isVoid])

CREATE INDEX [IX_JX_TaxForms_isAggregated_sentToCore_460D5] 
ON [EveriTitle31].[dbo].[JX_TaxForms] ([isAggregated], [sentToCore])

CREATE INDEX [IX_T31_1042S_PropertyId_PatronId_trxdate_typename_05A5D] 
ON [EveriTitle31].[dbo].[T31_1042S] ([PropertyId], [PatronId], [trxdate], [typename])

CREATE INDEX [IX_T31_1042S_PropertyId_PatronId_trxdate_typename_SubmissionStatus_CBFF4] 
ON [EveriTitle31].[dbo].[T31_1042S] ([PropertyId], [PatronId], [trxdate], [typename],[SubmissionStatus])

CREATE INDEX [IX_T31_1042S_PropertyId_jackpotID_8D134] 
ON [EveriTitle31].[dbo].[T31_1042S] ([PropertyId], [jackpotID])

CREATE INDEX [IX_T31_1042S_IsVoid_08AD3] 
ON [EveriTitle31].[dbo].[T31_1042S] ([IsVoid]) INCLUDE ([PropertyId], [PatronId], [F1042SId], [ID], [jackpotID])

CREATE INDEX [IX_T31_1042S_PropertyId_F1042SId_750F2] 
ON [EveriTitle31].[dbo].[T31_1042S] ([PropertyId], [F1042SId])

CREATE INDEX [IX_T31_1099_PropertyId_PatronId_trxdate_typename_36B01] 
ON [EveriTitle31].[dbo].[T31_1099] ([PropertyId], [PatronId], [trxdate], [typename])

CREATE INDEX [IX_T31_1099_PropertyId_PatronId_trxdate_typename_SubmissionStatus_A17B8] 
ON [EveriTitle31].[dbo].[T31_1099] ([PropertyId], [PatronId], [trxdate], [typename],[SubmissionStatus])

CREATE INDEX [IX_T31_Audit_AuditType_PropertyId_F4C43] 
ON [EveriTitle31].[dbo].[T31_Audit] ([AuditType], [PropertyId]) INCLUDE ([Key1], [Key2], [Key3], [AuditDate], [Username])

CREATE INDEX [IX_T31_Audit_Key1_Key2_Key3_AuditType_PropertyId_1AE52] 
ON [EveriTitle31].[dbo].[T31_Audit] ([Key1], [Key2], [Key3], [AuditType], [PropertyId]) INCLUDE ([AuditDate], [Field], [NewValue])

CREATE INDEX [IX_T31_Audit_Key1_Key2_Key3_PropertyId_59732] 
ON [EveriTitle31].[dbo].[T31_Audit] ([Key1], [Key2], [Key3], [PropertyId]) INCLUDE ([AuditType], [AuditDate], [Username])

CREATE INDEX [IX_T31_CTRPerson_PropertyId_PersonNo_BA0CF] 
ON [EveriTitle31].[dbo].[T31_CTRPerson] ([PropertyId], [PersonNo])

CREATE INDEX [IX_T31_Customer_PropertyId_LastName_5D9B9] 
ON [EveriTitle31].[dbo].[T31_Customer] ([PropertyId], [LastName]) INCLUDE ([PatronId], [FirstName])

CREATE INDEX [IX_T31_SlotJackpots_T31Status_17CE0] 
ON [EveriTitle31].[dbo].[T31_SlotJackpots] ([T31Status]) INCLUDE ([SlotJPID], [JPDateTime], [JackpotSlipImageStatus], [JackpotTaxFormImageStatus])

CREATE INDEX [IX_T31_SlotJackpots_ProcessedOutsideSJA_T31Status_C31D4] 
ON [EveriTitle31].[dbo].[T31_SlotJackpots] ([ProcessedOutsideSJA],[T31Status]) INCLUDE ([SlotJPID], [JPDateTime], [lastSlotSysCheckAt])

CREATE INDEX [IX_T31_SubTrxAmount_OriginalPatronId_PropertyId_GamingDate_EntryDate_TypeName_CashIn_1692B] 
ON [EveriTitle31].[dbo].[T31_SubTrxAmount] ([OriginalPatronId], [PropertyId], [GamingDate], [EntryDate],[TypeName], [CashIn])

CREATE INDEX [IX_T31_SubTrxAmount_OriginalPatronId_TypeName_PropertyId_TransSrc_GamingDate_EntryDate_7D308] 
ON [EveriTitle31].[dbo].[T31_SubTrxAmount] ([OriginalPatronId], [TypeName], [PropertyId], [TransSrc], [GamingDate], [EntryDate])

CREATE INDEX [IX_T31_SubTrxAmount_TypeName_PropertyId_TransSrc_PatronId_GamingDate_4F729] 
ON [EveriTitle31].[dbo].[T31_SubTrxAmount] ([TypeName], [PropertyId], [TransSrc], [PatronId], [GamingDate]) INCLUDE ([TrxDate], [OriginalPatronId], [CashIn], [CashOut], [TrxLocation], [EntryDate], [MachineLocation], [ForeignCashIn], [ForeignCashOut])

CREATE INDEX [IX_T31_SubTrxAmount_OriginalPatronId_TypeName_PropertyId_GamingDate_18058] 
ON [EveriTitle31].[dbo].[T31_SubTrxAmount] ([OriginalPatronId], [TypeName], [PropertyId], [GamingDate]) INCLUDE ([TrxDate], [TransSrc], [TransKey], [PatronId])

CREATE INDEX [IX_T31_SubTrxAmount_TypeName_PropertyId_TransSrc_PatronId_GamingDate_E47BD] 
ON [EveriTitle31].[dbo].[T31_SubTrxAmount] ([TypeName], [PropertyId], [TransSrc], [PatronId], [GamingDate]) INCLUDE ([TrxDate], [OriginalPatronId], [CashIn], [CashOut], [TrxLocation], [EntryDate], [MachineLocation])

CREATE INDEX [IX_T31_TrxAmount_PropertyId_GamingDate_61CCA] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PropertyId], [GamingDate]) INCLUDE ([PatronId], [TypeName], [CashIn], [CashOut], [GrossAmount], [RS_CashWagerInNPM], [RS_BetBackWagerNPM], [RS_ChipWagerNPM], [RS_TicketPaidCashNPM], [RS_TicketPaidChipsNPM], [RS_CashWagerInS], [RS_BetBackWagerS], [RS_ChipWagerS], [RS_TicketPaidCashS], [RS_TicketPaidChipsS], [RS_OnlineWagerNPM], [RS_OnlineWagerS], [RS_OnlinePaidNPM])

CREATE INDEX [IX_T31_TrxAmount_TypeName_PropertyId_562B9] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([TypeName], [PropertyId]) INCLUDE ([CashIn], [TransKey])

CREATE INDEX [IX_T31_TrxAmount_GamingDate_57AE6] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([GamingDate]) INCLUDE ([PatronId], [PropertyId], [CashIn], [CashOut])

CREATE INDEX [IX_T31_TrxAmount_TypeName_PropertyId_CFB84] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([TypeName], [PropertyId]) INCLUDE ([TrxDate], [PatronId], [CashIn], [CashOut], [CtrNo], [ExpnSts], [GamingDate], [CTRCBatch], [CountryCode], [Amended], [TrxLocation], [OtherDescription], [UserDefinedText1], [ForeignCashOut], [ForeignCashIn])

CREATE INDEX [IX_T31_TrxAmount_PropertyId_GamingDate_9750C] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PropertyId],[GamingDate]) INCLUDE ([PatronId], [CashIn], [CashOut])

CREATE INDEX [IX_T31_TrxAmount_PropertyId_GamingDate_118AA] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PropertyId],[GamingDate]) INCLUDE ([TransSrc])

CREATE INDEX [IX_T31_TrxAmount_PropertyId_GamingDate_CE2B5] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PropertyId], [GamingDate]) INCLUDE ([TrxDate], [PatronId], [TypeName], [CashIn], [CashOut], [DateCTRMailed], [GrossAmount], [FederalWithholding], [StateWithholding], [CtrNo], [W2GNo], [TransSrc], [TransKey], [ExpnSts], [ExpnReas], [Comments], [IncompleteMTL], [InstrumentType], [InstrumentNumber], [InstrumentIssuer], [CTRCBatch], [CountryCode], [Amended], [InstrumentAcctNum], [InstrumentRoutingNum], [TrxLocation], [OtherDescription], [RS_CashWagerInNPM], [RS_CashWagerInPM], [RS_BetBackWagerNPM], [RS_BetBackWagerPM], [RS_ChipWagerNPM], [RS_ChipWagerPM], [RS_TicketPaidCashNPM], [RS_TicketPaidCashPM], [RS_TicketPaidChipsNPM], [RS_TicketPaidChipsPM], [RS_ChipsRedeemedNPM], [RS_ChipsRedeemedPM], [RS_WindowNumber], [RS_TicketNumber], [RS_HandlerApprover], [RS_ListedPatron], [InstrumentTotal], [InstrumentNonCash], [UserID], [EntryDate], [AmendmentReason], [UserDefinedText1], [UserDefinedMoney1], [Verified], [ForeignWithholding], [RS_CashWagerInS], [RS_BetBackWagerS], [RS_ChipWagerS], [RS_TicketPaidCashS], [RS_TicketPaidChipsS], [NonCashIn], [NonCashOut], [ForeignCashOut], [ForeignCashIn], [DocumentNumber], [NonCashType], [JXCREFERENCE], [JXCGenerated], [JXCCagePaid], [JXCMACHINE], [JXCAmount], [RS_OnlineWagerNPM], [RS_OnlineWagerPM], [RS_OnlineWagerS], [NILOverrideBy], [NILOverrideReason], [RS_OnlinePaidNPM], [RS_OnlinePaidPM], [id], [UserDefinedText2])

CREATE INDEX [IX_T31_TrxAmount_PropertyId_Amended_16E2D] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PropertyId], [Amended]) INCLUDE ([PatronId], [GamingDate])

CREATE INDEX [IX_T31_TrxAmount_TypeName_PropertyId_GamingDate_175D6] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([TypeName], [PropertyId],[GamingDate]) INCLUDE ([PatronId], [CashIn], [CashOut])

CREATE INDEX [IX_T31_TrxAmount_PropertyId_GamingDate_CE2BC] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PropertyId], [GamingDate]) INCLUDE ([TrxDate], [PatronId], [TypeName], [TransSrc], [Comments], [InstrumentType], [InstrumentNumber], [InstrumentIssuer], [InstrumentAcctNum], [InstrumentRoutingNum], [TrxLocation], [InstrumentTotal], [UserID])

CREATE INDEX [IX_T31_TrxAmount_PropertyId_GamingDate_79B6E] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PropertyId], [GamingDate]) INCLUDE ([TrxDate], [PatronId], [TypeName], [CashIn], [CashOut], [TransSrc], [Comments], [TrxLocation], [UserID], [UserDefinedText1], [UserDefinedMoney1])

CREATE INDEX [IX_T31_TrxAmount_PropertyId_GamingDate_3A3E4] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PropertyId], [GamingDate]) INCLUDE ([PatronId], [TypeName], [CashIn], [CashOut], [GrossAmount], [RS_CashWagerInNPM], [RS_BetBackWagerNPM], [RS_ChipWagerNPM], [RS_CashWagerInS], [RS_BetBackWagerS], [RS_ChipWagerS], [RS_OnlineWagerNPM], [RS_OnlineWagerS])

CREATE INDEX [IX_T31_TrxAmount_PatronId_PropertyId_GamingDate_431B1] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PatronId], [PropertyId],[GamingDate]) INCLUDE ([TrxDate], [TypeName], [CashIn], [CashOut], [DateCTRMailed], [GrossAmount], [FederalWithholding], [StateWithholding], [CtrNo], [W2GNo], [TransSrc], [TransKey], [ExpnSts], [ExpnReas], [Comments], [IncompleteMTL], [InstrumentType], [InstrumentNumber], [InstrumentIssuer], [CTRCBatch], [CountryCode], [Amended], [InstrumentAcctNum], [InstrumentRoutingNum], [TrxLocation], [OtherDescription], [RS_CashWagerInNPM], [RS_CashWagerInPM], [RS_BetBackWagerNPM], [RS_BetBackWagerPM], [RS_ChipWagerNPM], [RS_ChipWagerPM], [RS_TicketPaidCashNPM], [RS_TicketPaidCashPM], [RS_TicketPaidChipsNPM], [RS_TicketPaidChipsPM], [RS_WindowNumber], [RS_TicketNumber], [RS_HandlerApprover], [RS_ListedPatron], [InstrumentTotal], [InstrumentNonCash], [UserID], [EntryDate], [AmendmentReason], [UserDefinedText1], [UserDefinedMoney1], [Verified], [ForeignWithholding], [RS_CashWagerInS], [RS_BetBackWagerS], [RS_ChipWagerS], [RS_TicketPaidCashS], [RS_TicketPaidChipsS], [NonCashIn], [NonCashOut], [ForeignCashOut], [ForeignCashIn], [DocumentNumber], [NonCashType], [JXCREFERENCE], [JXCGenerated], [JXCCagePaid], [JXCMACHINE], [JXCAmount], [RS_OnlineWagerNPM], [RS_OnlineWagerPM], [RS_OnlineWagerS], [RS_OnlinePaidNPM], [RS_OnlinePaidPM], [UserDefinedText2])

CREATE INDEX [IX_T31_TrxAmount_PatronId_PropertyId_GamingDate_DB0B2] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PatronId], [PropertyId],[GamingDate]) INCLUDE ([TrxDate], [TypeName], [CashIn], [CashOut], [DateCTRMailed], [GrossAmount], [FederalWithholding], [StateWithholding], [CtrNo], [W2GNo], [TransSrc], [TransKey], [ExpnSts], [ExpnReas], [Comments], [IncompleteMTL], [InstrumentType], [InstrumentNumber], [InstrumentIssuer], [CTRCBatch], [CountryCode], [Amended], [InstrumentAcctNum], [InstrumentRoutingNum], [TrxLocation], [OtherDescription], [RS_CashWagerInNPM], [RS_CashWagerInPM], [RS_BetBackWagerNPM], [RS_BetBackWagerPM], [RS_ChipWagerNPM], [RS_ChipWagerPM], [RS_TicketPaidCashNPM], [RS_TicketPaidCashPM], [RS_TicketPaidChipsNPM], [RS_TicketPaidChipsPM], [RS_WindowNumber], [RS_TicketNumber], [RS_HandlerApprover], [RS_ListedPatron], [InstrumentTotal], [InstrumentNonCash], [UserID], [EntryDate], [AmendmentReason], [UserDefinedText1], [UserDefinedMoney1], [Verified], [ForeignWithholding], [RS_CashWagerInS], [RS_BetBackWagerS], [RS_ChipWagerS], [RS_TicketPaidCashS], [RS_TicketPaidChipsS], [NonCashIn], [NonCashOut], [ForeignCashOut], [ForeignCashIn], [DocumentNumber], [NonCashType], [JXCREFERENCE], [JXCGenerated], [JXCCagePaid], [JXCMACHINE], [JXCAmount], [RS_OnlineWagerNPM], [RS_OnlineWagerPM], [RS_OnlineWagerS], [RS_OnlinePaidNPM], [RS_OnlinePaidPM])

CREATE INDEX [IX_T31_TrxAmount_PatronId_GamingDate_2AE53] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PatronId], [GamingDate]) INCLUDE ([TrxDate], [TypeName], [PropertyId])

CREATE INDEX [IX_T31_TrxAmount_PatronId_TypeName_PropertyId_GamingDate_C7878] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PatronId], [TypeName], [PropertyId],[GamingDate]) INCLUDE ([TrxDate], [CashIn], [CashOut], [DateCTRMailed], [GrossAmount], [FederalWithholding], [StateWithholding], [CtrNo], [W2GNo], [TransSrc], [TransKey], [ExpnSts], [ExpnReas], [Comments], [IncompleteMTL], [InstrumentType], [InstrumentNumber], [InstrumentIssuer], [CTRCBatch], [CountryCode], [Amended], [InstrumentAcctNum], [InstrumentRoutingNum], [TrxLocation], [OtherDescription], [RS_CashWagerInNPM], [RS_CashWagerInPM], [RS_BetBackWagerNPM], [RS_BetBackWagerPM], [RS_ChipWagerNPM], [RS_ChipWagerPM], [RS_TicketPaidCashNPM], [RS_TicketPaidCashPM], [RS_TicketPaidChipsNPM], [RS_TicketPaidChipsPM], [RS_WindowNumber], [RS_TicketNumber], [RS_HandlerApprover], [RS_ListedPatron], [InstrumentTotal], [InstrumentNonCash], [UserID], [EntryDate], [AmendmentReason], [UserDefinedText1], [UserDefinedMoney1], [Verified], [ForeignWithholding], [RS_CashWagerInS], [RS_BetBackWagerS], [RS_ChipWagerS], [RS_TicketPaidCashS], [RS_TicketPaidChipsS], [NonCashIn], [NonCashOut], [ForeignCashOut], [ForeignCashIn], [DocumentNumber], [NonCashType], [JXCREFERENCE], [JXCGenerated], [JXCCagePaid], [JXCMACHINE], [JXCAmount], [RS_OnlineWagerNPM], [RS_OnlineWagerPM], [RS_OnlineWagerS], [RS_OnlinePaidNPM], [RS_OnlinePaidPM], [UserDefinedText2])

CREATE INDEX [IX_T31_TrxAmount_PropertyId_CtrNo_GamingDate_PatronId_C41EF] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PropertyId], [CtrNo], [GamingDate],[PatronId])

CREATE INDEX [IX_T31_TrxAmount_PropertyId_GamingDate_PatronId_CtrNo_D91C9] 
ON [EveriTitle31].[dbo].[T31_TrxAmount] ([PropertyId], [GamingDate],[PatronId], [CtrNo])

CREATE INDEX [IX_T31_TrxImages_PropertyId_5EBA3] 
ON [EveriTitle31].[dbo].[T31_TrxImages] ([PropertyId]) INCLUDE ([PatronId], [TypeName], [TrxDate])

CREATE INDEX [IX_T31_TrxImages_PropertyId_TypeName_8AC3B] 
ON [EveriTitle31].[dbo].[T31_TrxImages] ([PropertyId], [TypeName]) INCLUDE ([PatronId], [TrxDate])

CREATE INDEX [IX_T31_TrxImages_PatronId_PropertyId_ImageType_ImageDate_E6541] 
ON [EveriTitle31].[dbo].[T31_TrxImages] ([PatronId], [PropertyId], [ImageType], [ImageDate])

CREATE INDEX [IX_T31_TrxImages_PatronId_PropertyId_TypeName_BF5FF] 
ON [EveriTitle31].[dbo].[T31_TrxImages] ([PatronId], [PropertyId], [TypeName])

CREATE INDEX [IX_T31_TrxPatron_GamingDate_CMSId_82D26] 
ON [EveriTitle31].[dbo].[T31_TrxPatron] ([GamingDate], [CMSId])

CREATE INDEX [IX_T31_TrxPatron_GamingDate_59D86] 
ON [EveriTitle31].[dbo].[T31_TrxPatron] ([GamingDate]) INCLUDE ([PatronId], [PropertyId], [SSN], [IdCred], [CredType], [IssuedBy], [FirstName], [MiddleName], [LastName], [Address], [City], [State], [Zip], [Country], [BirthDate], [Telephone], [EmailAddr], [CustSrc], [ExpnSts], [ExpnReas], [CreatedDate], [ProcessedDate], [CMSId], [HairColor], [EyeColor], [Height], [Weight], [Sex], [Barred], [Banned], [IdCredentialExpiration], [Comments], [Age], [Race], [IssuedByCountry], [Organization], [DBA], [SSNVerified], [IDVerified], [SARStatus], [IncompleteCTRPosted], [Notes], [VerificationUser], [TinMatchResult], [DeathMasterResult], [OFACResult], [W9OnFile], [Occupation], [BannedReason], [BarredReason], [IDExamined], [KnownPatron], [W2GType], [PaymentPref], [Alerts], [VisaNumber], [VisaIssued], [VisaDate], [Address2], [City2], [State2], [Zip2], [Country2], [ForeignPatron], [PatronValidationFailed], [PromotionalYTD], [PatronServiceLevel], [Suffix], [NAICS], [Website], [ForeignPatronCountry])

CREATE INDEX [IX_T31_W2G_Trans_E6871] 
ON [EveriTitle31].[dbo].[T31_W2G] ([Trans])

CREATE INDEX [IX_T31_W2G_PropertyId_JackpotID_0F4E3] 
ON [EveriTitle31].[dbo].[T31_W2G] ([PropertyId], [JackpotID])

CREATE INDEX [IX_T31_W2G_PropertyId_JackpotID_AEDE6] 
ON [EveriTitle31].[dbo].[T31_W2G] ([PropertyId], [JackpotID]) INCLUDE ([PatronId], [W2GId], [ID], [W2GDate], [PayerName], [PayerStreetAddress], [PayerCityStateZip], [PayerFederalIdNumber], [PayerTelephoneNumber], [WinnerName], [WinnerFirstName], [WinnerMiddleName], [WinnerLastName], [WinnerStreetAddres], [WinnerCityStateZip], [WinnerCity], [WinnerState], [WinnerZip], [GrossWinnings], [FederalIncomeTaxWithheld], [TypeOfWager], [DateWon], [Trans], [Race], [WinningsFromIdenticalWagers], [Cashier], [WinnersTaxIdNumber], [Window], [FirstId], [SecondId], [StateOrPayersStateIdNumber], [StateIncomeTaxWithheld], [IsVoid], [IsCorrected], [SigImage], [StateWinnings], [LocalWinnings], [LocalIncomeTaxWithheld], [NameOfLocality], [SubmissionStatus], [SubmissionDate], [userid], [trxdate], [typename], [WagerCode], [AssetNumber], [LocationCode], [CashAmount], [CheckAmount], [ReelConfiguration], [Symbol], [Verified], [Uploaded], [isAggregate], [AggregateBatchID])

CREATE INDEX [IX_T31_W2G_PropertyId_PatronId_trxdate_typename_9AD75] 
ON [EveriTitle31].[dbo].[T31_W2G] ([PropertyId], [PatronId], [trxdate], [typename])

CREATE INDEX [IX_T31_W2G_PropertyId_PatronId_trxdate_typename_SubmissionStatus_B81BA] 
ON [EveriTitle31].[dbo].[T31_W2G] ([PropertyId], [PatronId], [trxdate], [typename],[SubmissionStatus])

CREATE INDEX [IX_T31_W2G_PropertyId_JackpotID_E6B3E] 
ON [EveriTitle31].[dbo].[T31_W2G] ([PropertyId], [JackpotID]) INCLUDE ([PatronId], [W2GId], [ID], [W2GDate], [PayerName], [PayerStreetAddress], [PayerCityStateZip], [PayerFederalIdNumber], [PayerTelephoneNumber], [WinnerName], [WinnerFirstName], [WinnerMiddleName], [WinnerLastName], [WinnerStreetAddres], [WinnerCityStateZip], [WinnerCity], [WinnerState], [WinnerZip], [GrossWinnings], [FederalIncomeTaxWithheld], [TypeOfWager], [DateWon], [Trans], [Race], [WinningsFromIdenticalWagers], [Cashier], [WinnersTaxIdNumber], [Window], [FirstId], [SecondId], [StateOrPayersStateIdNumber], [StateIncomeTaxWithheld], [IsVoid], [IsCorrected], [SigImage], [StateWinnings], [LocalWinnings], [LocalIncomeTaxWithheld], [NameOfLocality], [SubmissionStatus], [SubmissionDate], [userid], [trxdate], [typename], [WagerCode], [AssetNumber], [LocationCode], [CashAmount], [CheckAmount], [ReelConfiguration], [Symbol], [Verified], [Uploaded])

CREATE INDEX [IX_T31_W2G_IsVoid_0D9F6] 
ON [EveriTitle31].[dbo].[T31_W2G] ([IsVoid]) INCLUDE ([PropertyId], [PatronId], [W2GId], [ID], [JackpotID])

CREATE INDEX [IX_T31_W2G_DateWon_JackpotID_0327A] 
ON [EveriTitle31].[dbo].[T31_W2G] ([DateWon], [JackpotID])

CREATE INDEX [IX_T31_W9_PatronId_16F0B] 
ON [EveriTitle31].[dbo].[T31_W9] ([PatronId])

CREATE INDEX [IX_T31_Customer_PropertyId_IdCred_3A1E0] 
ON [EveriTitle31].[dbo].[T31_Customer] ([PropertyId], [IdCred])