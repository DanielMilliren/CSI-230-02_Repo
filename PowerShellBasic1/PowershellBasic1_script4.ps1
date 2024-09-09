# Get the DHCP server's IP address and hide table headers
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPServer like '%.%'" | select DHCPServer | Format-Table -HideTableHeaders