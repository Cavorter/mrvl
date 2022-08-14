BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-Comic" {
    It "Returns expected output" {
        {Get-Comic} | Should -Throw 'Get-Comic is not implemented.'
    }
}
