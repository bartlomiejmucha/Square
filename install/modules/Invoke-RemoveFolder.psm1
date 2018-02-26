#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function Invoke-RemoveFolder {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if($PSCmdlet.ShouldProcess($Path, 'Deleting folder')) {
        Write-Verbose "Removing Folder '$Path'"
        Remove-Item -Path $Path -Recurse
        Write-TaskInfo -Message $Path -Tag 'Removed'
    }
}

Register-SitecoreInstallExtension -Command Invoke-RemoveFolder -As RemoveFolder -Type Task