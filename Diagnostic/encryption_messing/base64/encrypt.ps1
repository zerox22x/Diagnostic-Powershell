$files = get-childitem "*.txt"
foreach ($file in $files) {
$fileName = "$file"
#$fileContent = get-content $fileName -raw | ConvertTo-SecureString -AsPlainText -Force|ConvertFrom-SecureString | Out-file $file
$filecontent = get-content $filename -raw
$fileContentBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)
$fileContentEncoded = [System.Convert]::ToBase64String(($fileContentBytes))
$fileContentEncoded | set-content ($fileName + ".b64")
}