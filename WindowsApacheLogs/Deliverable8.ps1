#Put logs that contain 404 into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String " 404 "

#Regex for IP addresses
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

#Get IP addresses
$ipsUnorganized = $regex.Matches($notfounds)

#Organize into PSCustomObj
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value}
}
#Counting the IPs
$ipsoftens = $ips | Where-Object {$_.IP -ilike "10.*"}
$counts = $ipsoftens | Group-Object IP
$counts | Select Count, Name