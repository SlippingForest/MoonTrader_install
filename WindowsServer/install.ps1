# Список изменений которые будут добавлены в реестр
$list_regCreate =
@("HideSCAHealth DWORD - Hide Action Center Icon.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v HideSCAHealth /t REG_DWORD /d 0x1 /f"), #Confirmed that this does hide the Action Center in 2012 R2.
("NoRemoteRecursiveEvents DWORD - Turn off change notify events for file and folder changes.", "'HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v NoRemoteRecursiveEvents /t REG_DWORD /d 0x1 /f"),
("SendAlert DWORD - Do not send Administrative alert during system crash.", "'HKLM\SYSTEM\CurrentControlSet\Control\CrashControl' /v SendAlert /t REG_DWORD /d 0x0 /f"),
("ServicesPipeTimeout DWORD - Increase services startup timeout from 30 to 45 seconds.", "'HKLM\SYSTEM\CurrentControlSet\Control' /v ServicesPipeTimeout /t REG_DWORD /d 0xafc8 /f"),
("DisableFirstRunCustomize DWORD - Disable Internet Explorer first-run customise wizard.", "'HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Main' /v DisableFirstRunCustomize /t REG_DWORD /d 0x1 /f"),
("AllowTelemetry DWORD - Disable telemetry.", "'HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection' /v AllowTelemetry /t REG_DWORD /d 0x0 /f"),
("Enabled DWORD - Disable offline files.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NetCache' /v Enabled /t REG_DWORD /d 0x0 /f"),
("Enable REG_SZ - Disable Defrag.", "'HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction' /v Enable /t REG_SZ /d N /f"),
("NoAutoUpdate DWORD - Disable Windows Autoupdate.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update' /v NoAutoUpdate /t REG_DWORD /d 0x1 /f"),
("AUOptions DWORD - Disable Windows Autoupdate.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update' /v AUOptions /t REG_DWORD /d 0x1 /f"),
("ScheduleInstallDay DWORD - Disable Windows Autoupdate.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update' /v ScheduleInstallDay /t REG_DWORD /d 0x0 /f"),
("ScheduleInstallTime DWORD - Disable Windows Autoupdate.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update' /v ScheduleInstallTime /t REG_DWORD /d 0x3 /f"),
("EnableAutoLayout DWORD - Disable Background Layout Service.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OptimalLayout' /v EnableAutoLayout /t REG_DWORD /d 0x0 /f"),
("DumpFileSize DWORD - Reduce DedicatedDumpFile DumpFileSize to 2 MB.", "'HKLM\SYSTEM\CurrentControlSet\Control\CrashControl' /v DumpFileSize /t REG_DWORD /d 0x2 /f"),
("IgnorePagefileSize DWORD - Reduce DedicatedDumpFile DumpFileSize to 2 MB.", "'HKLM\SYSTEM\CurrentControlSet\Control\CrashControl' /v IgnorePagefileSize /t REG_DWORD /d 0x1 /f"),
("DisableLogonBackgroundImage DWORD - Disable Logon Background Image.", "'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v DisableLogonBackgroundImage /t REG_DWORD /d 0x1 /f")

# Список изменений которые будут удалены из реестра
$list_regDelete =
@("StubPath - Themes Setup.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{2C7339CF-2B09-4501-B3F3-F3508C9228ED}' /v StubPath /f"),
("StubPath - WinMail.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{44BBA840-CC51-11CF-AAFA-00AA00B6015C}' /v StubPath /f"),
("StubPath x64 - WinMail.", "'HKLM\SOFTWARE\WOW6432Node\Microsoft\Active Setup\Installed Components\{44BBA840-CC51-11CF-AAFA-00AA00B6015C}' /v StubPath /f"),
("StubPath - Windows Media Player.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{6BF52A52-394A-11d3-B153-00C04F79FAA6}' /v StubPath /f"),
("StubPath x64 - Windows Media Player.", "'HKLM\SOFTWARE\WOW6432Node\Microsoft\Active Setup\Installed Components\{6BF52A52-394A-11d3-B153-00C04F79FAA6}' /v StubPath /f"),
("StubPath - Windows Desktop Update.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{89820200-ECBD-11cf-8B85-00AA005B4340}' /v StubPath /f"),
("StubPath - Web Platform Customizations.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{89820200-ECBD-11cf-8B85-00AA005B4383}' /v StubPath /f"),
("StubPath - DotNetFrameworks.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{89B4C1CD-B018-4511-B0A1-5476DBF70820}' /v StubPath /f"),
("StubPath x64 - DotNetFrameworks.", "'HKLM\SOFTWARE\WOW6432Node\Microsoft\Active Setup\Installed Components\{89B4C1CD-B018-4511-B0A1-5476DBF70820}' /v StubPath /f"),
("StubPath - Windows Media Player.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\>{22d6f312-b0f6-11d0-94ab-0080c74c7e95}' /v StubPath /f"),
("StubPath x64 - Windows Media Player.", "'HKLM\SOFTWARE\WOW6432Node\Microsoft\Active Setup\Installed Components\>{22d6f312-b0f6-11d0-94ab-0080c74c7e95}' /v StubPath /f"),
("StubPath - IE ESC for Admins.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}' /v StubPath /f"),
("StubPath - IE ESC for Users.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}' /v StubPath /f")

# Получить имя службы сирхронизации пользовательских данных(почта, контакты и тд) для дальнейшего отключения
$SyncService = Get-Service -Name OneSync* | Select-Object -ExpandProperty Name
# Список изменений которые будут исправлены в реестре
$list_regModify = 
@("DisablePagingExecutive DWORD from 0x0 to 0x1 - Keep drivers and kernel on physical memory.", "'HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management' /v DisablePagingExecutive /t REG_DWORD /d 0x1 /f"),
("EventLog DWORD from 0x3 to 0x1 - Log print job error notifications in Event Viewer.", "'HKLM\SYSTEM\CurrentControlSet\Control\Print\Providers' /v EventLog /t REG_DWORD /d 0x1 /f"),
("MaxSize DWORD from 0x01400000 to 0x00010000 - Reduce Application Event Log size to 64KB", "'HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application' /v MaxSize /t REG_DWORD /d 0x10000 /f"),
("MaxSize DWORD from 0x0140000 to 0x00010000 - Reduce Security Event Log size to 64KB.", "'HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Security' /v MaxSize /t REG_DWORD /d 0x10000 /f"),
("MaxSize DWORD from 0x0140000 to 0x00010000 - Reduce System Event Log size to 64KB.", "'HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\System' /v MaxSize /t REG_DWORD /d 0x10000 /f"),
("ClearPageFileAtShutdown DWORD to 0x0 - Disable clear Page File at shutdown.", "'HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' /v ClearPageFileAtShutdown /t REG_DWORD /d 0x0 /f"),
("Creating Paths DWORD - Reduce IE Temp File.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Paths' /v Paths /t REG_DWORD /d 0x4 /f"),
("Creating CacheLimit DWORD - Reduce IE Temp File.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Paths\path1' /v CacheLimit /t REG_DWORD /d 0x100 /f"),
("Creating CacheLimit DWORD - Reduce IE Temp File.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Paths\path2' /v CacheLimit /t REG_DWORD /d 0x100 /f"),
("Creating CacheLimit DWORD - Reduce IE Temp File.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Paths\path3' /v CacheLimit /t REG_DWORD /d 0x100 /f"),
("Creating CacheLimit DWORD - Reduce IE Temp File.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Paths\path4' /v CacheLimit /t REG_DWORD /d 0x100 /f"),
("DisablePasswordChange DWORD from 0x0 to 0x1 - Disable Machine Account Password Changes.", "'HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters' /v DisablePasswordChange /t REG_DWORD /d 0x1 /f"),
("PreferredPlan REG_SZ from 381b4222-f694-41f0-9685-ff5bb260df2e to 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c - Changing Power Plan to High Performance.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{025A5937-A6BE-4686-A844-36FE4BEC8B6D}' /v PreferredPlan /t REG_SZ /d 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c /f"),
("TimeoutValue DWORD from 0x41 to 0xC8 - Increase Disk I/O Timeout to 200 seconds.", "'HKLM\SYSTEM\CurrentControlSet\Services\Disk' /v TimeoutValue /t REG_DWORD /d 0xC8 /f"),
("Start DWORD from 0x2 to 0x4 - Disable the Sync Host Service.", "'HKLM\SYSTEM\CurrentControlSet\Services\$SyncService' /v Start /t REG_DWORD /d 0x4 /f")

# Службы которые будут отключены
$list_servicesDisable = 
@("AJRouter - AllJoyn Router Service.", "AJRouter"),
("ALG - Application Layer Gateway Service.", "ALG"),
("AppMgmt - Application Management.", "AppMgmt"),
("BITS - Background Intelligent Transfer Service.", "BITS"),
("bthserv - Bluetooth Support Service.", "bthserv"),
("DcpSvc - DataCollectionPublishingService.", "DcpSvc"),
("DPS - Diagnostic Policy Service.", "DPS"),
("WdiServiceHost - Diagnostic Service Host.", "WdiServiceHost"),
("WdiSystemHost - Diagnostic System Host.", "WdiSystemHost"),
("DiagTrack - Connected User Experiences and Telemetry [Diagnostics Tracking Service].", "DiagTrack"),
("dmwappushservice - dmwappushsvc.", "dmwappushservice"),
("MapsBroker - Downloaded Maps Manager.", "MapsBroker"),
("EFS - Encrypting File System [EFS].", "EFS"),
("Eaphost - Extensible Authentication Protocol.", "Eaphost"),
("FDResPub - Function Discovery Resource Publication.", "FDResPub"),
("lfsvc - Geolocation Service.", "lfsvc"),
("UI0Detect - Interactive Services Detection.", "UI0Detect"),
("SharedAccess - Internet Connection Sharing [ICS].", "SharedAccess"),
("iphlpsvc - IP Helper.", "iphlpsvc"),
("lltdsvc - Link-Layer Topology Discovery Mapper.", "lltdsvc"),
("diagnosticshub.standardcollector.service - Microsoft [R] Diagnostics Hub Standard Collector Service.", "diagnosticshub.standardcollector.service"),
("wlidsvc - Microsoft Account Sign-in Assistant.", "wlidsvc"),
("MSiSCSI - Microsoft iSCSI Initiator Service.", "MSiSCSI"),
("smphost - Microsoft Storage Spaces SMP.", "smphost"),
("NcbService - Network Connection Broker.", "NcbService"),
("NcaSvc - Network Connectivity Assistant.", "NcaSvc"),
("defragsvc - Optimize drives.", "defragsvc"),
("wercplsupport - Problem Reports and Solutions Control Panel.", "wercplsupport"),
("PcaSvc - Program Compatibility Assistant Service.", "PcaSvc"),
("QWAVE - Quality Windows Audio Video Experience.", "QWAVE"),
("RmSvc - Radio Management Service.", "RmSvc"),
("RasMan - Remote Access Connection Manager.", "RasMan"),
("SstpSvc - Secure Socket Tunneling Protocol Service.", "SstpSvc"),
("SensorDataService - Sensor Data Service.", "SensorDataService"),
("SensrSvc - Sensor Monitoring Service.", "SensrSvc"),
("SensorService - Sensor Service.", "SensorService"),
("SNMPTRAP - SNMP Trap.", "SNMPTRAP"),
("sacsvr - Special Administration Console Helper.", "sacsvr"),
("svsvc - Spot Verifier.", "svsvc"),
("SSDPSRV - SSDP Discovery.", "SSDPSRV"),
("TieringEngineService - Storage Tiers Management.", "TieringEngineService"),
("SysMain - Superfetch.", "SysMain"),
("TapiSrv - Telephony.", "TapiSrv"),
("UALSVC - User Access Logging Service.", "UALSVC"),
("Wcmsvc - Windows Connection Manager.", "Wcmsvc"),
("WerSvc - Windows Error Reporting Service.", "WerSvc"),
("wisvc - Windows Insider Service.", "wisvc"),
("icssvc - Windows Mobile Hotspot Service.", "icssvc"),
("wuauserv - Windows Update.", "wuauserv"),
("dot3svc - Wired AutoConfig.", "dot3svc"),
("XblAuthManager - Xbox Live Auth Manager.", "XblAuthManager"),
("XblGameSave - Xbox Live Game Save.", "XblGameSave"),
("swprv - Microsoft Software Shadow Copy Provider", "swprv"),
("VSS - Volume Shadow Copy", "VSS"),
("HvHost - HV Host Service.", "HvHost"),
("vmickvpexchange - Hyper-V Data Exchange Service.", "vmickvpexchange"),
("vmicguestinterface - Hyper-V Guest Service Interface.", "vmicguestinterface"),
("vmicshutdown - Hyper-V Guest Shutdown Interface.", "vmicshutdown"),
("vmicheartbeat - Hyper-V Heartbeat Service.", "vmicheartbeat"),
("vmicvmsession - Hyper-V PowerShell Direct Service.", "vmicvmsession"),
("vmicrdv - Hyper-V Remote Desktop Virtualization Service.", "vmicrdv"),
("vmictimesync - Hyper-V Time Synchronization Service.", "vmictimesync"),
("vmicvss - Hyper-V Volume Shadow Copy Requestor.", "vmicvss")

#Спикок заданий в планировщике задач, которые будут отключены
$list_schduleDisable = 
@("'AD RMS Rights Policy Template Management (Manual)'", "'\Microsoft\Windows\Active Directory Rights Management Services Client'"),
("'EDP Policy Manager'", "'\Microsoft\Windows\AppID'"),
("SmartScreenSpecific", "'\Microsoft\Windows\AppID'"),
("'Microsoft Compatibility Appraiser'", "'\Microsoft\Windows\Application Experience'"),
("ProgramDataUpdater", "'\Microsoft\Windows\Application Experience'"),
("StartupAppTask", "'\Microsoft\Windows\Application Experience'"),
("CleanupTemporaryState", "\Microsoft\Windows\ApplicationData"),
("DsSvcCleanup", "\Microsoft\Windows\ApplicationData"),
("Proxy", "'\Microsoft\Windows\Autochk'"),
("UninstallDeviceTask", "\Microsoft\Windows\Bluetooth"),
("AikCertEnrollTask", "\Microsoft\Windows\CertificateServicesClient"),
("CryptoPolicyTask", "\Microsoft\Windows\CertificateServicesClient"),
("KeyPreGenTask", "\Microsoft\Windows\CertificateServicesClient"),
("ProactiveScan", "\Microsoft\Windows\Chkdsk"),
("CreateObjectTask", "\Microsoft\Windows\CloudExperienceHost"),
("Consolidator", "'\Microsoft\Windows\Customer Experience Improvement Program'"),
("KernelCeipTask", "'\Microsoft\Windows\Customer Experience Improvement Program'"),
("UsbCeip", "'\Microsoft\Windows\Customer Experience Improvement Program'"),
("'Data Integrity Scan'", "'\Microsoft\Windows\Data Integrity Scan'"),
("'Data Integrity Scan for Crash Recovery'", "'\Microsoft\Windows\Data Integrity Scan'"),
("ScheduledDefrag", "\Microsoft\Windows\Defrag"),
("Device", "'\Microsoft\Windows\Device Information'"),
("Scheduled", "\Microsoft\Windows\Diagnosis"),
("SilentCleanup", "\Microsoft\Windows\DiskCleanup"),
("Microsoft-Windows-DiskDiagnosticDataCollector", "\Microsoft\Windows\DiskDiagnostic"),
("Notifications", "\Microsoft\Windows\Location"),
("WindowsActionDialog", "\Microsoft\Windows\Location"),
("WinSAT", "\Microsoft\Windows\Maintenance"),
("MapsToastTask", "\Microsoft\Windows\Maps"),
("'MNO Metadata Parser'", "'\Microsoft\Windows\Mobile Broadband Accounts'"),
("LPRemove", "\Microsoft\Windows\MUI"),
("GatherNetworkInfo", "\Microsoft\Windows\NetTrace"),
("Secure-Boot-Update", "\Microsoft\Windows\PI"),
("Sqm-Tasks", "\Microsoft\Windows\PI"),
("AnalyzeSystem", "'\Microsoft\Windows\Power Efficiency Diagnostics'"),
("MobilityManager", "\Microsoft\Windows\Ras"),
("VerifyWinRE", "\Microsoft\Windows\RecoveryEnvironment"),
("RegIdleBackup", "\Microsoft\Windows\Registry"),
("CleanupOldPerfLogs", "'\Microsoft\Windows\Server Manager'"),
("StartComponentCleanup", "\Microsoft\Windows\Servicing"),
("IndexerAutomaticMaintenance", "\Microsoft\Windows\Shell"),
("Configuration", "'\Microsoft\Windows\Software Inventory Logging'"),
("SpaceAgentTask", "\Microsoft\Windows\SpacePort"),
("SpaceManagerTask", "\Microsoft\Windows\SpacePort"),
("SpeechModelDownloadTask", "\Microsoft\Windows\Speech"),
("'Storage Tiers Management Initialization'", "'\Microsoft\Windows\Storage Tiers Management'"),
("Tpm-HASCertRetr", "\Microsoft\Windows\TPM"),
("Tpm-Maintenance", "'\Microsoft\Windows\TPM'"),
("ResolutionHost", "\Microsoft\Windows\WDI"),
("QueueReporting", "'\Microsoft\Windows\Windows Error Reporting'"),
("BfeOnServiceStartTypeChange", "'\Microsoft\Windows\Windows Filtering Platform'"),
("'Automatic App Update'", "\Microsoft\Windows\WindowsUpdate"),
("'Scheduled Start'", "\Microsoft\Windows\WindowsUpdate"),
("sih", "\Microsoft\Windows\WindowsUpdate"),
("sihboot", "\Microsoft\Windows\WindowsUpdate"),
("XblGameSaveTask", "\Microsoft\XblGameSave"),
("XblGameSaveTaskLogon", "\Microsoft\XblGameSave")

# Функция установки IPBan
function func_install_IPBan {
    Write-Host Install IpBan -ForegroundColor Cyan
    if (-Not (Test-Path -Path "C:\Program Files\IpBan\DigitalRuby.IPBan.exe" -PathType Leaf)) {
        if (-Not (Test-Path IpBan.zip -PathType Leaf)) {
            Write-Host Download IpBan -ForegroundColor Cyan
            Invoke-WebRequest -O IpBan.zip "https://github.com/DigitalRuby/IPBan/releases/download/1.6.1/IPBan-Windows-x64_1_6_1.zip"
        }
        if (Test-Path IpBan.zip -PathType Leaf) {
            Expand-Archive -Path IpBan.zip "C:\Program Files\IpBan"
            Remove-Item .\IpBan.zip
        }
    }

    $service = Get-Service -Name IpBan -ErrorAction SilentlyContinue
    if ($service.Length -gt 0) {
        Write-Host Service IpBan already registered -ForegroundColor Cyan
    }
    else {
        Write-Host Regigtration Service IpBan -ForegroundColor Cyan
        New-Service -Name "IpBan" -BinaryPathName '"C:\Program Files\IpBan\DigitalRuby.IPBan.exe"' | Out-Null
        start-service IpBan | Out-Null
        Get-CimInstance -ClassName Win32_Service -Filter "Name='IpBan'"
        Write-Host Install IpBan Complete -ForegroundColor Cyan
    }
}

# Установка использования протокола шифрования HTTPS - TLS 1.2 по умолчанию
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Установка обновлений Windows
# Write-Host Install Windows Updates -ForegroundColor Cyan
# Get-PackageProvider -name nuget -force | Out-Null
# Install-Module PSWindowsUpdate -confirm:$false -force | Out-Null
# Get-WindowsUpdate -Install -acceptall -IgnoreReboot | Out-Null

# Добавление записей в реестр на основе ранее созданного списка
Write-Host ADD registry list -ForegroundColor Green
foreach ($reg_object in $list_regCreate) {
    Write-Host Creating registry object $reg_object[0] -ForegroundColor Cyan
    Invoke-Expression ("reg add " + $reg_object[1])  2>&1
}

# Удаление записей в реестре на основе ранее созданного списка
Write-Host DELETE registry list -ForegroundColor Green
foreach ($reg_object in $list_regDelete) {
    Write-Host Deleting registry object $reg_object[0] -Foregroundcolor Cyan
    Invoke-Expression ("reg delete " + $reg_object[1])  2>&1
}

# Изменение записей в реестре на основе ранее созданного списка
Write-Host MODIFY registry list -ForegroundColor Green
foreach ($reg_object in $list_regModify) {
    Write-Host Modifying $reg_object[0] -ForegroundColor Cyan
    Invoke-Expression ("reg add " + $reg_object[1])  2>&1
}

# Отключение ненужных служб для снижения нагрузки сервера на основе ранее созданного списка
Write-Host DISABLE services for improving performance. -ForegroundColor Green
foreach ($service_object in $list_servicesDisable) {
    Write-Host Service $service_object[0] disabled -ForegroundColor Cyan
    Invoke-Expression ("Set-Service " + $service_object[1] + " -StartupType Disabled")  2>&1
        
}

Write-Host The following section contains commands that disable scheduled tasks. These optimisations are aimed at reducing system footprint and improving performance. -ForegroundColor Green

# Disabling Scheduled Tasks
foreach ($ScheduledTaskObject in $list_schduleDisable) {
    Write-Host Disabling scheduled task $ScheduledTaskObject[0] -ForegroundColor Cyan
    Invoke-Expression ("Disable-ScheduledTask -TaskName " + $ScheduledTaskObject[0] + ' -TaskPath ' + $ScheduledTaskObject[1])  2>&1
}

# Removing Windows Defender which also removes Scheduled Tasks and services related to Windows Defender
Write-Host Removing Windows Defender. -ForegroundColor Cyan
Uninstall-WindowsFeature -Name Windows-Defender

# Allow MTcore ports
Write-Host FireWall Allow inbound ICMPv4. -ForegroundColor Cyan
New-NetFirewallRule -DisplayName "Allow inbound ICMPv4" -Direction Inbound -Protocol ICMPv4 -IcmpType 8  -Action Allow | Out-Null
Write-Host FireWall Allow inbound UDP 4242 for MoonTrader Core. -ForegroundColor Cyan
New-NetFirewallRule -DisplayName "Allow inbound UDP 4242 for MoonTrader Core" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol UDP -LocalPort 4242 | Out-Null

# Disable IPv6
Write-Host Disable IPv6. -ForegroundColor Cyan
Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6 | Out-Null

# Install IP_BAN
func_install_IPBan

Write-Host "All optimisations and installations are complete. Please restart your system." -ForegroundColor Green

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');