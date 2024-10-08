<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

function checkPassword($password){

    #define checks:
    $all_letters      = "[a-zA-Z]"
    $all_specialchars = "[^a-zA-Z0-9]"
    $all_numbers      = "[0-9]"


    #SecureString has no methods for comparison, so it must be converted to string
    $passMem = [System.Runtime.InterOpServices.Marshal]::SecureStringToCoTaskMemUnicode($password)
    $passdecrypt = [System.Runtime.InterOpServices.Marshal]::PtrToStringUni($passMem)
    [System.Runtime.InterOpServices.Marshal]::ZeroFreeCoTaskMemUnicode($passMem)

    if(
        ($passdecrypt.Length -ge 6)             -and `
        ($passdecrypt -match $all_letters)      -and `
        ($passdecrypt -match $all_specialchars) -and `
        ($passdecrypt -match $all_numbers)
    ){
    
        return $true

    }
    else{
    
        return $false

    }

}