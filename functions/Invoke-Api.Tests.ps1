[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
Param()

BeforeDiscovery {
    $setupScript = Join-Path -Path $PSScriptRoot -ChildPath _setupTests.ps1
    . $setupScript
}

BeforeAll {
    $setupScript = Join-Path -Path $PSScriptRoot -ChildPath _setupTests.ps1
    . $setupScript
}

Describe "Invoke-Api" {
    InModuleScope -ModuleName $moduleName {
        BeforeAll {
            # $script:registeredKeys = New-Object -TypeName pscredential -ArgumentList 'foo123', ('abc456' | ConvertTo-SecureString -AsPlainText -Force)
            $goodAuthParams = @{
                ticks  = 1234567890
                apikey = 'foo123'
                hash   = 'abcd1234'
            }

            $goodBaseUri = 'https://gateway.marvel.com/v1/public'

            $goodData = @{
                data = @{
                    results = @(
                        @{ id = 1; resourceURI = 'http://some.url/and/path' }
                        @{ id = 2; resourceURI = 'http://some.other.url/and/path' }
                    )
                }
            }

            Mock -CommandName New-AuthParam -MockWith { return $goodAuthParams } -Verifiable
            Mock -CommandName Invoke-RestMethod -MockWith { return $goodData } -Verifiable
        }

        Context "No query parameters" {
            BeforeAll {
                $goodParams = @{
                    Path = @( 'one' , 'two' )
                }
                $testResult = Invoke-Api @goodParams
            }

            It "Invokes verified mocks" {
                Should -InvokeVerifiable
            }

            It "Invokes the expected endpoint" {
                $goodQuery = foreach ( $item in $goodAuthParams.Keys ) { "$item=$( $goodAuthParams."$item" )" }
                $testUri = (@($goodBaseUri) + $goodParams.Path -join '/') + '?' + ($goodQuery -join '&')
                $invokeParams = @{
                    Invoke          = [switch]$true
                    Scope           = "Context"
                    CommandName     = "Invoke-RestMethod"
                    Times           = 1
                    Exactly         = [switch]$true
                    ParameterFilter = { $Uri -eq $testUri }
                }
                Should @invokeParams
            }
        }

        Context "With query parameters" {
            BeforeAll {
                $goodParams = @{
                    Path  = @( 'one' , 'two' )
                    Query = @{
                        paramOne = 1234
                        paramtwo = "abcd"
                    }
                }
                $testResult = Invoke-Api @goodParams
            }

            It "Invokes verified mocks" {
                Should -InvokeVerifiable
            }

            It "Invokes the expected endpoint" {
                $paramSet = $goodParams.Query + $goodAuthParams
                $goodQuery = foreach ( $item in $paramSet.Keys ) { "$item=$( $paramSet."$item" )" }
                $testUri = (@($goodBaseUri) + $goodParams.Path -join '/') + '?' + ($goodQuery -join '&')
                $invokeParams = @{
                    Invoke          = [switch]$true
                    Scope           = "Context"
                    CommandName     = "Invoke-RestMethod"
                    Times           = 1
                    Exactly         = [switch]$true
                    ParameterFilter = {
                        $testParts = ( ( [uri]$testUri ).Query.Trim('?').Split('&').forEach({ $result = $_.split('='); @{ "$( $result[0] )" = $result[1] } }) ) | Sort-Object -Property Keys
                        $queryParts = ( ( [uri]$Uri ).Query.Trim('?').Split('&').forEach({ $result = $_.split('='); @{ "$( $result[0] )" = $result[1] } }) ) | Sort-Object -Property Keys
                        $null -eq ( Compare-Object -ReferenceObject $testParts.Keys -DifferenceObject $queryParts.Keys )
                        $null -eq ( Compare-Object -ReferenceObject $testParts.Values -DifferenceObject $queryParts.Values )
                    }
                }
                Should @invokeParams
            }

        }
    }
}
