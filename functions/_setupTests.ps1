$rootPath = Join-Path -Path $PSScriptRoot -ChildPath ..
$manifestPath = Join-Path -Path $rootPath -ChildPath *.psd1
$manifestFile = Get-ChildItem -Path $manifestPath

$moduleName = $manifestFile.BaseName

Import-Module $manifestFile.FullName -Force
