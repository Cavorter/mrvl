[CmdletBinding(SupportsShouldProcess = $true)]
Param(
    [version]$Version = 0.1
)

$manifestFile = Join-Path -Path $PSScriptRoot -ChildPath "*.psd1"
$manifestContent = Import-PowerShellDataFile -Path $manifestFile

# Update Version
Write-Information "Version (Old/New):`n--" $manifestContent.ModuleVersion
Write-Information "++ $Version"

# Update ScriptsToProcess
Write-Information "ScriptsToProcess (Old/New):"
Write-Information "--" $manifestContent.ScriptsToProcess
$scriptFiles = foreach ( $item in @( 'enums', 'classes') ) {
    $itemPath = Join-Path -Path $PSScriptRoot -ChildPath $item -AdditionalChildPath "*.ps1"
    Get-ChildItem -Path $itemPath -Exclude *.Tests.* | Write-Output
}
$scriptsToProcess = ( Resolve-Path -Path $scriptFiles -Relative ).TrimStart('.', '/', '\')
Write-Information "++" $scriptsToProcess

Update-ModuleManifest -Path $manifestFile -ModuleVersion $Version -ScriptsToProcess $scriptsToProcess
