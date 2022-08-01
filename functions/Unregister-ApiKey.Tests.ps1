BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "UnRegister-ApiKey" {
    It "Returns expected output" {
        UnRegister-ApiKey | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
