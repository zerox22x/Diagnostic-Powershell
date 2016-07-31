$files = ls | where-object {$_.Name -like '*.ps1'}|Select-object Name | Out-String
foreach ($file in $files) {
$temp = Get-Content $file
$content = [System.Text.Encoding]::UTF8.GetBytes($temp)
$encode = [System.Convert]::ToBase64String($content)

Set-Content ($file + ".b64") "$encode"}
