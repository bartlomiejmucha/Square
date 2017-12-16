#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function Invoke-ConfigureSolrCertificate {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$true)]
        [string]$SolrRootPath
        ,
        [Parameter(Mandatory=$true)]
        [string]$Password
        ,
        [Parameter(Mandatory=$true)]
        [string]$HostName
    )

    $solrincmdPath = $SolrRootPath + "\bin\solr.in.cmd"

    $solrincmdText = [System.IO.File]::ReadAllText($solrincmdPath)

    $solrincmdText = $solrincmdText.Replace("REM set SOLR_HOST=192.168.1.1", "set SOLR_HOST=" + $HostName)

    $solrincmdText = $solrincmdText.Replace("REM set SOLR_SSL_KEY_STORE=etc/solr-ssl.keystore.jks", "set SOLR_SSL_KEY_STORE=etc/solr-ssl.keystore.jks")
    $solrincmdText = $solrincmdText.Replace("REM set SOLR_SSL_KEY_STORE_PASSWORD=secret", "set SOLR_SSL_KEY_STORE_PASSWORD=" + $Password)
    $solrincmdText = $solrincmdText.Replace("REM set SOLR_SSL_KEY_STORE_TYPE=JKS", "set SOLR_SSL_KEY_STORE_TYPE=JKS")
    $solrincmdText = $solrincmdText.Replace("REM set SOLR_SSL_TRUST_STORE=etc/solr-ssl.keystore.jks", "set SOLR_SSL_KEY_STORE=etc/solr-ssl.keystore.jks")
    $solrincmdText = $solrincmdText.Replace("REM set SOLR_SSL_TRUST_STORE_PASSWORD=secret", "set SOLR_SSL_KEY_STORE_PASSWORD=" + $Password)
    $solrincmdText = $solrincmdText.Replace("REM set SOLR_SSL_TRUST_STORE_TYPE=JKS", "set SOLR_SSL_KEY_STORE_TYPE=JKS")
    $solrincmdText = $solrincmdText.Replace("REM set SOLR_SSL_NEED_CLIENT_AUTH=false", "set SOLR_SSL_NEED_CLIENT_AUTH=false")
    $solrincmdText = $solrincmdText.Replace("REM set SOLR_SSL_WANT_CLIENT_AUTH=false", "set SOLR_SSL_WANT_CLIENT_AUTH=true")

    [System.IO.File]::WriteAllText($solrincmdPath, $solrincmdText)
}

Register-SitecoreInstallExtension -Command Invoke-ConfigureSolrCertificate -As ConfigureSolrCertificate -Type Task