function Invoke-Api {
    [OutputType([psobject[]])]
    [CmdletBinding()]
    Param(
        [string[]]$Path,

        [hashtable]$Query
    )

    Begin {
        $uriBase = @(
            "https:"
            ""
            "gateway.marvel.com"
            "v1"
            "public"
        )

        Write-Verbose "Uri Base: $uri"
        $uri = ( $uriBase + $Path ) -join '/'

        $paramList = New-AuthParam
        if ( $Query ) { $paramList += $Query }
        $paramItems = foreach ( $item in $paramList.Keys ) {
            Write-Verbose "Parameter: $item"
            $rawValue = $paramList."$item"
            Write-Verbose "Value: $rawValue"
            $safeValue = [System.Web.HttpUtility]::UrlEncode($rawValue)
            Write-Verbose "Safe Value: $safeValue"
            $returnItem = "{0}={1}" -f $item, $safeValue
            Write-Verbose "Uri Parameter: $returnItem"
            $returnItem | Write-Output
        }
        $paramString = $paramItems -join '&'
        Write-Verbose "Parameter String: $paramString"

        $uri += "?$paramString"
        Write-Verbose "Uri: $uri"

        [uri]$safeUri = $uri
        Write-Verbose "Safe Uri: $( $safeUri.AbsoluteUri )"
    }

    Process {
        $result = Invoke-RestMethod -Method Get -Uri $safeUri.AbsoluteUri
        if ( $result.attributionText ) {
            Write-Information $result.attributionText
        }
        $result.data.results | Write-Output
    }
}
