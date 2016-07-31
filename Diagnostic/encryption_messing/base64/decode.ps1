#cd $PSScriptRoot
$files = Get-childitem *.b64

foreach ($file in $files) {
	$data = Get-content $file
	$name = Get-Random
	$decode = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($data)) |Out-file "$name.ps1"
	$ScriptPath = Split-Path $MyInvocation.InvocationName
	& "$ScriptPath\$name.ps1"
	#remove-item -path .\$name.ps1
}

