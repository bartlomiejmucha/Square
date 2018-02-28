. ./parameters.ps1

##
## INSTALATION STEPS ##
##

#
#install client certificate for xconnect
#
$xconnectCreateCertParams = @{
 Path = "$srcConfigurationFilesPath\xconnect-createcert.json"
 CertificateName = $destXConnectClientCertificateName
 CertPath = $destCertificatesPath
 RootCertFileName = $destRootCertificateName
}

Install-SitecoreConfiguration @xconnectCreateCertParams -Verbose

#
#install host certificate for xconnect
#
$xconnectCreateHostCertParams = @{
 Path = "$srcConfigurationFilesPath\custom-xconnect-create-host-cert.json"
 CertPath = $destCertificatesPath
 RootCertFileName = $destRootCertificateName
 HostCertificateName = $destXConnectHostCertificateName
}

Install-SitecoreConfiguration @xconnectCreateHostCertParams -Verbose

#
#install solr instance
#
$solrInstallParams = @{
 Path = "$srcConfigurationFilesPath\custom-install-solr.json"
 SolrZipPath = $srcSolrZipPath
 SolrRootPath = $destSolrPath
 SolrHostName = $destSolrHostName
 SolrCertificateName = $destSolrCertificateName
 SolrCertificatePassword = $destSolrCertificatePassword
 SolrCertificateDNS = $destSolrCertificateDNS
 SolrCertificateDName = $destSolrCertificateDName
 SolrServiceName = $destSolrServiceName
 SolrPort = $destSolrPort
 CertPath = $destCertificatesPath
 KeytoolPath = $keytoolPath
 NssmPath = $nssmPath
}

Install-SitecoreConfiguration @solrInstallParams -Verbose

#
#install solr cores for xdb
#
$xconnectSolrParams = @{
 Path = "$srcConfigurationFilesPath\xconnect-solr.json"
 SolrUrl = $destSolrUrl
 SolrRoot = $destSolrPath
 SolrService = $destSolrServiceName
 CorePrefix = $destSolrCorePrefix
}

Install-SitecoreConfiguration @xconnectSolrParams

#
#deploy xconnect instance
#
$xconnectXP0Params = @{
 Path = "$srcConfigurationFilesPath\xconnect-xp0.json"
 Package = $srcXConnectWDPZipPath
 LicenseFile = $licenseFilePath
 SiteName = $destXConnectHostName
 XConnectCert = $destXConnectClientCertificateName
 SqlDbPrefix = $prefix
 SolrCorePrefix = $destSolrCorePrefix
 SSLCert = $destXConnectHostCertificateName 
 SqlAdminUser = $dbUser
 SqlAdminPassword = $dbPassword
 SolrUrl = $destSolrUrl
 SqlCollectionUser = $dbUser
 SqlCollectionPassword = $dbPassword
 SqlProcessingPoolsUser = $dbUser
 SqlProcessingPoolsPassword = $dbPassword
 SqlReferenceDataUser = $dbUser
 SqlReferenceDataPassword = $dbPassword
 SqlMarketingAutomationUser = $dbUser
 SqlMarketingAutomationPassword = $dbPassword
 SqlMessagingUser = $dbUser
 SqlMessagingPassword = $dbPassword
 SqlServer = $dbServer
 XConnectPhysicalPath = $destXConnectPath
}

Install-SitecoreConfiguration @xconnectXP0Params

#
#install solr cores for sitecore
#
$solrParams = @{
 Path = "$srcConfigurationFilesPath\sitecore-solr.json"
 SolrUrl = $destSolrUrl
 SolrRoot = $destSolrPath
 SolrService = $destSolrServiceName
 CorePrefix = $destSolrCorePrefix
}

Install-SitecoreConfiguration @solrParams

#
#install sitecore instance
#
$sitecoreParams = @{
 Path = "$srcConfigurationFilesPath\sitecore-XP0.json"
 Package = $srcSitecoreWDPZipPath
 LicenseFile = $licenseFilePath
 SqlDbPrefix = $prefix
 SolrCorePrefix = $destSolrCorePrefix
 XConnectCert = $destXConnectClientCertificateName
 SiteName = $destSitecoreHostName
 SitecoreAdminPassword = $destSitecoreAdminPassword
 SqlAdminUser = $dbUser
 SqlAdminPassword = $dbPassword
 SqlCoreUser = $dbUser
 SqlCorePassword = $dbPassword
 SqlMasterUser = $dbUser
 SqlMasterPassword = $dbPassword
 SqlWebUser = $dbUser
 SqlWebPassword = $dbPassword
 SqlReportingUser = $dbUser
 SqlReportingPassword = $dbPassword
 SqlProcessingPoolsUser = $dbUser
 SqlProcessingPoolsPassword = $dbPassword
 SqlProcessingTasksUser = $dbUser
 SqlProcessingTasksPassword = $dbPassword
 SqlReferenceDataUser = $dbUser
 SqlReferenceDataPassword = $dbPassword
 SqlMarketingAutomationUser = $dbUser
 SqlMarketingAutomationPassword = $dbPassword
 SqlFormsUser = $dbUser
 SqlFormsPassword = $dbPassword
 SqlExmMasterUser = $dbUser
 SqlExmMasterPassword = $dbPassword
 SqlMessagingUser = $dbUser
 SqlMessagingPassword = $dbPassword
 SqlServer = $dbServer
 SolrUrl = $destSolrUrl
 XConnectCollectionService = $destXConnectCollectionServiceUrl
 TelerikEncryptionKey = $destSitecoreTelerikEncryptionKey
 
 #custom
 SitecorePhysicalPath = $destSitecorePath
 CertPath = $destCertificatesPath
 RootCertFileName = $destRootCertificateName
 HostCertificateName = $destSitecoreCertificateName
}

Install-SitecoreConfiguration @sitecoreParams