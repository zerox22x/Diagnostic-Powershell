#paths
$source = "E:\versionrecall\VersionRecall Repositories"

$destination = "E:\versionrecall\test"
New-Item $destination -type directory

$files = gci -path $source -recurse
$A = $files|Get-filehash 
Start-Sleep -Milliseconds 300
#Copy-Item $source -Destination $destination -Recurse
#Import-Module BitsTransfer
#Start-BitsTransfer -Source $source -Destination $destination -Description "Backup" -DisplayName "Backup"
#robocopy  $source  $destination /X
xcopy $source $destination /E /-Y /L /v /Z
Start-Sleep -Milliseconds 300
$target = $destination
$files2 = gci -path $target -recurse
$B = $files2|Get-filehash 

$result = Compare-Object $A $B |Select-Object -property *
if ($result.Inputobject -like "*") {$results ; Write-host no output means all matches}