function gatherClasses() {

$page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses-1.html

#get all tr elements

$trs=$page.ParsedHtml.body.getElementsByTagName("tr")

#Declare an array to hold results
$FullTable=@()
for($i=0;$i -lt $trs.length;$i++){

    #get td elements of current tr
    $tds=$trs[$i].getElementsByTagName("td")

    #Split start and end times into different fields
    $Times=$tds[5].innerText.Split("-")

    #Construct Table
    $FullTable += [pscustomobject]@{
        "Class Code" = $tds[0].innerText; `
        "Title"      = $tds[1].innerText; `
        "Days"       = $tds[4].innerText; `
        "Time Start" = $Times[0]; `
        "Time End"   = $Times[1]; `
        "Instructor" = $tds[6].innerText; `
        "Location"   = $tds[9].innerText; `
    }

}

return $FullTable

}