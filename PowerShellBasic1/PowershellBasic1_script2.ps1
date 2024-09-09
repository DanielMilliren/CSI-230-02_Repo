#Get IPv4 Prefix length from Ethernet0
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).PrefixLength