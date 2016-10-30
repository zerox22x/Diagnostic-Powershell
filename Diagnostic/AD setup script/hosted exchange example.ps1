#### On the AD Server ####
New-ADOrganizationalUnit -Name Hosted

#### for Dalton.net ####
New-ADOrganizationalUnit -Name Dalton -Path "OU=Hosted,DC=Legend,DC=ICT"
Set-ADForest -Identity Legend.ICT -UPNSuffixes @{add="Dalton.net"}

#### for Insula .net ####
New-ADOrganizationalUnit -Name Insula  -Path "OU=Hosted,DC=Legend,DC=ICT"
Set-ADForest -Identity Legend.ICT -UPNSuffixes @{add="Insula .net"}

#### for PuisX.net ####
New-ADOrganizationalUnit -Name PuisX -Path "OU=Hosted,DC=Legend,DC=ICT"
Set-ADForest -Identity Legend.ICT -UPNSuffixes @{add="PuisX.net"}

####connect to remote exchange shell ####
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://exchange/PowerShell/ -Authentication Kerberos
Import-PSSession $Session


#### for Dalton.net ####
New-AcceptedDomain -Name "Dalton" -DomainName Dalton.net -DomainType:Authoritative
New-GlobalAddressList -Name "Dalton – GAL" -ConditionalCustomAttribute1 "Dalton" -IncludedRecipients MailboxUsers -RecipientContainer "Legend.ICT/Hosted/Dalton"
New-AddressList -Name "Dalton – All Rooms" -RecipientFilter "(CustomAttribute1 -eq 'Dalton') -and (RecipientDisplayType -eq 'ConferenceRoomMailbox')" -RecipientContainer "Legend.ICT/Hosted/Dalton"
New-AddressList -Name "Dalton – All Users" -RecipientFilter "(CustomAttribute1 -eq 'Dalton') -and (ObjectClass -eq 'User')" -RecipientContainer "Legend.ICT/Hosted/Dalton"
New-AddressList -Name "Dalton – All Contacts" -RecipientFilter "(CustomAttribute1 -eq 'Dalton') -and (ObjectClass -eq 'Contact')" -RecipientContainer "Legend.ICT/Hosted/Dalton"
New-AddressList -Name "Dalton – All Groups" -RecipientFilter "(CustomAttribute1 -eq 'Dalton') -and (ObjectClass -eq 'Group')" -RecipientContainer "Legend.ICT/Hosted/Dalton"
New-OfflineAddressBook -Name "Dalton" -AddressLists "Dalton – GAL"
New-EmailAddressPolicy -Name "Dalton – EAP" -RecipientContainer “Legend.ICT/Hosted/Dalton” -IncludedRecipients “AllRecipients” -ConditionalCustomAttribute1 "Dalton" -EnabledPrimarySMTPAddressTemplate “SMTP:%g.%s@Dalton.net”
New-AddressBookPolicy -Name "Dalton" -AddressLists "Dalton – All Users", "Dalton – All Contacts", "Dalton – All Groups" -GlobalAddressList "Dalton – GAL" -OfflineAddressBook "Dalton" -RoomList "Dalton – All Rooms"

#### for Insula.net ####
New-AcceptedDomain -Name "Insula" -DomainName Insula.net -DomainType:Authoritative
New-GlobalAddressList -Name "Insula – GAL" -ConditionalCustomAttribute1 "Insula" -IncludedRecipients MailboxUsers -RecipientContainer "Legend.ICT/Hosted/Insula"
New-AddressList -Name "Insula – All Rooms" -RecipientFilter "(CustomAttribute1 -eq 'Insula') -and (RecipientDisplayType -eq 'ConferenceRoomMailbox')" -RecipientContainer "Legend.ICT/Hosted/Insula"
New-AddressList -Name "Insula – All Users" -RecipientFilter "(CustomAttribute1 -eq 'Insula') -and (ObjectClass -eq 'User')" -RecipientContainer "Legend.ICT/Hosted/Insula"
New-AddressList -Name "Insula – All Contacts" -RecipientFilter "(CustomAttribute1 -eq 'Insula') -and (ObjectClass -eq 'Contact')" -RecipientContainer "Legend.ICT/Hosted/Insula"
New-AddressList -Name "Insula – All Groups" -RecipientFilter "(CustomAttribute1 -eq 'Insula') -and (ObjectClass -eq 'Group')" -RecipientContainer "Legend.ICT/Hosted/Insula"
New-OfflineAddressBook -Name "Insula" -AddressLists "Insula – GAL"
New-EmailAddressPolicy -Name "Insula – EAP" -RecipientContainer "Legend.ICT/Hosted/Insula" -IncludedRecipients “AllRecipients” -ConditionalCustomAttribute1 "Insula" -EnabledPrimarySMTPAddressTemplate “SMTP:%g.%s@Insula.net”
New-AddressBookPolicy -Name "Insula" -AddressLists "Insula – All Users", "Insula – All Contacts", "Insula – All Groups" -GlobalAddressList "Insula – GAL" -OfflineAddressBook "Insula" -RoomList "Insula – All Rooms"

#### for PuisX.net ####
New-AcceptedDomain -Name "PuisX" -DomainName PuisX.net -DomainType:Authoritative
New-GlobalAddressList -Name "PuisX – GAL" -ConditionalCustomAttribute1 "PuisX" -IncludedRecipients MailboxUsers -RecipientContainer "Legend.ICT/Hosted/PuisX"
New-AddressList -Name "PuisX – All Rooms" -RecipientFilter "(CustomAttribute1 -eq 'PuisX') -and (RecipientDisplayType -eq 'ConferenceRoomMailbox')" -RecipientContainer "Legend.ICT/Hosted/PuisX"
New-AddressList -Name "PuisX – All Users" -RecipientFilter "(CustomAttribute1 -eq 'PuisX') -and (ObjectClass -eq 'User')" -RecipientContainer "Legend.ICT/Hosted/PuisX"
New-AddressList -Name "PuisX – All Contacts" -RecipientFilter "(CustomAttribute1 -eq 'PuisX') -and (ObjectClass -eq 'Contact')" -RecipientContainer "Legend.ICT/Hosted/PuisX"
New-AddressList -Name "PuisX – All Groups" -RecipientFilter "(CustomAttribute1 -eq 'PuisX') -and (ObjectClass -eq 'Group')" -RecipientContainer "Legend.ICT/Hosted/PuisX"
New-OfflineAddressBook -Name "PuisX" -AddressLists "PuisX – GAL"
New-EmailAddressPolicy -Name "PuisX – EAP" -RecipientContainer "Legend.ICT/Hosted/PuisX" -IncludedRecipients “AllRecipients” -ConditionalCustomAttribute1 "PuisX" -EnabledPrimarySMTPAddressTemplate “SMTP:%g.%s@PuisX.net”
New-AddressBookPolicy -Name "PuisX" -AddressLists "PuisX – All Users", "PuisX – All Contacts", "PuisX – All Groups" -GlobalAddressList "PuisX – GAL" -OfflineAddressBook "PuisX" -RoomList "PuisX – All Rooms"


get-mailbox|set-mailbox -emailaddresspolicyenabled $false

Set-Mailbox user1@tenanta.com -CustomAttribute1 “TenantA”