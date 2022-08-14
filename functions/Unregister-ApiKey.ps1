function Unregister-ApiKey {
    <#
        .SYNOPSIS
            Removes a previously registered API Key pair.
        .DESCRIPTION
            By default will remove the previously registered API key pair from memory. If those keys have been persisted to disk, use the -Stored parameter to remove the persisted copy as well.
        .PARAMETER Stored
            Removes the stored api keys as well as the set in memory.
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "High")]
    Param(
        [switch]$Stored,

        [switch]$Force
    )

    Begin {
        $verboseMsg = 'Removing stored api keys...'
        $verboseQuestion = 'Are you sure you would like to remove stored api keys?'

        $storedExists = Test-Path -Path $script:storedKeyFile

        if ( $Force ) { $ConfirmPreference = 'None' }
    }

    Process {
        Remove-Variable -Scope Script -Name registeredKeys

        if ( $Stored -and $storedExists -and $PSCmdlet.ShouldProcess( $verboseMsg , $verboseQuestion , 'Unregister-ApiKey' ) ) {
            Remove-Item -Path $script:storedKeyFile -Force
        }
    }
}

Export-ModuleMember -Function Unregister-ApiKey