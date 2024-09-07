$chromeProcess = Get-Process | Where-Object { $_.name -ieq "chrome" }
if ( $null -eq $chromeProcess ) 
{
    Start-Process -FilePath "C:/Program Files/Google/Chrome/Application/chrome.exe" -ArgumentList "--new-window https://champlain.edu"
    Write-Output "Chrome started and sent to champlain.edu"
} 
else 
{ 
    $chromeProcess.Kill()
    Write-Output "Chrome process killed"
} 