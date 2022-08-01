BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Register-ApiKey" {
    It "Returns expected output" {
        Register-ApiKey | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
