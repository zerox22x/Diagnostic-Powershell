#cd $PSScriptRoot
$files = Get-childitem *.b64
foreach ($file in $files) {
	$data = Get-content $file
	[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($data)) |Out-file "$file.ps1"
}
$script = Get-Content *.ps1.b64.ps1 |Invoke-Expression
