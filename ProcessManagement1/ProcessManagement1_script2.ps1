$ProcessList = Get-Process | Where-Object { -not ($_.Path -ilike "*system32*") }
$ProcessList | Select Name, ID, Path | Out-String