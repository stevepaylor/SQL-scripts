-- Login: IIS APPPOOL\GpAccessControlServiceAppPool
CREATE LOGIN [IIS APPPOOL\GpAccessControlServiceAppPool] FROM WINDOWS WITH DEFAULT_DATABASE = [master]
 
-- Login: IIS APPPOOL\GpClientServiceAppPool
CREATE LOGIN [IIS APPPOOL\GpClientServiceAppPool] FROM WINDOWS WITH DEFAULT_DATABASE = [master]
 
-- Login: IIS APPPOOL\GpReportingServiceAppPool
CREATE LOGIN [IIS APPPOOL\GpReportingServiceAppPool] FROM WINDOWS WITH DEFAULT_DATABASE = [master]
 
-- Login: IIS APPPOOL\GpPortalServiceAppPool
CREATE LOGIN [IIS APPPOOL\GpPortalServiceAppPool] FROM WINDOWS WITH DEFAULT_DATABASE = [master]
 