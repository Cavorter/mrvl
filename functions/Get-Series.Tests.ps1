BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-Series" {
    It "Returns expected output" {
        Get-Series | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
