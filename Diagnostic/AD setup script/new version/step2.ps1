
# make sure we run as admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"; Start-Process $($PSHOME)\powershell.exe -Verb runAs -ArgumentList $arguments; Break }
#Install AD DS, DNS and GPMC
$path = Get-location
$featureLogPath = $path + "log.txt"
start-job -Name addFeature -ScriptBlock {
  Add-WindowsFeature -Name "ad-domain-services" -IncludeAllSubFeature -IncludeManagementTools                                                                  
  Add-WindowsFeature -Name "dns" -IncludeAllSubFeature -IncludeManagementTools                                    
  Add-WindowsFeature -Name "gpmc" -IncludeAllSubFeature -IncludeManagementTools   }
Wait-Job -Name addFeature
Get-WindowsFeature | Where installed >>$featureLogPath
# Create New Forest, add Domain Controller
$domainname = read-host "type in a qualified domain name"
$netbiosName = read-host "type in a valid netbiosname"
Add-WindowsFeature  -IncludeManagementTools dhcp
netsh dhcp add securitygroups

  Import-Module ADDSDeployment
  Install-ADDSForest -CreateDnsDelegation:$false `
   -DatabasePath "C:\Windows\NTDS" `
   -DomainMode "Win2012" `
   -DomainName $domainname `
   -DomainNetbiosName $netbiosName `
   -ForestMode "Win2012" `
   -InstallDns:$true `
   -LogPath "C:\Windows\NTDS" `
   -NoRebootOnCompletion:$false `
   -SysvolPath "C:\Windows\SYSVOL" `
   -Force:$true 

Write-host "Script Started"
Unregister-ScheduledJob -Name config2
pause
# SIG # Begin signature block
# MIID3QYJKoZIhvcNAQcCoIIDzjCCA8oCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU+zOumJaYQtXSTjG6ScIDYYFW
# KvKgggIBMIIB/TCCAWqgAwIBAgIQPxYLyeSMdJhBE1oUTd2+zzAJBgUrDgMCHQUA
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
# SIb3DQEJBDEWBBSULf95uSBe0IW8Dtuz2/yw0tJaoDANBgkqhkiG9w0BAQEFAASB
# gD69RY09OJQeWaQfnJ9feR+NNHFrKpwLC2dFgQzpA0t8lLAbJr52C8FJmZ/BlSIT
# MNQWLQ7bX7BhJkHs7Scr9qXQjPAwD6cCq2MTK4KFiT0NfoRFFOY2laV2hDHPBmrZ
# hsj22KJ4jq3OQbfPLh/TlVLAhEpWtIS7JpaSl+NiVbfD
# SIG # End signature block
