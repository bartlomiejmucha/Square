## TODO: add host for solr to etc\hosts file
## TODO: relative path for custom SIF modules

#tools
$keytoolDirectoryPath = "C:\Program Files\Java\jdk1.8.0_144\bin"
$nssmDirectoryPath = "C:\Program Files\nssm\win64"

#solrParams
$prefix = "square"
$installScriptsPath = "C:\GitHub\Square\scripts"
$installRootPath = "C:\Websites\Square"

#database
$sqlServer = "."
$sqlAdminUser = "user"
$sqlAdminPassword="pass"

#source
$configurationFilesPath = "$installScriptsPath\configuration files"
$modulesPath = "$installScriptsPath\modules"
$zipsPath = "$installScriptsPath\zips"
$solrZipPath = "$zipsPath\solr-6.6.2.zip"
$xconnectWDPZipPath = "$zipsPath\Sitecore 9.0.0 rev. 171002 (OnPrem)_xp0xconnect.scwdp.zip"
$sitecoreWDPZipPath = "$zipsPath\Sitecore 9.0.0 rev. 171002 (OnPrem)_single.scwdp.zip"
$licenseFilePath = "$installScriptsPath\license.xml"

#destination
$certificatesInstallPath = "$installRootPath\certificates"
$solrInstallRoot = "$installRootPath\solr"
$xconnectInstallRootPath = "$installRootPath\xconnect"
$sitecoreInstallRootPath = "$installRootPath\sitecore"

#hosts
$hostName = "$prefix.sc"
$solrHostName = "$prefix.solr"
$xconnectHostName = "$prefix.xconnect"

#certificates
$rootCertificateName = "$prefix.sitecore_root"
$xconnectClientCertificateName = "$prefix.xconnect_client"
$xconnectHostCertificateName = "$prefix.xconnect"
$sitecoreCertificateName = "$prefix.sc"
$solrCertificateName = "$prefix.solr"
$solrCertificatePassword = "secret"
$solrCertificateDNS = "$solrHostName,IP:192.168.1.3,IP:127.0.0.1"
$solrCertificateDName = "CN=$solrHostName, OU=Organizational Unit, O=Organization, L=Location, ST=State, C=Country"

#services
$xConnectCollectionServiceUrl = "https://$xconnectHostName"
$solrServiceName = "$prefix.solr"
$solrPort = 8983
$solrUrl = "https://$solrHostName" + ":$solrPort/solr"
$solrCorePrefix = "sitecore"

#security
$sitecoreAdminPanelPassword = "b"

##
## INSTALATION STEPS ##
##

#
#install client certificate for xconnect
#
$certParams = @{
 Path = "$configurationFilesPath\xconnect-createcert.json"
 CertificateName = $xconnectClientCertificateName
 HostCertificateName = $xconnectHostCertificateName
 RootCertFileName = $rootCertificateName
 CertPath = $certificatesInstallPath
}

#Install-SitecoreConfiguration @certParams -Verbose

#
#install solr instance
#
$solrInstallParams = @{
 Path = "$configurationFilesPath\install-solr.json"
 SolrZipPath = $solrZipPath
 SolrRootPath = $solrInstallRoot
 KeytoolDirectoryPath = $keytoolDirectoryPath
 HostName = $solrHostName
 CertificateName = $solrCertificateName
 CertificatePassword = $solrCertificatePassword
 CertificateDNS = $solrCertificateDNS
 CertificateDName = $solrCertificateDName
 CertificatePath = $certificatesInstallPath
 NssmDirectoryPath = $nssmDirectoryPath
 SolrServiceName = $solrServiceName
 SolrPort = $solrPort
}

#Install-SitecoreConfiguration @solrInstallParams -Verbose

#
#install solr cores for xdb
#
$solrParams = @{
 Path = "$configurationFilesPath\xconnect-solr.json"
 SolrUrl = $solrUrl
 SolrRoot = $solrInstallRoot
 SolrService = $solrServiceName
 CorePrefix = $solrCorePrefix
}

#Install-SitecoreConfiguration @solrParams

#
#deploy xconnect instance
#
$xconnectParams = @{
 Path = "$configurationFilesPath\xconnect-xp0.json"
 Package = $xconnectWDPZipPath
 LicenseFile = $licenseFilePath
 SiteName = $xconnectHostName
 XConnectCert = $xconnectClientCertificateName
 SqlDbPrefix = $prefix
 SqlServer = $sqlServer
 SqlAdminUser = $sqlAdminUser
 SqlAdminPassword = $sqlAdminPassword
 SqlCollectionUser = $sqlAdminUser
 SqlCollectionPassword = $sqlAdminPassword
 SqlProcessingPoolsUser = $sqlAdminUser
 SqlProcessingPoolsPassword = $sqlAdminPassword
 SqlReferenceDataUser = $sqlAdminUser
 SqlReferenceDataPassword = $sqlAdminPassword
 SqlMarketingAutomationUser = $sqlAdminUser
 SqlMarketingAutomationPassword = $sqlAdminPassword
 SolrCorePrefix = $solrCorePrefix
 SSLCert = $xconnectHostCertificateName
 SolrURL = $solrUrl
 XConnectPhysicalPath = $xconnectInstallRootPath
}

#Install-SitecoreConfiguration @xconnectParams

#
#install solr cores for sitecore
#
$solrParams = @{
 Path = "$configurationFilesPath\sitecore-solr.json"
 SolrUrl = $solrUrl
 SolrRoot = $solrInstallRoot
 SolrService = $solrServiceName
 CorePrefix = $solrCorePrefix
}

#Install-SitecoreConfiguration @solrParams

#
#install sitecore instance
#
$sitecoreParams = @{
 Path = "$configurationFilesPath\sitecore-XP0.json"
 Package = $sitecoreWDPZipPath
 LicenseFile = $licenseFilePath
 SolrCorePrefix = $solrCorePrefix
 SolrUrl = $solrUrl
 SqlServer = $sqlServer
 SqlDbPrefix = $prefix
 SqlAdminUser = $sqlAdminUser
 SqlAdminPassword = $sqlAdminPassword
 SqlCoreUser = $sqlAdminUser
 SqlCorePassword = $sqlAdminPassword
 SqlMasterUser = $sqlAdminUser
 SqlMasterPassword = $sqlAdminPassword
 SqlWebUser = $sqlAdminUser
 SqlWebPassword = $sqlAdminPassword
 SqlReportingUser = $sqlAdminUser
 SqlReportingPassword = $sqlAdminPassword
 SqlProcessingPoolsUser = $sqlAdminUser
 SqlProcessingPoolsPassword = $sqlAdminPassword
 SqlProcessingTasksUser = $sqlAdminUser
 SqlProcessingTasksPassword = $sqlAdminPassword
 SqlReferenceDataUser = $sqlAdminUser
 SqlReferenceDataPassword = $sqlAdminPassword
 SqlMarketingAutomationUser = $sqlAdminUser
 SqlMarketingAutomationPassword = $sqlAdminPassword
 SqlFormsUser = $sqlAdminUser
 SqlFormsPassword = $sqlAdminPassword
 SitecoreAdminPassword = $sitecoreAdminPanelPassword

 XConnectCert = $xconnectClientCertificateName
 SiteName = $hostName
 XConnectCollectionService = $xConnectCollectionServiceUrl
 SitecorePhysicalPath = $sitecoreInstallRootPath

 HostCertificateName = $sitecoreCertificateName
 RootCertFileName = $rootCertificateName
 CertPath = $certificatesInstallPath
}

Install-SitecoreConfiguration @sitecoreParams