$folderpath = "$PSScriptRoot\outfolder"

if ( Get-Item $folderpath ) {
    Write-Host "Folder Already Exists"
}
else {
    New-Item -ItemType "directory" -Path $folderpath
}