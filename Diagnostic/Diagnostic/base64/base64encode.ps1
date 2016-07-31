write-host $PSScriptRoot
$files = get-childitem "*.txt"
foreach ($file in $files) {
$fileName = "$file"
$fileContent = get-content $fileName
$fileContentBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)
$fileContentEncoded = [System.Convert]::ToBase64String(($fileContentBytes))
$fileContentEncoded | set-content ($fileName + ".b64")}