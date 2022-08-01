BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-Comic" {
    It "Returns expected output" {
        Get-Comic | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
