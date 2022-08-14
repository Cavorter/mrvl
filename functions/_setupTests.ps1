$rootPath = Join-Path -Path $PSScriptRoot -ChildPath ..
$manifestPath = Join-Path -Path $rootPath -ChildPath *.psd1
$manifestFile = Get-ChildItem -Path $manifestPath

$moduleName = $manifestFile.BaseName

Import-Module $manifestFile.FullName -Force

$contentPath = Join-Path -Path $PSScriptRoot -ChildPath test-objects -AdditionalChildPath "*.json"
foreach ( $item in ( Get-ChildItem -Path $contentPath )) {
    $dataVarName = "test$( $item.BaseName )Data"
    New-Variable -Scope Local -Name $dataVarName -Value ( Get-Content -Path $item.FullName | ConvertFrom-Json )
    New-Variable -Scope Local -Name "test$( $item.BaseName )Obj" -Value ( [MarvelSeries]( Get-Variable -Scope Local -Name $dataVarName ).Value )
}