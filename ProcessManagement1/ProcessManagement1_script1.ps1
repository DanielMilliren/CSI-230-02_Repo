$ProcessList = Get-Process | Where-Object { $_.Name -ilike "C*" }
$ProcessList | Select Name, ID | Out-String