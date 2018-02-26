#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function Invoke-RemoveNssmService {

    [CmdletBinding(SupportsShouldProcess=$true)]
    param
    (
        [Parameter(Mandatory = $true)]
        [string] $Nssm
        ,
        [Parameter(Mandatory = $true)]
        [string] $ServiceName
    )

    Process {
        if($PSCmdlet.ShouldProcess($ServiceName, 'Removing service')) {
            & $Nssm remove "$ServiceName" confirm
        }
    }
}

Register-SitecoreInstallExtension -Command Invoke-RemoveNssmService -As RemoveNssmService -Type Task