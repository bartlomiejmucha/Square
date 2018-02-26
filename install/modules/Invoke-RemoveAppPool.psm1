#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function Invoke-RemoveAppPool {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    $instance = Get-WebAppPoolState -Name $Name
    if($instance){
        if($PSCmdlet.ShouldProcess($Name, 'Deleting AppPool')) {
            Write-Verbose "Removing AppPool '$Name'"
            Remove-WebAppPool -Name $Name
            Write-TaskInfo -Message $Name -Tag 'Removed'
        }
    } else {
        Write-Warning -Message "Could not find AppPool: '$Name'"
    }
}

Register-SitecoreInstallExtension -Command Invoke-RemoveAppPool -As RemoveAppPool -Type Task