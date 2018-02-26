#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function Invoke-RemoveCertificate {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    if($PSCmdlet.ShouldProcess($Name, 'Deleting certificate')) {
        Write-Verbose "Removing Certificate '$Name'"
        Remove-Item -Path $Name
        Write-TaskInfo -Message $Name -Tag 'Removed'
    }
}

Register-SitecoreInstallExtension -Command Invoke-RemoveCertificate -As RemoveCertificate -Type Task