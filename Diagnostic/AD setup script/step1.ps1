$path = Join-Path -Path (Get-Location) -ChildPath step2.ps1
$location = Join-Path -path (Get-Location) -childpath log.txt
#set static IP address
#to make all of this automatic remove the read-host and fill in the values between ""
$ipaddress = read-host "this machines wanted ip"
$ipprefix = read-host "mask as subnet prefix"
$ipgw = Read-Host "gateway"
$ipdns = read-host "DNS set to self if setting up a new AD"
$ipif = (Get-NetAdapter).ifIndex
New-NetIPAddress -IPAddress $ipaddress -PrefixLength $ipprefix `
-InterfaceIndex $ipif -DefaultGateway $ipgw

#rename the computer
$newname = read-host "PCname"
Rename-Computer -NewName $newname -force

#install roles and features
$featureLogPath = $location
New-Item $featureLogPath -ItemType file -Force
$addsTools = "RSAT-AD-Tools"

Add-WindowsFeature $addsTools -LogPath $featureLogPath
Get-WindowsFeature | Where installed >>$featureLogPath

#register next script step so it continues after reboot using register-scheduledjob
Register-ScheduledJob -Name config2 -FilePath $path
pause
#restart the computer
Restart-Computer
# SIG # Begin signature block
# MIID3QYJKoZIhvcNAQcCoIIDzjCCA8oCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUYmQvMVtieFrdrNMYRL4SCHxa
# RI6gggIBMIIB/TCCAWqgAwIBAgIQPxYLyeSMdJhBE1oUTd2+zzAJBgUrDgMCHQUA
# MBIxEDAOBgNVBAMTB1J5ZXhhbmUwHhcNMTYwNjIzMjAxMDU3WhcNMzkxMjMxMjM1
# OTU5WjASMRAwDgYDVQQDEwdSeWV4YW5lMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCB
# iQKBgQC8/5x3oD+MtoqIKa8ocRauQwj3+f0yYBUFDXE3M5UloOPKZm0xxOFd0S1J
# RdgUo6CRJ08bZHb2QeJdB+ZCJ4USMiKIRywrNrNveqb7u8BvjvYQCSyk5cCG1JFJ
# o4Jdmzy3oKHRisRzqVrqIfKAImboFJDZ3RpP+fKyTnZ2zyHXwQIDAQABo1wwWjAT
# BgNVHSUEDDAKBggrBgEFBQcDAzBDBgNVHQEEPDA6gBBhh3qt22pTqCdvk36r2JFr
# oRQwEjEQMA4GA1UEAxMHUnlleGFuZYIQPxYLyeSMdJhBE1oUTd2+zzAJBgUrDgMC
# HQUAA4GBAEOlSKknPK1HlONMoWL31guA5lKvorRUY+WbNJai/r/I9vKYnk6UqPJc
# D9dcXxP1v/KAtiubCTvuC8TJxHuKfyfzm2XXZ3giczW3sinzI4L/5ys+v4J9FSCu
# CpI5eolGewKUQ7XCRe16WlSk+tkxOgBNdz4sD0WgWkpKZ++f1Vd5MYIBRjCCAUIC
# AQEwJjASMRAwDgYDVQQDEwdSeWV4YW5lAhA/FgvJ5Ix0mEETWhRN3b7PMAkGBSsO
# AwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEM
# BgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqG
# SIb3DQEJBDEWBBRSF4rxlRIVCD2maqRjfidmLS2kPzANBgkqhkiG9w0BAQEFAASB
# gEx802QXhAMWFbdVW7Sy13niyXfOthS64yUHSqZD2A6oiIGvIqI305m0R7024KE9
# KMJs5VgJbX2uOqrX97694k7SQ4mG7nyEhDR1AfkN2QcelgK8iVwGMCy8wlX3ehKE
# kvlJVnb5/gJQm4Yf3BHwhWAK6dolRGuE2jDs3Ev6nnXs
# SIG # End signature block
