[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
Param()

BeforeAll {
    $setupScript = Join-Path -Path $PSScriptRoot -ChildPath _setupTests.ps1
    . $setupScript
}

Describe "Get-Series" {
    BeforeDiscovery {
        $testSeriesData = Get-Content -Path (Join-Path -Path $PSScriptRoot -ChildPath test-objects -AdditionalChildPath series.json ) | ConvertFrom-Json
        $idObjCases = @(
            @{
                type       = "Id"
                goodId     = $testSeriesData.Id
                testParams = @{
                    Id = $testSeriesData.Id
                }
            }
            @{
                type       = "Series"
                goodId     = $testSeriesData.Id
                testParams = @{
                    Series = $testSeriesData
                }
            }
        )
    }

    BeforeAll {
        $mockBase = @{
            ModuleName  = $moduleName
            CommandName = "Invoke-Api"
        }
        Mock @mockBase -MockWith { return $testSeriesData }

        $invokeParams = $mockBase + @{
            Invoke  = [switch]$true
            Times   = 1
            Exactly = [switch]$true
        }

        $goodName = $testSeriesObj.Title
    }

    Context "Series Name" {
        BeforeDiscovery {
            $nameWildcardCases = @( '*' , '?' )
        }

        It "Searches for a series by name without a wildcard" {
            Get-MarvelSeries -Name $goodName | Out-Null
            Should @invokeParams -ParameterFilter { $Path -eq @( "series" ) -and $Query.title -eq $goodName -and $Query.Keys.Count -eq 1 }
        }

        It "Searches for a series by name with a <_> wildcard" -TestCases $nameWildcardCases {
            Get-MarvelSeries -Name ( $goodName + $_ ) | Out-Null
            Should @invokeParams -ParameterFilter { $Path -eq @( "series" ) -and $Query.titleStartsWith -eq $goodName -and $Query.Keys.Count -eq 1 }
        }
    }

    Context "Series <type>" -Foreach $idObjCases {
        BeforeDiscovery {
            $idContentCases = @('Characters', 'Comics', 'Creators', 'Events', 'Stories')
        }

        It "Retrieves a series by <type>" {
            Get-MarvelSeries @testParams | Out-Null
            Should @invokeParams -ParameterFilter { $Path[0] -eq "series" -and $Path[1] -eq $goodId -and $Query.Keys.Count -eq 0 }
        }

        It "Retrieves a series by <type> and content type <_>" -TestCases $idContentCases {
            $contentType = $_
            Get-MarvelSeries @testParams -Content $contentType | Out-Null
            Should @invokeParams -ParameterFilter { $Path[0] -eq "series" -and $Path[1] -eq $goodId -and $Path[2] -eq $contentType -and $Query.Keys.Count -eq 0 }
        }
    } }
