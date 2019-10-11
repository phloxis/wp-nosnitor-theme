[CmdletBinding()]
param(
	[string] $ThemesDirectory = 'C:\Program Files (x86)\Ampps\www\wp\wp-content\themes',
	[string] $ThemeName = 'Nosnitor',
	[string] $BuildOutput = "$PSScriptRoot/_Output",
	[switch] $Force
)

# Create build output
.\CreateThemePackage.ps1 -Force:$Force

#Remove existing
$ThemePath = "$ThemesDirectory/$ThemeName"
Remove-Item $ThemePath -Recurse -Force -ErrorAction SilentlyContinue
$OutputPath = "$BuildOutput/$($ThemeName.ToLower())"
Copy-Item $OutputPath $ThemesDirectory -Recurse