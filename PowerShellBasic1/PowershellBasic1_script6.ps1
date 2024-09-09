cd ~\CSI-230-02_Repo\PowerShellBasic1

$files = (ls (pwd) | Select Name)

for ($j=0; $j -le $files.Count; $j++) {
    
    if ($files[$j].Name -ilike "*.ps1") {
        
        Write-Host $files[$j].Name

    }
}