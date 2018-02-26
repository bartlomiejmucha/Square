#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function Invoke-EnsureNoNestedSubfolder {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    $files = [System.IO.Directory]::GetFiles($Path)
    $directories = [System.IO.Directory]::GetDirectories($Path)

    #if there is only one directory inside than move it one level up
    if ($files.Length -eq 0 -and $directories.Length -eq 1)
    {
        if($PSCmdlet.ShouldProcess($Path, 'Removing nested subfolder')) 
        {
            Write-TaskInfo -Message "Nested subfolder $directories[0] moved up." -Tag 'Clean'

            [System.IO.Directory]::GetDirectories($directories[0]) | foreach { Move-Item $_ $Path }
            [System.IO.Directory]::GetFiles($directories[0]) | foreach { Move-Item $_ $Path }

            Remove-Item $directories[0]
        }
    }
}

Register-SitecoreInstallExtension -Command Invoke-EnsureNoNestedSubfolder -As EnsureNoNestedSubfolder -Type Task