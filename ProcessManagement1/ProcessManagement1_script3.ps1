$ProcessList = Get-Service | Where-Object { $_.Status -eq "Stopped" }
$ProcSort = $ProcessList | Sort-Object $_.Name
$ProcSort | Select Name, DisplayName, ServiceType, StartType, Status | Export-Csv -Path "StoppedServices.csv"