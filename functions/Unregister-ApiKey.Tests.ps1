[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
Param()

BeforeAll {
    $setupScript = Join-Path -Path $PSScriptRoot -ChildPath _setupTests.ps1
    . $setupScript
}

Describe "UnRegister-ApiKey" {
    BeforeAll {
        Mock -ModuleName $moduleName -CommandName Remove-item -MockWith { return $true }
        Mock -ModuleName $moduleName -CommandName Remove-Variable -MockWith { return $true }
        Mock -ModuleName $moduleName -CommandName Test-Path -MockWith { return $true }

        $goodKeyFolder = Join-Path -Path $env:LOCALAPPDATA -ChildPath "MarvelApi"
        $goodKeyFile = Join-Path -Path $goodKeyFolder -ChildPath "marvel.api.key.xml"
    }

    It "Runs as expected without the Stored parameter" {
        UnRegister-MarvelApiKey
        Should -Invoke -ModuleName $moduleName -CommandName Remove-Variable -Scope It -Times 1 -Exactly -ParameterFilter { $Scope -eq "Script" -and $Name -eq "registeredKeys" }
        Should -Invoke -ModuleName $moduleName -CommandName Test-Path -Scope It -Times 1 -Exactly -ParameterFilter { $Path -eq $goodKeyFile }
        Should -Not -Invoke -ModuleName $moduleName -CommandName Remove-Item
    }

    It "Runs as expected with the Stored parameter" {
        UnRegister-MarvelApiKey -Stored -Confirm:$false
        Should -Invoke -ModuleName $moduleName -CommandName Remove-Variable -Scope It -Times 1 -Exactly -ParameterFilter { $Scope -eq "Script" -and $Name -eq "registeredKeys" }
        Should -Invoke -ModuleName $moduleName -CommandName Test-Path -Scope It -Times 1 -Exactly -ParameterFilter { $Path -eq $goodKeyFile }
        Should -Invoke -ModuleName $moduleName -CommandName Remove-Item -Scope It -Times 1 -Exactly -ParameterFilter { $Path -eq $goodKeyFile -and $Force -eq [switch]$true }
    }
}
