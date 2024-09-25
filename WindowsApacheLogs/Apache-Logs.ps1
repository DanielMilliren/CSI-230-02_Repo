<#######################
searchApacheResponses($page,$code,$browser)
Inputs:
- $page   : The name of the webpage. Starts with a slash
- $code   : Numeric HTTP code.
- $browser: The name of the browser (i.e. "Chrome" or "Mozilla").
########################>

function searchApacheResponses($page,$code,$browser){
    $contents = Get-Content C:\xampp\apache\logs\access.log
    $results = @()

    for($i=0; $i -lt $contents.Count; $i++){
        $word = $contents[$i].Split(" ")
        $data = [pscustomobject]@{
        "ip" = $word[0];
        "test_page" = $word[6];
        "test_code" = $word[8];
        "test_browser" = $word[11].Split("/")[0].Trim('"')
        }

        $condition = ($code -ilike $data.test_code) -and ($page -clike $data.test_page) -and ($browser -ilike $data.test_browser)
        if($condition -and ($data.ip -ilike "10.*")){
            $results += $data.ip
        }

    }

    return $results

}