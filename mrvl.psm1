$script:apiRoot = "https://gateway.marvel.com/v1/public"

if ( $IsWindows -or ( -not (Test-Variable 'variable:IsWindows') )) {
    $script:storedKeyFolder = Join-Path -Path $env:LOCALAPPDATA -ChildPath "MarvelApi"
}
else {
    $script:storedKeyFolder = Join-Path -Path $env:HOME -ChildPath ".MarvelApi"
}
$script:storedKeyFile = Join-Path -Path $storedKeyFolder -ChildPath "marvel.api.key.xml"

$sourceList = @( 'enums', 'classes', 'functions' )
foreach ( $source in $sourceList ) {
    $functionPath = Join-Path -Path $PSScriptRoot -ChildPath $source -AdditionalChildPath "*.ps1"
    $functions = Get-ChildItem -Path $functionPath -Exclude *.Tests.*, _*
    foreach ( $item in $functions ) {
        . $item.FullName
    }
}

if ( Test-Path -Path $storedKeyFile ) {
    $script:registeredKeys = Import-Clixml -Path $storedKeyFile
}
