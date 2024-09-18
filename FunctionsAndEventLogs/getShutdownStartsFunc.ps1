<#****************
getShutdownsStartups
Input: Past # of days
Output: Table for shutdowns and starts for past n days
******************#>
function getShutdownsStartups($daynum){
    $shutdownstartups = Get-EventLog System -Source EventLog -After (Get-Date).AddDays(-$daynum)
    $shutdownTable = @()

    for($i=0; $i -lt $shutdownstartups.Count; $i++){
        $event=""
        if($shutdownstartups[$i].EventId -eq 6005){$event="Startup"}
        if($shutdownstartups[$i].EventId -eq 6006){$event="Shutdown"}

        #condition here to only add Startups and Shutdowns to output table
        if($event -ne ""){
            $shutdownTable += [pscustomobject]@{
                "Time" = $shutdownstartups[$i].TimeGenerated;
                "Id" = $shutdownstartups[$i].EventId;
                "Event" = $event;
                "User" = "System"
            }
        }
    }
    return $shutdownTable
}

getShutdownsStartups 7