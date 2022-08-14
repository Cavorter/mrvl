function Get-Series {
    <#
        .SYNOPSIS
            Get information about a Marvel Series
        .DESCRIPTION
            Queries the Marvel API for information about one or more Series (Also called "Titles").
        .PARAMETER Name
            Get information on a series with the given name. You may use wildcards at the end of this value to query for Series with names that start with the string.
        .PARAMETER Id
            The Id for a specific Marvel Series to look up.
        .PARAMETER Content
            Return only the specified type of content for the specified Series by Id.
    #>
    [OutputType([MarvelSeries[]])]
    [CmdletBinding()]
    Param(
        [Parameter(ParameterSetName = 'name')]
        [SupportsWildcards()]
        [ValidateNotNullOrEmpty()]
        # [ValidateScript({ if ( @( '*' , '?' ) -contains $_[0] ) { throw "Name parameter may NOT start with a wildcard! ($_)" } })]
        [string]$Name,

        [Parameter(ParameterSetName = 'id')]
        [ValidateNotNullOrEmpty()]
        [int]$Id,

        [Parameter(ParameterSetName = 'id')]
        [ValidateSet('All', 'Characters', 'Comics', 'Creators', 'Events', 'Stories')]
        [string]$Content = 'All'
    )

    Begin {
        $pathParts = @( 'series' )

        # Search by known Id
        if ( $Id ) {
            $pathParts += $Id
        }

        if ( $Content -ne 'All' ) {
            $pathParts += $Content.ToLower()
        }

        $queryParts = @{}

        # Search by Name
        if ( $Name ) {
            if ( $Name -match '\*$|\?$' ) {
                $queryParts.titleStartsWith = $Name.TrimEnd('?', '*')
            }
            else {
                $queryParts.title = $Name
            }
        }
    }

    Process {
        $result = Invoke-Api -Path $pathParts -Query $queryParts
        [MarvelSeries[]]$result | Write-Output
    }
}

New-Alias -Name Get-Title -Value Get-Series
Export-ModuleMember -Function Get-Series -Alias Get-Title