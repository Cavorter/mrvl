BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-Story" {
    It "Returns expected output" {
        {Get-Story} | Should -Throw 'Get-Story is not implemented.'
    }
}
