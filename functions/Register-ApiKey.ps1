function Register-ApiKey {
    <#
        .SYNOPSIS
            Registers a set of API Keys.

        .DESCRIPTION
            Registers a set of API Keys from the Marvel Developer Program with the current session or user.

        .PARAMETER ApiKey
            Takes a PSCredential object with the PublicKey as UserName and PrivateKey as Password. If left blank you will be prompted for the values.

        .PARAMETER Persist
            Stores the ApiKey pair on the file system in %LOCALAPPDATA%/MarvelApi/marvel.api.key.xml.
            This option should not be used on public computers.
    #>
    [CmdletBinding()]
    Param(
        [ValidateNotNullOrEmpty()]
        [pscredential]$ApiKey = (Get-Credential -Message "Enter your Marvel Developer API PublicKey as UserName and PrivateKey as Password."),

        [switch]$Persist
    )

    Begin {
        if ( $Persist ) {
            if ( Test-Path -Path $script:storedKeyFolder ) {
                Write-Verbose "Found existing credential path. ($script:storedKeyFolder)"
            } else {
                Write-Verbose "Creating credential path: $script:storedKeyFolder"
                New-Item -ItemType Directory -Path $script:storedKeyFolder -Force | Out-Null
            }
        }
    }

    Process {
        Set-Variable -Scope Script -Name registeredKeys -Value $ApiKey

        if ( $Persist ) {
            $ApiKey | Export-Clixml -Path $script:storedKeyFile -Force
        }
    }
}

Export-ModuleMember -Function Register-ApiKey