#List just the entries that contain 404 or 400
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ', ' 400 '