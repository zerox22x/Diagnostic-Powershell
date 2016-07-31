$files = get-childitem "*.txt"
#for each item get-childitem "*.txt" returns , set file name as original , load the contents in $filecontent, modify the filename to $originalname.b64 , encode the contents and save it as $filename
foreach ($file in $files) {
$fileName = "$file"
#$fileContent = get-content $fileName -raw | ConvertTo-SecureString -AsPlainText -Force|ConvertFrom-SecureString | Out-file $file
$filecontent = get-content $filename -raw
$filename = $filename + ".b64"
$filename = $filename -replace ".txt.b64",".b64"
$fileContentBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)
$fileContentEncoded = [System.Convert]::ToBase64String(($fileContentBytes))
$fileContentEncoded | set-content $filename
}