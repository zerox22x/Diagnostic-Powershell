#Requires -Version 3.0

Start-Transcript -path log.txt
#$DebugPreference = "Continue"
#$VerbosePreference = "Continue"
#$ErrorActionPreference = "Continue"
Write-Debug "past requires means we are runnign on v3 or higher"
Get-ExecutionPolicy | Out-Default
Set-ExecutionPolicy -Scope Process -ExecutionPolicy remotesigned
Get-ExecutionPolicy | Out-Default
$error1 = $error[0]
$temp
#----------------------------------------------
#region Application Functions
#----------------------------------------------

#endregion Application Functions

#----------------------------------------------
# Generated Form Function
#----------------------------------------------
function Call-event_psf {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.ServiceProcess, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	Write-Debug "assemblies loaded"
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formEventLogSearch = New-Object 'System.Windows.Forms.Form'
	$button1 = New-Object 'System.Windows.Forms.Button'
	$button2 = New-Object 'System.Windows.Forms.Button'
	$buttonIpconfig = New-Object 'System.Windows.Forms.Button'
	$buttonPing = New-Object 'System.Windows.Forms.Button'
	$buttonInstalledPrograms = New-Object 'System.Windows.Forms.Button'
	$buttonFirewallStatus = New-Object 'System.Windows.Forms.Button'
	$buttonAbout = New-Object 'System.Windows.Forms.Button'
	$buttonclearapplog = New-Object 'System.Windows.Forms.Button'
	$buttonSave = New-Object 'System.Windows.Forms.Button'
	$buttonList = New-Object 'System.Windows.Forms.Button'
	$buttonhttpcheck = New-Object 'System.Windows.Forms.Button'
	$buttonpathping = New-Object 'System.Windows.Forms.Button'
	$richtextbox1 = New-Object 'System.Windows.Forms.RichTextBox'
	$buttonSearch = New-Object 'System.Windows.Forms.Button'
	$buttonlistdrive = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	Write-Debug "All objects added"
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------


	$formEventLogSearch_Load = {
		#TODO: Initialize Form Controls here
		# Test admin state
		function Test-IsAdmin {([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
		}
		$admin = Test-IsAdmin
		if ($admin -eq "True") {
		{
			$richtextbox1.AppendText("Running With administrator permissions`n")
			write-debug "running with admin rights event clear enabled"
			}
		}
		else {
				$richtextbox1.AppendText("Running Without administrator permissions , Event log clear disabled`n")
				$buttonclearapplog.Enabled = $false;
				write-debug "running without admin right , event clear disabled"
				}
		$buttonSave.Enabled = $false;
		# Get current location
		$itemlocation = Get-Location
		$itemlocation = $itemlocation -replace "Path", "".Replace("---", "") | Out-String
		$richtextbox1.AppendText("Current location is $itemlocation")
		write-debug -message $itemlocation
		# Get windows version and add it to the box
		$windowsname = (Get-WmiObject win32_operatingsystem).caption | Out-String
		$richtextbox1.AppendText("`n")
		$richtextbox1.AppendText("$windowsname")
		write-debug -message $windowsname
		$Error.Clear()
		# Grab all users and display them
		$users = Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount='True'" | Select PSComputername, Name, AccountType|Format-table -Wrap|Out-String
		$richtextbox1.AppendText("$users`n")
		write-debug $users
		#Get bit version of windows
		$richtextbox1.Appendtext("bit mode is $env:Processor_Architecture`n")
		# check for internet connectivity
		write-debug "checking network connection , may take a few seconds"
		ipconfig /flushdns
		$dns = Test-Connection -Quiet www.google.com
		if ($dns -ne "True")
			{$richtextbox1.appendtext("DNS not availeble`n")
			}
			else
			{$richtextbox1.Appendtext("DNS Functioning`n")
			}
		$ip = Test-Connection -Quiet 8.8.8.8
		if ($ip -ne "True")
			{$richtextbox1.Appendtext("Ip Adress not reacheble`n")
			}
			else
			{$richtextbox1.AppendText("IP Addressing availeble`n")
			}
		write-debug "Initalization done"
		
		}


	$buttonSearch_Click = {
		. ".\Eventlogsearch.ps1"
	}


	$richtextbox1_TextChanged = {
		#fires everytime text is added to the textbox , always scroll down and clear any errors that may have occured
		$richtextbox1.ScrollToCaret();
		if ($Error.Count -eq "0") { $buttonSave.Enabled = $true; }
		if ($Error.Count -ne "0") { $richtextbox1.AppendText("$Error1") }
		$Error.Clear()
		[gc]::Collect()
		write-debug "Text changed in text box"

}
		

	$buttonclearapplog_Click = 	{
		. ".\clearapplog.ps1"
		
		}
	$buttonList_Click = {
			. ".\eventlist.ps1"

		}

		$buttonSave_Click = {
			#Save current contents in $richtextbox1 to a file with spacing and enters intact
			$richtextbox1.Lines |Format-List| Out-File results.txt
			#write-debug Save Button was clicked
			#write-debug $error
		}
		$buttonAbout_Click = 		{
			#Shows Running windows version and build number aswell as powershell version
			$richtextbox1.AppendText("`n----------About information-----")
			$psversion = Get-Host | Out-String
			$windowsname = (Get-WmiObject win32_operatingsystem).caption | Out-String
			$windowsbuild = (Get-WmiObject win32_operatingsystem).version | Out-String
			#[void][reflection.assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
			#[void][System.Windows.Forms.MessageBox]::Show("Event Log Search tool by Collin Bakker , v1, running on $psversion,$windowsname,$windowsbuild", "Caption")
			$richtextbox1.AppendText("`nEvent Log Search tool by Collin Bakker , v1, `n running on $psversion,$windowsname,$windowsbuild")
			#write-debug $psversion,$windowsname,$windowsbuild
			write-debug "About button was clicked"
			#write-debug $Error
		}
		$buttonlistdrive_Click = {
			# Lists drives , uses math shenanigans to get to GB rather then bytes
			$drives = Get-PSDrive -PSProvider FileSystem |Format-Table -Wrap -AutoSize -Property Root, @{Name="UsedGB";Expression={[math]::round($_.used/1GB,2)}}, @{Name="FreeGB";Expression={[math]::round($_.free/1GB,2)}}, Description | Out-String
			$richtextbox1.AppendText("--------- Local Drives -------")
			$richtextbox1.AppendText("`n")
			$richtextbox1.AppendText("$drives")
			#write-debug $drives
			#rite-debug List drives was clicked
			#write-debug $Error
		}

		$formEventLogSearch_FormClosing = [System.Windows.Forms.FormClosingEventHandler]{
			#Event Argument: $_ = [System.Windows.Forms.FormClosingEventArgs]
			#only removes the updatelog.loc generated by the windows update button
			if ((Test-Path $env:temp\UpdateLog.log)) {
						Remove-Item -Path $env:temp\UpdateLog.log
					}

				}



				$formMain_FormClosed = [System.Windows.Forms.FormClosedEventHandler]{
					#Event Argument: $_ = [System.Windows.Forms.FormClosedEventArgs]


				}

				$buttonFirewallStatus_Click = {
					#Grabs firewall status and displays it
					$richtextbox1.AppendText("-------- Firewall Status -------")
					$richtextbox1.AppendText("`n")
					$firewall = Get-NetFirewallProfile | Format-table -Property Name, Enabled |Out-String
					$richtextbox1.AppendText("$firewall")
					#write-debug $firewall
					write-debug "Firewall button was clicked"
					#write-debug $error
				}



				$buttonInstalledPrograms_Click = {
					. ".\Installedprograms.ps1"
					}
			

				$buttonPing_Click = {
					. ".\ping.ps1"
				}

				$buttonIpconfig_Click = {
					. ".\ipconfig.ps1"
				}

				$button1_Click =  {
					
					. ".\windowsupdatelogs.ps1"

				}

				$button2_Click = {
					<#Grabs all running procceses and services , has an issue with too much white space
					$richtextbox1.AppendText("------- Running processes -------")
					$processes = Get-Process| Format-Table -property Name,ID,path |Out-string
					$richtextbox1.AppendText("`n")
					$richtextbox1.AppendText("$Processes")
					#$richtextbox1.AppendText("`n---------Services------")
					#$services = Get-Service|Sort-Object -Property Status |Format-table -Property Status,DisplayName |Out-String
					#$richtextbox1.AppendText("`n$services")
					#write-debug "Services was clicked"
					write-debug $error
			#>	
			. ".\processes.ps1"
			}
                $buttonhttpcheck_Click = {
				. ".\httpcheck.ps1"
				}

				$buttonpathping_Click = {
								[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
            					$sites = [Microsoft.VisualBasic.Interaction]::InputBox("Enter a Website`n", "Computer", "www.google.com")
								$richtextbox1.Appendtext("This may take some time")
								#foreach ($Site in $sites) {$temp = pathping $site -q 10 | Out-string
								$temp = pathping $sites -q 5 |Tee-object -Variable temp|Out-Gridview
								$richtextbox1.Appendtext("$temp")
                }
				# --End User Generated Script--
				#----------------------------------------------
				#region Generated Events
				#----------------------------------------------

				$Form_StateCorrection_Load = 
				{
					#Correct the initial state of the form to prevent the .Net maximized form issue
					$formEventLogSearch.WindowState = $InitialFormWindowState
				}

				$Form_Cleanup_FormClosed = 
				{
					#Remove all event handlers from the controls
					try
					{
						$button1.remove_Click($button1_Click)
						$button2.remove_Click($button2_Click)
						$buttonIpconfig.remove_Click($buttonIpconfig_Click)
						$buttonclearapplog.remove_Click($buttonclearapplog_Click)
						$buttonPing.remove_Click($buttonPing_Click)
						$buttonInstalledPrograms.remove_Click($buttonInstalledPrograms_Click)
						$buttonFirewallStatus.remove_Click($buttonFirewallStatus_Click)
						$buttonAbout.remove_Click($buttonAbout_Click)
						$buttonSave.remove_Click($buttonSave_Click)
						$buttonList.remove_Click($buttonList_Click)
						$richtextbox1.remove_TextChanged($richtextbox1_TextChanged)
						$buttonSearch.remove_Click($buttonSearch_Click)
						$buttonlistdrive.remove_Click($buttonlistdrive_Click)
						$buttonhttpcheck.remove_Click($buttonhttpcheck_Click)
						$buttonpathping.remove_Click($buttonpathping_Click)
                        $formEventLogSearch.remove_FormClosing($formEventLogSearch_FormClosing)
						$formEventLogSearch.remove_FormClosed($formMain_FormClosed)
						$formEventLogSearch.remove_Load($formEventLogSearch_Load)
						$formEventLogSearch.remove_Load($Form_StateCorrection_Load)
						$formEventLogSearch.remove_FormClosed($Form_Cleanup_FormClosed)
                        
					}
					catch [Exception]
					{					}
				}


				#endregion Generated Events

				#----------------------------------------------
				#region Generated Form Code
				#----------------------------------------------
				$formEventLogSearch.SuspendLayout()
				#
				# formEventLogSearch
				#
				$formEventLogSearch.Controls.Add($button1)
				$formEventLogSearch.Controls.Add($button2)
				$formEventLogSearch.Controls.Add($buttonIpconfig)
				$formEventLogSearch.Controls.Add($buttonPing)
				$formEventLogSearch.Controls.Add($buttonInstalledPrograms)
				$formEventLogSearch.Controls.Add($buttonFirewallStatus)
				$formEventLogSearch.Controls.Add($buttonAbout)
				$formEventLogSearch.Controls.Add($buttonSave)
				$formEventLogSearch.Controls.Add($buttonList)
				$formEventLogSearch.Controls.Add($richtextbox1)
				$formEventLogSearch.Controls.Add($buttonSearch)
				$formEventLogSearch.Controls.Add($buttonlistdrive)
				$formEventLogSearch.Controls.Add($buttonclearapplog)
                $formEventLogSearch.Controls.Add($buttonhttpcheck)
				$formEventLogSearch.Controls.Add($buttonpathping)
				$formEventLogSearch.ClientSize = '1600, 900'
				$formEventLogSearch.Name = "formEventLogSearch"
				$formEventLogSearch.Text = "Event Log Search"
				$formEventLogSearch.add_FormClosing($formEventLogSearch_FormClosing)
				$formEventLogSearch.add_FormClosed($formMain_FormClosed)
				$formEventLogSearch.add_Load($formEventLogSearch_Load)
			
				#
				# button1
				#
				$button1.Location = '275, 12'
				$button1.Name = "Windows Update log"
				$button1.Size = '120, 23'
				$button1.TabIndex = 9
				$button1.Text = "Windows Update Log"
				$button1.UseVisualStyleBackColor = $True
				$button1.add_Click($button1_Click)
				#
				#processes
				$button2.Location = '775, 12'
				$button2.Name = "processes"
				$button2.Size = '75, 23'
				$button2.TabIndex = 9
				$button2.Text = "processes"
				$button2.UseVisualStyleBackColor = $True
				$button2.add_Click($button2_Click)
				#
				# buttonIpconfig
				#
				$buttonIpconfig.Location = '700, 12'
				$buttonIpconfig.Name = "buttonIpconfig"
				$buttonIpconfig.Size = '75, 23'
				$buttonIpconfig.TabIndex = 8
				$buttonIpconfig.Text = "ipconfig"
				$buttonIpconfig.UseVisualStyleBackColor = $True
				$buttonIpconfig.add_Click($buttonIpconfig_Click)
				#
				# buttonPing
				#
				$buttonPing.Location = '620, 12'
				$buttonPing.Name = "buttonPing"
				$buttonPing.Size = '75, 23'
				$buttonPing.TabIndex = 7
				$buttonPing.Text = "Ping"
				$buttonPing.UseVisualStyleBackColor = $True
				$buttonPing.add_Click($buttonPing_Click)
				#
				# buttonInstalledPrograms
				#
				$buttonInstalledPrograms.Location = '500, 12'
				$buttonInstalledPrograms.Name = "buttonInstalledPrograms"
				$buttonInstalledPrograms.Size = '111, 23'
				$buttonInstalledPrograms.TabIndex = 6
				$buttonInstalledPrograms.Text = "Installed programs"
				$buttonInstalledPrograms.UseVisualStyleBackColor = $True
				$buttonInstalledPrograms.add_Click($buttonInstalledPrograms_Click)
				#
				# buttonFirewallStatus
				#
				$buttonFirewallStatus.Location = '400, 12'
				$buttonFirewallStatus.Name = "buttonFirewallStatus"
				$buttonFirewallStatus.Size = '95, 23'
				$buttonFirewallStatus.TabIndex = 5
				$buttonFirewallStatus.Text = "Firewall Status"
				$buttonFirewallStatus.UseVisualStyleBackColor = $True
				$buttonFirewallStatus.add_Click($buttonFirewallStatus_Click)
				#
				# buttonAbout
				#
				$buttonAbout.Location = '1073, 12'
				$buttonAbout.Name = "buttonAbout"
				$buttonAbout.Size = '75, 23'
				$buttonAbout.TabIndex = 4
				$buttonAbout.Text = "About"
				$buttonAbout.UseVisualStyleBackColor = $True
				$buttonAbout.add_Click($buttonAbout_Click)
				#
				# buttonSave
				#
				$buttonSave.Location = '180, 12'
				$buttonSave.Name = "buttonSave"
				$buttonSave.Size = '75, 23'
				$buttonSave.TabIndex = 3
				$buttonSave.Text = "Save"
				$buttonSave.UseVisualStyleBackColor = $True
				$buttonSave.add_Click($buttonSave_Click)
				#
				# buttonList
				#
				$buttonList.Location = '90, 12'
				$buttonList.Name = "buttonList"
				$buttonList.Size = '75, 23'
				$buttonList.TabIndex = 2
				$buttonList.Text = "List"
				$buttonList.UseVisualStyleBackColor = $True
				$buttonList.add_Click($buttonList_Click)
				#
				# richtextbox1
				#
				$richtextbox1.Location = '12, 500'
				$richtextbox1.Name = "richtextbox1"
				$richtextbox1.Size = '1500, 400'
				$richtextbox1.TabIndex = 1
				$richtextbox1.Text = ""
				$richtextbox1.add_TextChanged($richtextbox1_TextChanged)
				$richtextbox1.font = "Courier new,12"
				
				$richtextbox1.anchor = [System.Windows.Forms.AnchorStyles]::Top `
				-bor [System.Windows.Forms.AnchorStyles]::Left `
				-bor [System.Windows.Forms.AnchorStyles]::Right `
				-bor [System.Windows.Forms.AnchorStyles]::Bottom

				#
				# buttonSearch
				#
				$buttonSearch.Location = '10, 12'
				$buttonSearch.Name = "buttonSearch"
				$buttonSearch.Size = '75, 23'
				$buttonSearch.TabIndex = 0
				$buttonSearch.Text = "Search"
				$buttonSearch.UseVisualStyleBackColor = $True
				$buttonSearch.add_Click($buttonSearch_Click)
				$formEventLogSearch.ResumeLayout()
				#$buttonlistdrive
				$buttonlistdrive.location = '998, 12'
				$buttonlistdrive.Name = "list drives"
				$buttonlistdrive.Size = '75, 23'
				$buttonlistdrive.TabIndex = 5
				$buttonlistdrive.Text = "list drives"
				$buttonlistdrive.UseVisualStyleBackColor = $True
				$buttonlistdrive.add_Click($buttonlistdrive_Click)
				#
				#
				#eventlog clear $buttonclearapplog
				$buttonclearapplog.Location = '920, 12'
				$buttonclearapplog.Name = "eventclear"
				$buttonclearapplog.Size = '75, 23'
				$buttonclearapplog.Text = "event clear"
				$buttonclearapplog.UseVisualStyleBackColor = $True
				$buttonclearapplog.add_Click($buttonclearapplog_Click)
                				#
				#
				#eventlog clear $buttonhttpcheck
				$buttonhttpcheck.Location = '850, 12'
				$buttonhttpcheck.Name = "Htpp Check"
			    $buttonhttpcheck.Size = '75, 23'
				$buttonhttpcheck.Text = "Http Check"
				$buttonhttpcheck.UseVisualStyleBackColor = $True
				$buttonhttpcheck.add_Click($buttonhttpcheck_Click)
				# buttonpathping
				#
				$buttonpathping.Location = '1150, 12'
				$buttonpathping.Name = "buttonpathping"
				$buttonpathping.Size = '75, 23'
				$buttonpathping.TabIndex = 4
				$buttonpathping.Text = "PathPing"
				$buttonpathping.UseVisualStyleBackColor = $True
				$buttonpathping.add_Click($buttonpathping_Click)
				#
				#endregion Generated Form Code

				#----------------------------------------------

				#Save the initial state of the form
				$InitialFormWindowState = $formEventLogSearch.WindowState
				#Init the OnLoad event to correct the initial state of the form
				$formEventLogSearch.add_Load($Form_StateCorrection_Load)
				#Clean up the control events
				$formEventLogSearch.add_FormClosed($Form_Cleanup_FormClosed)
				#Show the Form
				return $formEventLogSearch.ShowDialog()

			}
			#End Function

			#Call the form
			Call-event_psf
			Write-Debug "Exiting"

Stop-Transcript



# SIG # Begin signature block
# MIIOgQYJKoZIhvcNAQcCoIIOcjCCDm4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUxGnQN31MNFBdZ3Yb4Yf3Q73R
# glygggqXMIIB+jCCAWegAwIBAgIQyzsBWwgxaIRDy/VbxwNwLjAJBgUrDgMCHQUA
# MBExDzANBgNVBAMTBkNvbGxpbjAeFw0xNjA2MTAxMTU5NTNaFw0zOTEyMzEyMzU5
# NTlaMBExDzANBgNVBAMTBkNvbGxpbjCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkC
# gYEAxyR4sFnXkct31qNV2oI8gK4rn4SMmZzim111OEXT2RNpzgEpcI40RXPZyzJb
# ShT1bFQyk1NzUrXkCp7zSIy3sme4M2KWET3yoEAql8IutHi4sS9hkdnGmTyYvCjA
# n864isUspyoN5JQopxLqPZlmSNclKAtPnQ+1ynCWInkmiNUCAwEAAaNbMFkwEwYD
# VR0lBAwwCgYIKwYBBQUHAwMwQgYDVR0BBDswOYAQQjS4TcFPNcvBnAaKn/81WKET
# MBExDzANBgNVBAMTBkNvbGxpboIQyzsBWwgxaIRDy/VbxwNwLjAJBgUrDgMCHQUA
# A4GBAH0YAbZuTiV3Z10nvp/LSKXTC9vDMp/BhgsY7ZYmsGDI4IWUb0qayrOx2cvp
# c8ZbknZOxn1s08bqNBOjxO7SkR+eQd0Yz1Z3e2KKQb+/T1rFnK9mwqrGCy2x49D2
# VWn9FoSX69l0xIID4Rxbhhqs/ftNGayNcBRePqu/1ay++zxkMIID7jCCA1egAwIB
# AgIQfpPr+3zGTlnqS5p31Ab8OzANBgkqhkiG9w0BAQUFADCBizELMAkGA1UEBhMC
# WkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTEUMBIGA1UEBxMLRHVyYmFudmlsbGUx
# DzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUVGhhd3RlIENlcnRpZmljYXRpb24x
# HzAdBgNVBAMTFlRoYXd0ZSBUaW1lc3RhbXBpbmcgQ0EwHhcNMTIxMjIxMDAwMDAw
# WhcNMjAxMjMwMjM1OTU5WjBeMQswCQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50
# ZWMgQ29ycG9yYXRpb24xMDAuBgNVBAMTJ1N5bWFudGVjIFRpbWUgU3RhbXBpbmcg
# U2VydmljZXMgQ0EgLSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
# ALGss0lUS5ccEgrYJXmRIlcqb9y4JsRDc2vCvy5QWvsUwnaOQwElQ7Sh4kX06Ld7
# w3TMIte0lAAC903tv7S3RCRrzV9FO9FEzkMScxeCi2m0K8uZHqxyGyZNcR+xMd37
# UWECU6aq9UksBXhFpS+JzueZ5/6M4lc/PcaS3Er4ezPkeQr78HWIQZz/xQNRmarX
# bJ+TaYdlKYOFwmAUxMjJOxTawIHwHw103pIiq8r3+3R8J+b3Sht/p8OeLa6K6qbm
# qicWfWH3mHERvOJQoUvlXfrlDqcsn6plINPYlujIfKVOSET/GeJEB5IL12iEgF1q
# eGRFzWBGflTBE3zFefHJwXECAwEAAaOB+jCB9zAdBgNVHQ4EFgQUX5r1blzMzHSa
# 1N197z/b7EyALt0wMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8v
# b2NzcC50aGF3dGUuY29tMBIGA1UdEwEB/wQIMAYBAf8CAQAwPwYDVR0fBDgwNjA0
# oDKgMIYuaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVRpbWVzdGFtcGluZ0NB
# LmNybDATBgNVHSUEDDAKBggrBgEFBQcDCDAOBgNVHQ8BAf8EBAMCAQYwKAYDVR0R
# BCEwH6QdMBsxGTAXBgNVBAMTEFRpbWVTdGFtcC0yMDQ4LTEwDQYJKoZIhvcNAQEF
# BQADgYEAAwmbj3nvf1kwqu9otfrjCR27T4IGXTdfplKfFo3qHJIJRG71betYfDDo
# +WmNI3MLEm9Hqa45EfgqsZuwGsOO61mWAK3ODE2y0DGmCFwqevzieh1XTKhlGOl5
# QGIllm7HxzdqgyEIjkHq3dlXPx13SYcqFgZepjhqIhKjURmDfrYwggSjMIIDi6AD
# AgECAhAOz/Q4yP6/NW4E2GqYGxpQMA0GCSqGSIb3DQEBBQUAMF4xCzAJBgNVBAYT
# AlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3JhdGlvbjEwMC4GA1UEAxMnU3lt
# YW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBDQSAtIEcyMB4XDTEyMTAxODAw
# MDAwMFoXDTIwMTIyOTIzNTk1OVowYjELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFFN5
# bWFudGVjIENvcnBvcmF0aW9uMTQwMgYDVQQDEytTeW1hbnRlYyBUaW1lIFN0YW1w
# aW5nIFNlcnZpY2VzIFNpZ25lciAtIEc0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
# MIIBCgKCAQEAomMLOUS4uyOnREm7Dv+h8GEKU5OwmNutLA9KxW7/hjxTVQ8VzgQ/
# K/2plpbZvmF5C1vJTIZ25eBDSyKV7sIrQ8Gf2Gi0jkBP7oU4uRHFI/JkWPAVMm9O
# V6GuiKQC1yoezUvh3WPVF4kyW7BemVqonShQDhfultthO0VRHc8SVguSR/yrrvZm
# PUescHLnkudfzRC5xINklBm9JYDh6NIipdC6Anqhd5NbZcPuF3S8QYYq3AhMjJKM
# kS2ed0QfaNaodHfbDlsyi1aLM73ZY8hJnTrFxeozC9Lxoxv0i77Zs1eLO94Ep3oi
# siSuLsdwxb5OgyYI+wu9qU+ZCOEQKHKqzQIDAQABo4IBVzCCAVMwDAYDVR0TAQH/
# BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAOBgNVHQ8BAf8EBAMCB4AwcwYI
# KwYBBQUHAQEEZzBlMCoGCCsGAQUFBzABhh5odHRwOi8vdHMtb2NzcC53cy5zeW1h
# bnRlYy5jb20wNwYIKwYBBQUHMAKGK2h0dHA6Ly90cy1haWEud3Muc3ltYW50ZWMu
# Y29tL3Rzcy1jYS1nMi5jZXIwPAYDVR0fBDUwMzAxoC+gLYYraHR0cDovL3RzLWNy
# bC53cy5zeW1hbnRlYy5jb20vdHNzLWNhLWcyLmNybDAoBgNVHREEITAfpB0wGzEZ
# MBcGA1UEAxMQVGltZVN0YW1wLTIwNDgtMjAdBgNVHQ4EFgQURsZpow5KFB7VTNpS
# Yxc/Xja8DeYwHwYDVR0jBBgwFoAUX5r1blzMzHSa1N197z/b7EyALt0wDQYJKoZI
# hvcNAQEFBQADggEBAHg7tJEqAEzwj2IwN3ijhCcHbxiy3iXcoNSUA6qGTiWfmkAD
# HN3O43nLIWgG2rYytG2/9CwmYzPkSWRtDebDZw73BaQ1bHyJFsbpst+y6d0gxnEP
# zZV03LZc3r03H0N45ni1zSgEIKOq8UvEiCmRDoDREfzdXHZuT14ORUZBbg2w6jia
# sTraCXEQ/Bx5tIB7rGn0/Zy2DBYr8X9bCT2bW+IWyhOBbQAuOA2oKY8s4bL0WqkB
# rxWcLC9JG9siu8P+eJRRw4axgohd8D20UaF5Mysue7ncIAkTcetqGVvP6KUwVyyJ
# ST+5z3/Jvz4iaGNTmr1pdKzFHTx/kuDDvBzYBHUxggNUMIIDUAIBATAlMBExDzAN
# BgNVBAMTBkNvbGxpbgIQyzsBWwgxaIRDy/VbxwNwLjAJBgUrDgMCGgUAoHgwGAYK
# KwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIB
# BDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU
# MCH3eLM6qv5FA1w2/2cajXiOtH8wDQYJKoZIhvcNAQEBBQAEgYC6Zv6eY5RLAfUO
# Xq9mQEv+bl4wIZU6zLCZ5gMKJMWHdNOwm+PJFTpv/oCNTuPFuBIVKPaHbVGQ2gNZ
# P7orjuRCh4v/h3vKgc8KBGudW+3au4Ol700QXDwlkP1ePjccjS1knaruSRfpCKvG
# 8LkLOAAk2gJLKt84ij5qREmY3g4kc6GCAgswggIHBgkqhkiG9w0BCQYxggH4MIIB
# 9AIBATByMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBD
# QSAtIEcyAhAOz/Q4yP6/NW4E2GqYGxpQMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0B
# CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNjA4MjUxMzQ3MjlaMCMG
# CSqGSIb3DQEJBDEWBBRVYLKh0pW3M5v9qXUO47XoDOXNazANBgkqhkiG9w0BAQEF
# AASCAQAJiALbdAf3pQJ9OfcUGufWeKtIKZpwt3u9KSBNaiRaitEgmR0aRd2O5Ujg
# ppuhGL5PBMETH3lv++dqS/xrATRwwgutPUlzrmjBoqkmU71brEWbD/7EoyfDf7+I
# Krx6j8clYpBjdJJrwbbL2TWlzH2qQZYqS6T0EiCdMgdqxpX/BBqSoCMoYVmCXNop
# PFkHzvcqHByZSvHrLegMMSE556NEQFzrJTIda3Xqgl5mINGU3cFbqB4Slb0Rbxzp
# P8u1CMWBnJxiQFjszhCxrJ51d1HZgLk/8aWAgaLguqacO4Bp0qngg8fN4MxLlSrD
# cr7eS1RhlToykAwaNr0injXZ7uzE
# SIG # End signature block
