
$filecontent = @"

"@
    $fileName = get-random
    $fileName = $fileName + ".b64"
    $fileContentBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)
    $fileContentEncoded = [System.Convert]::ToBase64String(($fileContentBytes))
   $fileContentEncoded | set-content $fileName



