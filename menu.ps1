. (Join-Path $PSScriptRoot WindowsApacheLogs/parseApacheLogs.ps1)
. (Join-Path $PSScriptRoot LocalUserManagement/Event-Logs.ps1)

clear

$operate = $true

$prompt  = "Welcome to the main menu!`n"
$prompt += "1 - Parse and display past 10 Apache Logs`n"
$prompt += "2 - Display last 10 failed logins for all users`n"
$prompt += "3 - Display at risk users`n"
$prompt += "4 - Open or close Google Chrome`n"
$prompt += "5 - Exit"

while($operate){

    Write-Host $prompt
    $choice = Read-Host "Input"

    if($choice -eq 1){
    
        $apachelogs = (parseApacheLogs)[-1..-11]
        $apachelogs | Format-Table -AutoSize -Wrap
    
    }
    elseif($choice -eq 2){
    
        $numdays = Read-Host "How many days do you want to look back through?"
        if($numdays -match "[^0-9]"){
        
            Write-Host "The input must be an integer." | Out-String

        }
        else{

            $failedlogins = (getFailedLogins $numdays)
            $failedlogins[0..10] | Format-Table -AutoSize -Wrap

        }
    
    }
    elseif($choice -eq 3){
    
        $numdays = Read-Host "How many days do you want to look back through?"
        if($numdays -match "[^0-9]"){
        
            Write-Host "The input must be an integer." | Out-String

        }
        else{
            $atriskusers = (getAtRiskUsers $numdays)
            if($atriskusers.getType() -eq [System.String]){
                
                Write-Host $atriskusers
            
            }
            else{
        
                Write-Host $atriskusers[0..10] | Format-Table -AutoSize -Wrap

            }
        }
    }
    elseif($choice -eq 4){
    
        #This is the path of the script that launches Chrome 
        .(Join-Path $PSScriptRoot /ProcessManagement1/ProcessManagement1_script4.ps1)

    }
    elseif($choice -eq 5){
    
        $operate = $false
    
    }
    else{
    
        Write-Host "The input must be 1, 2, 3, 4, or 5."

    }

}
