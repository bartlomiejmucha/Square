#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function Invoke-RemoveWebsite {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    $instance = Get-WebsiteState -Name $Name
    if($instance){
        if($PSCmdlet.ShouldProcess($Name, 'Removing website')) {
            Write-Verbose "Removing Website '$Name'"
            Remove-Website -Name $Name
            Write-TaskInfo -Message $Name -Tag 'Removed'
        }
    } else {
        Write-Warning -Message "Could not find website: '$Name'"
    }
}

Register-SitecoreInstallExtension -Command Invoke-RemoveWebsite -As RemoveWebsite -Type Task