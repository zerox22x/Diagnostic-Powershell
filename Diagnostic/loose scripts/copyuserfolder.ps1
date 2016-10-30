#paths
$source = Read-host "Type path to source"
$destination = read-host "path to destination"
#create target incase it doesnt exist , trhows a error if it does but will continue execution
New-Item $destination -type directory
#set location back to source
set-location $source
$a = gci $source -recurse| Get-filehash # grab filehashes for all files in the directory and sub directory
Start-Sleep -Milliseconds 300 # sleep for 0.3 seconds to let the filehandles close
# robocopy from $source to destination , show eta , prompt for overwrite, /E copy everything including empty folders , 
robocopy $source $destination /E /ETA /R:0 /W:0
Start-Sleep -Milliseconds 300 # let it close the file handles
set-location $destination # set locaiton to destination
$B = Gci $destination -recurse | Get-FileHash # run hash check and put it in variable $b
#compare $a and $b , if no output it means it copies succesfully (write no output means all match)
$result = Compare-Object $a $b |Select-Object -property Name
if ($result.Inputobject -like "*") {$results ; Write-host no output means all matches}