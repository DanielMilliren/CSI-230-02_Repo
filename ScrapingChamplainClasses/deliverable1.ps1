. (Join-Path $PSScriptRoot GatherClasses.ps1)
. (Join-Path $PSScriptRoot daysTranslator.ps1)

$FullTable = daysTranslator (gatherClasses)
$FullTable | Select "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
    Where-Object { $_.Instructor -ieq "Furkan Paligu" }