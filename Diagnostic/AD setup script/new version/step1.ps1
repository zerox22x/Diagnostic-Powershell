$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$path = Join-Path -Path $scriptpath -ChildPath step2.ps1
$location = Join-Path -path $scriptpath -childpath log.txt
#set static IP address
#to make all of this automatic remove the read-host and fill in the values between ""

$ipaddress = read-host "192.168.0.254"
$ipprefix = read-host "24"
$ipgw = read-host "192.168.0.1" 
$ipdns = read-host "192.168.0.254"
#set adapter to edit
$NetAdaptersConnected = Get-NetAdapter | Where {$_.Status -eq "Up"}
$NetAdaptersConnected.Count
If ($NetAdaptersConnected.count){
Write-Host "type in the correct inferface number:"
$NetAdaptersConnected
$NetAdapterSelected = Read-Host "Digite o número da interface (ifIndex) que deseja utilizar"
}
else{
$NetAdapterSelected = $NetAdaptersConnected.ifIndex
New-NetIPAddress -IPAddress $ipaddress -PrefixLength $ipprefix -InterfaceIndex $ipif -DefaultGateway $ipgw
}
#rename the computer
$newname = read-host "sccm"
Rename-Computer -NewName $newname -force

#install roles and features
$featureLogPath = $location
New-Item $featureLogPath -ItemType file -Force
$addsTools = "RSAT-AD-Tools"

Add-WindowsFeature $addsTools -LogPath $featureLogPath
Get-WindowsFeature | Where installed >>$featureLogPath

#register next script step so it continues after reboot using register-scheduledjob
Register-ScheduledJob -Name config2 -FilePath $path -Trigger  @{Frequency="AtLogon"}
pause
#restart the computer
#Restart-Computer

