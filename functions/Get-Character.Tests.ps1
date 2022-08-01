BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-Character" {
    It "Returns expected output" {
        Get-Character | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
