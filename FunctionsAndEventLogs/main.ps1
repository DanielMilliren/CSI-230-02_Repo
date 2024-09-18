. (Join-Path $PSScriptRoot "getLoginoutsFunc.ps1")
. (Join-Path $PSScriptRoot "getShutdownStartsFunc.ps1")

clear

$loginoutsTable = getUserLoginouts 15
$loginoutsTable

$shutstartTable = getShutdownsStartups 25
$shutstartTable