function Register-ApiKey {
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
        $script:registeredKeys = $ApiKey

        if ( $Persist ) {
            $ApiKey | Export-Clixml -Path $script:storedKeyFile -Force
        }
    }
}

Export-ModuleMember -Function Register-ApiKey