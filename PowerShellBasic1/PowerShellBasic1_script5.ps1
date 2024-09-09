# Get DNS server IPs and display the first one only
(Get-DnsClientServerAddress -AddressFamily IPv4 | `
Where-Object { $_.InterfaceAlias -ilike "Ethernet0"} ).ServerAddresses[0]
