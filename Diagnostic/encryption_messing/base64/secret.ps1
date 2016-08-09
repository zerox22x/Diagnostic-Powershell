#$x holds the encoded script in a here-string
$x = @"
Z2V0LXByb2Nlc3MgfCBPdXQtR3JpZFZpZXcgLVBhc3NUaHJ1IC1WZXJib3Nl
"@
#call the .net framework for encoding and converting , point it to the here string ($x)
$decode = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($x))
#write decoded text to screen and pause (so i can check if it decoded right)
write-host $decode
pause
#convert string to a scriptblock so i can use it,point it to $x wich now has the decoded string
$scriptBlock = [Scriptblock]::Create($decode)
# execute it
Invoke-Command -scriptblock $scriptblock