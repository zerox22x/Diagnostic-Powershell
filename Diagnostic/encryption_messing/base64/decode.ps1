#grab all .b64 file names
$files = Get-childitem *.b64
#for each item that has .b64 as extension , read the file , generate a random number as filename, convert $data contents into readeble text , save it as $name.ps1, set the folder correctly , execute decoded script
foreach ($file in $files) {
	$data = Get-content $file
	$name = Get-Random
	$decode = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($data)) |Out-file "$name.ps1"
	$ScriptPath = Split-Path $MyInvocation.InvocationName
	& "$ScriptPath\$name.ps1"
	#remove-item -path .\$name.ps1
}

