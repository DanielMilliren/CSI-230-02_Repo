. (Join-Path $PSScriptRoot GatherClasses.ps1)
. (Join-Path $PSScriptRoot daysTranslator.ps1)

$FullTable = daysTranslator (gatherClasses)
$ITSInstructors = $FullTable | Where {  ($_."Class Code" -ilike "SYS*") -or `
                                        ($_."Class Code" -ilike "NET*") -or `
                                        ($_."Class Code" -ilike "SEC*") -or `
                                        ($_."Class Code" -ilike "FOR*") -or `
                                        ($_."Class Code" -ilike "CSI*") -or `
                                        ($_."Class Code" -ilike "DAT*") } `
                             | Sort-Object "Instructor" `
                             | Select Instructor -Unique

$ITSInstructors