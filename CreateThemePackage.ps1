<#

    .SYNOPSIS
	
	Creates a package of this theme that can be uploaded to a WordPress site.
	
#>

[CmdletBinding()]
param(
	[string] $ThemeName = 'Nosnitor',
	[string] $ThemeDir = "$PSScriptRoot\src",
	[string] $StyleCss = "$ThemeDir/style.css",
	[string] $OutputDir = "$PSScriptRoot\_Output",
	[switch] $Force
)

# Execute
$ErrorActionPreference = "Stop"

## Write Arguments
Write-Verbose "ThemeName : $ThemeName"
Write-Verbose "ThemeDir  : $ThemeDir"
Write-Verbose "StyleCss  : $StyleCss"
Write-Verbose "OutputDir : $OutputDir"
Write-Verbose "Force     : $Force"


## Verify necessary components

### 7-zip
if (-not (test-path "$env:ProgramFiles/7-Zip/7z.exe")) {throw "$env:ProgramFiles/7-Zip/7z.exe needed"} 
Write-Verbose "7zip      : $env:ProgramFiles/7-Zip/7z.exe"
set-alias sz "$env:ProgramFiles/7-Zip/7z.exe"  

## Get version number
$styleCssContent = [IO.File]::ReadAllText($StyleCss)
$versionIsMatch = $styleCssContent -match '(?sm)Version:\s(\d\.\d(\.\d)?)'
if (!($versionIsMatch -eq $TRUE)) { 
	Write-Verbose "$StyleCss`r`n$styleCssContent"
	throw "Could not determine theme version from style file: $StyleCss" 
}
$version = $Matches[1]
Write-Verbose "Version   : $version"

## Create build output
### Remove output if exist
if (Test-Path $OutputDir) {
	Get-ChildItem -Path $OutputDir -Force -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse
	Remove-Item $OutputDir -Force
}

### Copy content
New-Item -ItemType Directory -Path $OutputDir -ErrorAction SilentlyContinue
$buildOutput = "$OutputDir/$($ThemeName.ToLower())/"
Copy-Item -Path $ThemeDir -Recurse -Destination $buildOutput -Container

### Create ZIP file
$rootPath = "$buildOutput"
$destinationPath = "$PSScriptRoot/$ThemeName.$version.zip"

if (Test-Path $destinationPath) {
  if ($Force -eq $TRUE) {
	Remove-Item -Path $destinationPath -Force
  } else {
    throw "The package already exists. Please move or delete the file, or execute this command with the -Force argument."
  }
}

sz a -mx=9 $destinationPath $rootPath
