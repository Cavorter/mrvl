[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
Param()

BeforeAll {
    $setupScript = Join-Path -Path $PSScriptRoot -ChildPath _setupTests.ps1
    . $setupScript
}

Describe "Register-ApiKey" {
    BeforeAll {
        $testKeys = New-Object -TypeName pscredential -ArgumentList 'someUser', ( 'somePwd' | ConvertTo-SecureString -AsPlainText -Force )

        Mock -ModuleName $moduleName -CommandName Test-Path -MockWith { return $false }
        Mock -ModuleName $moduleName -CommandName New-Item -MockWith { return $true }
        Mock -ModuleName $moduleName -CommandName Export-Clixml -MockWith { return $true }
        Mock -ModuleName $moduleName -CommandName Set-Variable -MockWith { return $true } -Verifiable
    }

    Context "Not Persisted" {
        BeforeAll {
            Register-MarvelApiKey -ApiKey $testKeys

            $invokeParams = @{
                Invoke     = [switch]$true
                Scope      = "Context"
                ModuleName = $moduleName
                Times      = 1
                Exactly    = [switch]$true
            }
        }

        It "Sets the script scoped variable" {
            $shouldParams = $invokeParams + @{
                CommandName     = "Set-Variable"
                ParameterFilter = { $Scope -eq "Script" -and $Name -eq "registeredKeys" -and $Value.UserName -eq $testKeys.UserName }
            }
            Should @shouldParams
        }

        It "Does not persist the keys to disk" {
            $invokeParams.Times = 0
            Should @invokeParams -CommandName "Test-Path"
            Should @invokeParams -CommandName "New-Item"
            Should @invokeParams -CommandName "Export-Clixml"
        }
    }

    Context "Persisted" {
        BeforeAll {
            Register-MarvelApiKey -ApiKey $testKeys -Persist

            $invokeParams = @{
                Invoke     = [switch]$true
                Scope      = "Context"
                ModuleName = $moduleName
                Times      = 1
                Exactly    = [switch]$true
            }
        }

        It "Checks if the user's storage folder exists" {
            $invokeParams.CommandName = "Test-Path"
            $invokeParams.ParameterFilter = { $Path -eq $goodKeyFolder }
            Should @invokeParams
        }

        It "Creates the storage folder" {
            $invokeParams.CommandName = "New-Item"
            $invokeParams.ParameterFilter = { $ItemType -eq "Directory" -and $Path -eq $goodKeyFolder -and $Force -eq [switch]$true }
            Should @invokeParams
        }

        It "Writes the ApiKey variable to disk" {
            $invokeParams.CommandName = "Export-Clixml"
            $invokeParams.ParameterFilter = { $Path -eq $goodKeyFile -and $Force -eq [switch]$true }
            Should @invokeParams
        }
    }
}
