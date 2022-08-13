BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Invoke-MarvelApi" {
    It "Returns expected output" {
        Invoke-MarvelApi | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
