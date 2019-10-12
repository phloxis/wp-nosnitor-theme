[CmdletBinding()]
param(
	[switch] $Force
)

# spin up docker container
Push-Location docker
#$env:COMPOSE_PROJECT_NAME="nosnitortheme"

## remove existing containers and volumes
docker-compose down -v

## build, create and start containers
docker-compose up -d --build

Pop-Location

# display logs
Write-Output "`r`n"

# wait until cli container stops
do {
	Write-Output "Waiting for wp-cli to finish..."
	Start-Sleep 1
}
until (((docker ps) -like "*nosnitortheme_cli_*").Length -eq 0)

$outlog = (docker logs nosnitortheme_cli_1)

# verify theme installed
if (($outlog -like "Success: Switched to 'Nosnitor' theme.").Length -eq 0) {
	Throw "It does not appear the Nosnitor theme was successfully installed."
}
Write-Host "wp-cli finished.`r`n"
Write-Verbose "wp-cli log:`r`n$($outlog | Out-String)"

# Verify site is running
try {
    $res = ([system.Net.WebRequest]::Create('http://localhost:8080')).GetResponse()
} 
catch [System.Net.WebException] {
    $res = $_.Exception.Response
}

if ([int]$res.StatusCode -eq 200) {
	Write-Host "WordPress is up, with Nosnitor theme at URL:`r`nhttp://localhost:8080"
} else {
	Throw "It does not appear that WordPress is running. $([int]$res.StatusCode):$($res.StatusCode)"
}