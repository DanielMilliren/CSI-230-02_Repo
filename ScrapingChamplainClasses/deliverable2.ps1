. (Join-Path $PSScriptRoot GatherClasses.ps1)
. (Join-Path $PSScriptRoot daysTranslator.ps1)

$FullTable = daysTranslator (gatherClasses)
$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.Days -contains "Monday") } | `
    Sort-Object "Time Start" | Select "Time Start", "Time End", "Class Code"