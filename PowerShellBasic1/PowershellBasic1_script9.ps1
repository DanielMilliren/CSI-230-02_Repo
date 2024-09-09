$files=ls -Recurse -File
$files | Rename-Item -NewName { $_.Extension -replace ".csv", ".log" }
ls -Recurse -File