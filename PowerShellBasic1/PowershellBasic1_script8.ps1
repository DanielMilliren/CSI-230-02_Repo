cd $PSScriptRoot
$files = (ls)
$folderpath = "$PSScriptRoot/outfolder"
$filepath = Join-Path $folderpath "out.csv"

$files | Where-Object { $_.Extension -eq ".ps1" } | Export-Csv -Path $filepath
