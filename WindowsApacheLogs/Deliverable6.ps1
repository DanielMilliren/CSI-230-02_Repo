#Get errors from all logs
$a = Get-Content C:\xampp\apache\logs\*.log | Select-String 'error'
#Output last 5 entries
$a[-1..-5]