function Get-Series {
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