BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-Creator" {
    It "Returns expected output" {
        {Get-Creator} | Should -Throw 'Get-Creator is not implemented.'
    }
}
