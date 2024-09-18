<#****************
getUserLoginouts
Input: # of days
Output: Returns a list of logins and logouts alongside the time and user
        for the past N days
******************#>
function getUserLoginouts($daynum) {
    $loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$daynum)
    $loginoutsTable = @() #Empty array, will be filled via for loop

    for($i=0; $i -lt $loginouts.Count; $i++) {
        $event = ""
        if($loginouts[$i].EventId -eq 7001){$event="Logon"}
        if($loginouts[$i].EventId -eq 7002){$event="Logoff"}

        $user=[System.Security.Principal.SecurityIdentifier](
            $loginouts[$i].ReplacementStrings[1]
        )
        #NTAccount handles names, SecurityIdentifier handles SIDs.
        $user=$user.Translate([System.Security.Principal.NTAccount]) 
        $loginoutsTable += [pscustomobject]@{
                            "Time" = $loginouts[$i].TimeGenerated;
                            "Id" = $loginouts[$i].EventId;
                            "Event" = $event;
                            "User" = $user
                            }
    #End of loop
    }
    return $loginoutsTable
}

getUserLoginouts 7