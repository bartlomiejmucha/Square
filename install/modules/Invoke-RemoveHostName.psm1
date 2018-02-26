#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function Invoke-RemoveHostName {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$Names
    )

    $hostsFilePath = "$($env:windir)\System32\drivers\etc\hosts"

    foreach($name in $Names)
    {
        if($PSCmdlet.ShouldProcess($name, 'Deleting host names')) 
        {
            Write-Verbose "Removing host name '$name'"

            foreach($item in Get-Content $hostsFilePath | Select-String $name)
            {
                (Get-Content $hostsFilePath) | Select-String $item -NotMatch | Set-Content $hostsFilePath
            }

            Write-TaskInfo -Message $name -Tag 'Removed'
        }        
    }  
}

Register-SitecoreInstallExtension -Command Invoke-RemoveHostName -As RemoveHostName -Type Task