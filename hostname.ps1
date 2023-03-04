#To check the Hostname 
$env:COMPUTERNAME

# Prompt the user to enter the new hostname
$newHostname = Read-Host "Enter the new hostname"

# Set the new hostname
Rename-Computer -NewName $newHostname -Restart -Force

# Wait for 5 seconds before rebooting the system
Start-Sleep -Seconds 5
Restart-Computer -Force
