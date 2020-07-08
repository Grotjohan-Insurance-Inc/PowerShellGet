#
# Script module for module 'PowerShellGet'
#
Set-StrictMode -Version Latest

# Summary: PowerShellGet is supported on Windows PowerShell 5.1 or later and PowerShell 6.0+

$isCore = ($PSVersionTable.Keys -contains "PSEdition") -and ($PSVersionTable.PSEdition -ne 'Desktop')
if ($isCore)
{
    $script:Framework = 'netstandard2.0'
    $script:FrameworkToRemove = 'net472'
    
} else {
    $script:Framework = 'net472'
    $script:FrameworkToRemove = 'netstandard2.0'
}

# Set up some helper variables to make it easier to work with the module
$script:PSModule = $ExecutionContext.SessionState.Module
$script:PSModuleRoot = $script:PSModule.ModuleBase
$script:PSGet = 'PowerShellGet.dll'

# Remove framework binaries that are not needed
$FrameworkToRemovePath = Join-Path -Path $script:PSModuleRoot -ChildPath $script:FrameworkToRemove
Remove-Item $FrameworkToRemovePath -Force

$ImportedPSGetModule = Import-Module -Name $script:PSModuleRoot -PassThru

if($ImportedPSGetModule)
{
    $script:PSModule.OnRemove = {
        Remove-Module -ModuleInfo $ImportedPSGetModule
    }
}