#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function Invoke-StopNssmService {

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
        if($PSCmdlet.ShouldProcess($ServiceName, 'Stopping service')) {
            & $Nssm stop "$ServiceName"
        }
    }
}

Register-SitecoreInstallExtension -Command Invoke-StopNssmService -As StopNssmService -Type Task