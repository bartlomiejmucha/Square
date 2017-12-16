#Requires -RunAsAdministrator
#Requires -Modules PKI

Set-StrictMode -Version Latest

Function New-JavaKeyStore {

    [CmdletBinding(SupportsShouldProcess=$true)]
    param
    (
        [Parameter(Mandatory = $true)]
        [string] $Keytool
        ,
        [Parameter(Mandatory = $true)]
        [string] $Alias
        ,
        [Parameter(Mandatory = $true)]
        [string] $Password
        ,
        [Parameter(Mandatory = $true)]
        [string] $DName
        ,
        [Parameter(Mandatory = $true)]
        [string] $DNS
        ,
        [Parameter(Mandatory = $true)]
        [string] $DestPathJKS
        ,
        [Parameter(Mandatory = $true)]
        [string] $DestPathP12
    )

    Process {

        & $Keytool -genkeypair -alias $Alias -keyalg RSA -keysize 2048 -keypass $Password -storepass $Password -validity 9999 -keystore "$DestPathJKS\solr-ssl.keystore.jks" -ext SAN=DNS:$DNS -dname $DName

        & $Keytool -importkeystore -srckeystore "$DestPathJKS\solr-ssl.keystore.jks" -destkeystore "$DestPathP12\solr-ssl.keystore.p12" -srcstoretype jks -deststoretype pkcs12 -srcstorepass $Password -deststorepass $Password -noprompt

        $securePassword = ConvertTo-SecureString -String $Password -Force -AsPlainText

        Import-PfxCertificate -FilePath "$DestPathP12\solr-ssl.keystore.p12" -Password $securePassword -CertStoreLocation Cert:\LocalMachine\Root
    }
}

Register-SitecoreInstallExtension -Command New-JavaKeyStore -As NewJavaKeyStore -Type Task