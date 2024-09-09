# Get IPv4 Address from Ethernet0
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" } ).IPAddress