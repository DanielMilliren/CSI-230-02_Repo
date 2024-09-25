. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSSCriptRoot parseApacheLogs.ps1)

#Windows Apache Logs Lab
searchApacheResponses "/kpop" 404 Mozilla

#Parsing Apache Logs Lab
$logs = parseApacheLogs
$logs | Format-Table -AutoSize -Wrap
$logs.Client