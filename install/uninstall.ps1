. ./parameters.ps1

##
## UNINSTALL STEPS ##
##

$uninstallParams = @{
 Path = "$srcConfigurationFilesPath\custom-uninstall.json"
 SitecoreSiteName = $destSitecoreHostName
 SitecoreHostName = $destSitecoreHostName
 SitecorePhysicalPath = $destSitecorePath
 SitecoreCertificateName = $destSitecoreCertificateName
 XConnectSiteName = $destXConnectHostName
 XConnectHostName = $destXConnectHostName
 XConnectPhysicalPath = $destXConnectPath
 XConnectHostCertificateName = $destXConnectHostCertificateName
 XConnectClientCertificateName = $destXConnectClientCertificateName
 SolrServiceName = $destSolrServiceName
 SolrHostName = $destSolrHostName
 SolrPhysicalPath = $destSolrPath
 SolrCertificateName = $destSolrCertificateName
 RootCertificateName = $destRootCertificateName
 CertPhysicalPath = $destCertificatesPath
 SqlDbPrefix = $prefix
 SqlServer = $dbServer
 SqlAdminUser = $dbUser
 SqlAdminPassword = $dbPassword
 NssmPath = $nssmPath
}

Install-SitecoreConfiguration @uninstallParams -Verbose