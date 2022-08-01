BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-Event" {
    It "Returns expected output" {
        Get-Event | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
