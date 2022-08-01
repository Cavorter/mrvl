BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "New-AuthParams" {
    It "Returns expected output" {
        New-AuthParams | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
