[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
Param()

$rootPath = Join-Path -Path $PSScriptRoot -ChildPath ..
$manifestPath = Join-Path -Path $rootPath -ChildPath *.psd1
$manifestFile = Get-ChildItem -Path $manifestPath

$moduleName = $manifestFile.BaseName

Import-Module $manifestFile.FullName -Force

if ( $IsWindows -or ( -not (Get-Variable -Name IsWindows ) )) {
    $goodKeyFolder = Join-Path -Path $env:LOCALAPPDATA -ChildPath "MarvelApi"
}
else {
    $goodKeyFolder = Join-Path -Path $env:HOME -ChildPath ".MarvelApi"
}
$goodKeyFile = Join-Path -Path $goodKeyFolder -ChildPath "marvel.api.key.xml"


$contentPath = Join-Path -Path $PSScriptRoot -ChildPath test-objects -AdditionalChildPath "*.json"
foreach ( $item in ( Get-ChildItem -Path $contentPath )) {
    $dataVarName = "test$( $item.BaseName )Data"
    New-Variable -Scope Local -Name $dataVarName -Value ( Get-Content -Path $item.FullName | ConvertFrom-Json )
    New-Variable -Scope Local -Name "test$( $item.BaseName )Obj" -Value ( [MarvelSeries]( Get-Variable -Scope Local -Name $dataVarName ).Value )
}