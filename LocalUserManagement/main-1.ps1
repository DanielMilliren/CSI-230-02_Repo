. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Get At Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        if(checkUser $name){
            Write-Host "A user with that name already exists." | Out-String
        }
        elseif(checkPassword $password){

            createAUser $name $password

            Write-Host "User: $name is created." | Out-String
        }
        else{
            Write-Host "Password must be at least 6 chars long and have at least 1 letter, 1 num, and 1 special character"
        }
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        if(checkUser $name){
            
            removeAUser $name
            
            Write-Host "User: $name Removed." | Out-String
        }
        else{
            Write-Host "User does not exist." | Out-String
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if(checkUser $name){

            enableAUser $name

            Write-Host "User: $name Enabled." | Out-String
        }
        else{
            Write-Host "User does not exist." | Out-String
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        if(checkUser $name){
            
            disableAUser $name
            
            Write-Host "User: $name Disabled." | Out-String
        }
        else{
            Write-Host "User does not exist." | Out-String
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        if(checkUser $name){
        
            $userLogins = getLogInAndOffs 90 | where {$_.User.ToString().Split("\")[1] -eq $name}
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        
        }
        else{
            Write-Host "User does not exist." | Out-String
        }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        if(checkUser $name){
            $userLogins = getFailedLogins 90 | where {$_.User.ToString().Split("\")[1] -eq $name}
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
    }


    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    elseif($choice -eq 9){
    
        $num = Read-Host -Prompt "Please enter the number of days to look back through"
        if($num -match "[^0-9]"){
        
            Write-Host "Invalid input. Please input a positive integer."

        }
        else{
        
            Write-Host (getAtRiskUsers $num | Format-Table | Out-String)

        }
    
    }


    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    else{
    
        Write-Host "Invalid input. Pick one of the options again." | Out-String

    }

}




