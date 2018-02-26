#Requires -RunAsAdministrator

Set-StrictMode -Version Latest

Function Invoke-RemoveDatabase {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Server,
        [Parameter(Mandatory=$true)]
        [string]$User,
        [Parameter(Mandatory=$true)]
        [string]$Password,
        [Parameter(Mandatory=$true)]
        [string[]]$Databases
    )

    foreach($dbName in $Databases)
    {
        if($PSCmdlet.ShouldProcess($dbName, 'Deleting database'))
        {
            $sqlQuery = $("DROP DATABASE IF EXISTS [$($dbName)]")
            
            Write-Verbose "Removing database '$dbName'"
            invoke-sqlcmd -ServerInstance $Server -U $User -P $Password -Query $sqlQuery -ErrorAction stop
            Write-TaskInfo -Message $dbName -Tag 'Removed'
        }
    }
}

Register-SitecoreInstallExtension -Command Invoke-RemoveDatabase -As RemoveDatabase -Type Task