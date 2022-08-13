BeforeAll {
    $setupScript = Join-Path -Path $PSScriptRoot -ChildPath _setupTests.ps1
    . $setupScript
}

Describe "New-AuthParams" {
    It "Returns expected output" {
        InModuleScope -ModuleName $moduleName {
            $testTime = Get-Date
            $testKeys = New-Object -TypeName pscredential -ArgumentList '123publickey', ('456privatekey' | ConvertTo-SecureString -AsPlainText -Force)
    
            Mock -CommandName Get-Date -MockWith { return $testTime } -Verifiable
    
            $testHash = ([System.BitConverter]::ToString((New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider).ComputeHash((New-Object -TypeName System.Text.UTF8Encoding).GetBytes( "$($testTime.Ticks)$( $testKeys.GetNetworkCredential().Password )$($testKeys.UserName)" )))).Replace("-", "").ToLower()

            $testResult = New-AuthParams -ApiKey $testKeys

            Should -InvokeVerifiable
            $testResult | Should -BeOfType [hashtable]
            $testResult.ts | Should -Be $testTime.Ticks
            $testResult.apikey | Should -Be $testKeys.UserName
            $testResult.hash | Should -Be $testHash
        }
    }
}
