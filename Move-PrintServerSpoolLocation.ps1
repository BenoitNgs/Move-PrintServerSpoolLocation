$SpoolRegKeyPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Print\Printers"
$SpoolRegKeyName = "DefaultSpoolDirectory"

$SpoolLocation = Get-ItemPropertyValue -Path $SpoolRegKeyPath -Name $SpoolRegKeyName
Write-Host "Old SPOOL location: $SpoolLocation"
$SpoolMoveLocation = "D:\spool\PRINTERS"

New-Item -Path $SpoolMoveLocation -ItemType "directory"

$ACL = Get-Acl -Path $SpoolLocation

Set-Acl -Path $SpoolMoveLocation -AclObject $ACL

Set-Itemproperty -path $SpoolRegKeyPath -Name $SpoolRegKeyName -Value $SpoolMoveLocation

Write-Host "New SPOOL location: $(Get-ItemPropertyValue -Path $SpoolRegKeyPath -Name $SpoolRegKeyName)"

Restart-Service -Name spooler