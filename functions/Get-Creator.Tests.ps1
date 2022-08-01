BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-Creator" {
    It "Returns expected output" {
        Get-Creator | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
