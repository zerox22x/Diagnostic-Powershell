#paths
$source = Read-host "Type path to source"
$destination = read-host "path to destination"
#$source = Get-ChildItem -Path (Read-Host -Prompt 'type path to file or folder') |Out-string
#$destination = Get-ChildItem -Path (Read-Host -Prompt 'type destination , if it was a file enter filename aswell') | Out-string
New-Item $destination -type directory
set-location $source
$a = gci $source -recurse| Get-filehash
Start-Sleep -Milliseconds 300
#Copy-Item $source -Destination $destination -Recurse
#Import-Module BitsTransfer
#Start-BitsTransfer -Source $source -Destination $destination -Description "Backup" -DisplayName "Backup"
# robocopy from $source to destination , show eta , prompt for overwrite, /E copy everything including empty folders , 
robocopy $source $destination /E /ETA /R:0 /W:0
#xcopy $source $destination /E /-Y /L /v /Z
Start-Sleep -Milliseconds 300
set-location $destination
$B = Gci $destination -recurse | Get-FileHash

$result = Compare-Object $A $B |Select-Object -property Name
if ($result.Inputobject -like "*") {$results ; Write-host no output means all matches}