function New-AuthParam {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [OutputType([hashtable])]
    [CmdletBinding()]
    Param(
        [pscredential]$ApiKey = $script:registeredKeys
    )

    Begin {
        $now = Get-Date
        $publicKey = $ApiKey.UserName
    }

    Process {
        $hash = ([System.BitConverter]::ToString((New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider).ComputeHash((New-Object -TypeName System.Text.UTF8Encoding).GetBytes( "$($now.Ticks)$( $ApiKey.GetNetworkCredential().Password )$($publicKey)" )))).Replace("-", "")
        @{
            ts     = $now.Ticks
            apikey = $publicKey
            hash   = $hash.ToLower()
        } | Write-Output
    }
}
