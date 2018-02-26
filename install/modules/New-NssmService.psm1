#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function New-NssmService {

    [CmdletBinding(SupportsShouldProcess=$true)]
    param
    (
        [Parameter(Mandatory = $true)]
        [string] $Nssm
        ,
        [Parameter(Mandatory = $true)]
        [string] $ServiceName
        ,
        [Parameter(Mandatory = $true)]
        [string] $Program
        ,
        [Parameter(Mandatory = $true)]
        [string] $Arguments
    )

    Process {

        if($PSCmdlet.ShouldProcess($ServiceName, 'Installing service')) {
            & $Nssm install "$ServiceName" "$Program" $Arguments
            & $Nssm start "$ServiceName"
        }
    }
}

Register-SitecoreInstallExtension -Command New-NssmService -As NewNssmService -Type Task