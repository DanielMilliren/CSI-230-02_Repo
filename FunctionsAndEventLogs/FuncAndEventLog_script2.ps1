#Get last 14 days of Login/Logoff records and save to a variable
$loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)
$loginoutsTable = @() #Empty array, will be filled via for loop

for($i=0; $i -lt $loginouts.Count; $i++) {
    
    $event = ""
    if($loginouts[$i].EventId -eq 7001){$event="Logon"}
    if($loginouts[$i].EventId -eq 7002){$event="Logoff"}

    $user=$loginouts[$i].ReplacementStrings[1]
    $loginoutsTable += [pscustomobject]@{
        "Time" = $loginouts[$i].TimeGenerated;
        "Id" = $loginouts[$i].EventId;
        "Event" = $event;
        "User" = $user
    }
#End of loop
}

$loginoutsTable