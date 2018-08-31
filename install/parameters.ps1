##
## MAIN PARAMETERS ##
##

$prefix = "square"

$installRootPath = "C:\Websites\$prefix"
$licenseFilePath = "C:\Websites\license.xml"

#database
$dbServer = "."
$dbUser = "user" 
$dbPassword="pass"

#tools
$keytoolPath = "C:\Program Files\Java\jdk1.8.0_144\bin\keytool.exe"
$nssmPath = "C:\Program Files\nssm\win64\nssm.exe"

. ./parameters-local.ps1
    
##
## OPTIONAL PARAMETERS ##
##

#source paths
$srcInstallScriptsPath = $PSScriptRoot
$srcConfigurationFilesPath = "$srcInstallScriptsPath\configuration files"
$srcZipsPath = "$srcInstallScriptsPath\zips"

#source zip
$srcSolrZipPath = "$srcZipsPath\solr-6.6.2.zip"
$srcXConnectWDPZipPath = "$srcZipsPath\Sitecore 9.0.2 rev. 180604 (OnPrem)_xp0xconnect.scwdp.zip"
$srcSitecoreWDPZipPath = "$srcZipsPath\Sitecore 9.0.2 rev. 180604 (OnPrem)_single.scwdp.zip"

#destination solr
$destSolrPath = "$installRootPath\solr"
$destSolrHostName = "$prefix.solr"
$destSolrCertificateName = "$prefix.solr"
$destSolrCertificatePassword = "secret"
$destSolrCertificateDNS = "$destSolrHostName,IP:192.168.1.3,IP:127.0.0.1"
$destSolrCertificateDName = "CN=$destSolrHostName, OU=Organizational Unit, O=Organization, L=Location, ST=State, C=Country"
$destSolrServiceName = "$prefix.solr"
$destSolrPort = 9001
$destSolrUrl = "https://$destSolrHostName" + ":$destSolrPort/solr"
$destSolrCorePrefix = "sitecore"

#destination xconnect
$destXConnectPath = "$installRootPath\xconnect"
$destXConnectHostName = "$prefix.xconnect"
$destXConnectClientCertificateName = "$prefix.xconnect_client"
$destXConnectHostCertificateName = "$prefix.xconnect"
$destXConnectCollectionServiceUrl = "https://$destXConnectHostName"

#destination sitecore
$destSitecorePath = "$installRootPath\sitecore"
$destSitecoreHostName = "$prefix.sc"
$destSitecoreCertificateName = "$prefix.sc"
$destSitecoreAdminPassword = "b"
$destSitecoreTelerikEncryptionKey = "e9kkLjJKrVO0ZlJ7r4gFMDLCqYSJU2r7"

#destination certificates
$destCertificatesPath = "$installRootPath\certificates"
$destRootCertificateName = "$prefix.sitecore_root"