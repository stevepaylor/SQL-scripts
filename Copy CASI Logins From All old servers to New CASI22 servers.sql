USE [master]
GO

--CREATE LOGIN [VIEJAS\bcamelo] FROM WINDOWS
--WITH DEFAULT_DATABASE=[master]
--, DEFAULT_LANGUAGE=[us_english]
--GO
EXEC sys.sp_addsrvrolemember 
@loginame = N'VIEJAS\bcamelo'
, @rolename = N'sysadmin'
GO


-----------------------------------------------------------------------------------------------------------

-- APPSWB01PR - VIEJAS\APPSWB01PR$                                                                                                              
CREATE LOGIN [VIEJAS\APPSWB01PR$] FROM WINDOWS 
WITH DEFAULT_DATABASE=[COMMON_SECURITY]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

-- APPSWB02PR -	VIEJAS\APPSWB02PR$                                                                          
CREATE LOGIN [VIEJAS\APPSWB02PR$] FROM WINDOWS 
WITH DEFAULT_DATABASE=[COMMON_SECURITY]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

-- APPSWB21APR - VIEJAS\APPSWB21APR$                                                           
CREATE LOGIN [VIEJAS\APPSWB21APR$] FROM WINDOWS 
WITH DEFAULT_DATABASE=[COMMON_SECURITY]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

-- APPSWB21BPR - VIEJAS\APPSWB21BPR$                                                                    
CREATE LOGIN [VIEJAS\APPSWB21BPR$] FROM WINDOWS
WITH DEFAULT_DATABASE=[COMMON_SECURITY]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

--BCCSWB13PR - VIEJAS\sdsgw
CREATE LOGIN [VIEJAS\sdsgw] FROM WINDOWS 
WITH DEFAULT_DATABASE=[SLOT_SERVICE]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

--BCCSWB13PR - vService
CREATE LOGIN [vService] 
WITH PASSWORD = 0x01009906D921F25D3BB1CD0242966B4CD4846B7920167A3DCCAE HASHED
, SID = 0x60E444ABD56C5846869D598657BDB7D0
, DEFAULT_DATABASE = [SLOT_SERVICE]
, CHECK_POLICY = OFF
, CHECK_EXPIRATION = OFF
 
GO

-----------------------------------------------------------------------------------------------------------

--BLFVDB01PR - SlotPortal
CREATE LOGIN [SlotPortal] 
WITH PASSWORD = 0x010056C4812797FE551A25BBE05F8182E2C64B522EF031246F7D HASHED
, SID = 0x5E68C3C4DFDC2E459D05506A274AEA4A
, DEFAULT_DATABASE = [SLOT_PARTICIPATION]
, CHECK_POLICY = OFF
, CHECK_EXPIRATION = OFF
 
GO

-----------------------------------------------------------------------------------------------------------

--CASIDB01PR - cage_inventory_user
CREATE LOGIN [cage_inventory_user] 
WITH PASSWORD = 0x0100BF0EE90A297E90FFE09DDAA88C969D47005538B5FF123091 HASHED
, SID = 0x7A2450CB98B2F8429EDF2E0C2294F2B7
, DEFAULT_DATABASE = [CASH_VARIANCE]
, CHECK_POLICY = OFF
, CHECK_EXPIRATION = OFF
 
GO

-----------------------------------------------------------------------------------------------------------

--CASIDB02PR - RainMaker
CREATE LOGIN [RainMaker] 
WITH PASSWORD = 0x0100A3139B97D232146D6B2427590AF950652C59CBBA2A5F5F5A HASHED
, SID = 0x12CE476EB334F24485D6680619813F0F
, DEFAULT_DATABASE = [SLOT_PARTICIPATION]
, CHECK_POLICY = ON
, CHECK_EXPIRATION = OFF
 
GO

-----------------------------------------------------------------------------------------------------------

----CASIDB10PR - NT AUTHORITY\SYSTEM
--CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS 
--WITH DEFAULT_DATABASE=[master]
--, DEFAULT_LANGUAGE=[us_english]
--GO

-----------------------------------------------------------------------------------------------------------

--CASIDB10PR - VIEJAS\bgriffin
CREATE LOGIN [VIEJAS\bgriffin] FROM WINDOWS 
WITH DEFAULT_DATABASE=[SLOT_SERVICE]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

--CASIDB21APR - CS_sync
CREATE LOGIN [CS_sync] 
WITH PASSWORD = 0x010030794C0B01C67E009D1C3BDA9B1312F39B06A9A4CBB37CE1 HASHED
, SID = 0x1D62D2ACE9D24B4281059291336A1223
, DEFAULT_DATABASE = [COMMON_SECURITY]
, CHECK_POLICY = ON
, CHECK_EXPIRATION = OFF
GO

-----------------------------------------------------------------------------------------------------------

--CMKTDB01PR - lnkd_cmkt
CREATE LOGIN [lnkd_cmkt] 
WITH PASSWORD = 0x0100B06B42DC003C73267B0FE11B2088E9D05B86F82D8657EEFF HASHED
, SID = 0x7FD439BE71F2BD4AA11432CD909AB98D
, DEFAULT_DATABASE = [master]
, CHECK_POLICY = ON
, CHECK_EXPIRATION = OFF
GO
EXEC sys.sp_addsrvrolemember 
@loginame = N'lnkd_cmkt'
, @rolename = N'sysadmin'
GO

-----------------------------------------------------------------------------------------------------------

--CMKTDB13APR - CMP13_reader
CREATE LOGIN [CMP13_reader] 
WITH PASSWORD = 0x01004146B5B98214FC0B60D77199D992DD7C92AEB00858467FBF HASHED
, SID = 0xE83A7756CC287B4AAA984DDFD7ED8C5C
, DEFAULT_DATABASE = [master]
, CHECK_POLICY = ON
, CHECK_EXPIRATION = OFF
 GO

-----------------------------------------------------------------------------------------------------------

--CRPTDB01PR - VIEJAS\cmkt
CREATE LOGIN [VIEJAS\cmkt] FROM WINDOWS 
WITH DEFAULT_DATABASE=[JUNKET_REPORTING]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

--ICBAP01PR - ICBWebReports
CREATE LOGIN [ICBWebReports] 
WITH PASSWORD = 0x01002AE1263D998047FDCD74716BC592E6F3C516E7F215B10576 HASHED
, SID = 0xD1053552D304E643931F5404520E7754
, DEFAULT_DATABASE = [ICBWebReportsII]
, CHECK_POLICY = OFF
, CHECK_EXPIRATION = OFF
 GO

-----------------------------------------------------------------------------------------------------------

--LWSNVC04PR - VIEJAS\SQuagmire
CREATE LOGIN [VIEJAS\SQuagmire] FROM WINDOWS 
WITH DEFAULT_DATABASE=[COMMON_SECURITY]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

--MKT004SW - VIEJAS\ewallace
CREATE LOGIN [VIEJAS\ewallace] FROM WINDOWS 
WITH DEFAULT_DATABASE=[SLOT_SERVICE]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

--MKT013SW - VIEJAS\sbauer
CREATE LOGIN [VIEJAS\sbauer] FROM WINDOWS 
WITH DEFAULT_DATABASE=[SLOT_PARTICIPATION]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

--PAGEAP01PR - VIEJAS\HPlayer
CREATE LOGIN [VIEJAS\HPlayer] FROM WINDOWS 
WITH DEFAULT_DATABASE=[SLOT_SERVICE]
, DEFAULT_LANGUAGE=[us_english]
GO

-----------------------------------------------------------------------------------------------------------

--SSISDB21PR - dashboardUser2
CREATE LOGIN [dashboardUser2] 
WITH PASSWORD = 0x010034B6412071540EDFABC7F26759A78C96E416EC2EB0372397 HASHED
, SID = 0xF9897F2C0EDAE947BB94AD2A0C51A1BD
, DEFAULT_DATABASE = [master]
, CHECK_POLICY = OFF
, CHECK_EXPIRATION = OFF
 
GO

-----------------------------------------------------------------------------------------------------------

--SSISDB21PR - JunketUser
CREATE LOGIN [JunketUser] 
WITH PASSWORD = 0x0100528C0B94D19C1CF3801F28730AD61035A8253B07A6AED83E HASHED
, SID = 0xBFB5DA37C95A9F448B6987EB98606CDA
, DEFAULT_DATABASE = [SLOT_PARTICIPATION]
, CHECK_POLICY = OFF
, CHECK_EXPIRATION = OFF
 
GO

-----------------------------------------------------------------------------------------------------------

--VIEJAS\pparker
CREATE LOGIN [VIEJAS\pparker] FROM WINDOWS 
WITH DEFAULT_DATABASE=[master]
, DEFAULT_LANGUAGE=[us_english]
GO
EXEC sys.sp_addsrvrolemember 
@loginame = N'VIEJAS\pparker'
, @rolename = N'sysadmin'
GO

-----------------------------------------------------------------------------------------------------------

-- Login: VIEJAS\ICB_Accounting_Roles
CREATE LOGIN [VIEJAS\ICB_Accounting_Roles] FROM WINDOWS 
WITH DEFAULT_DATABASE = [ICBWebReportsII]
, DEFAULT_LANGUAGE=[us_english] 
--GO

-----------------------------------------------------------------------------------------------------------

-- Login: VIEJAS\ICB_Admin_Roles
CREATE LOGIN [VIEJAS\ICB_Admin_Roles] FROM WINDOWS 
WITH DEFAULT_DATABASE = [ICBWebReportsII]
, DEFAULT_LANGUAGE=[us_english]  
GO

-----------------------------------------------------------------------------------------------------------

-- Login: VIEJAS\ICB_Slots_Roles
CREATE LOGIN [VIEJAS\ICB_Slots_Roles] FROM WINDOWS 
WITH DEFAULT_DATABASE = [ICBWebReportsII]
, DEFAULT_LANGUAGE=[us_english]   
GO

-----------------------------------------------------------------------------------------------------------

-- Login: VIEJAS\outsource_Developers
CREATE LOGIN [VIEJAS\outsource_Developers] FROM WINDOWS 
WITH DEFAULT_DATABASE = [TITLE31]
, DEFAULT_LANGUAGE=[us_english]    
GO