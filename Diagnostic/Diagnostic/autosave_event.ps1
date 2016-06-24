
#make sure this is running in sta mode as some gui elements only work there
$IsSTAEnabled = $host.Runspace.ApartmentState -eq 'STA'
#Set the name of the console window
$host.UI.RawUI.WindowTitle="Window Title"
	If ($IsSTAEnabled -eq $false) {

	Write-Host ="Script is not running in STA mode. Switching to STA Mode..."
	#Get Script path and name
	$Script = $MyInvocation.MyCommand.Definition
	#Launch script in a separate PowerShell process with STA enabled
	Start-Process powershell.exe -ArgumentList "-sta $Script"
	Exit
}
# Run your code that needs to be elevated here

#Requires -Version 3.0
Start-Transcript -Path errorlog.log -Append
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
	$richtextbox1 = New-Object 'System.Windows.Forms.RichTextBox'
	$buttonSearch = New-Object 'System.Windows.Forms.Button'
	$buttonlistdrive = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
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
			}
		}
		else {
				$richtextbox1.AppendText("Running Without administrator permissions , Event log clear disabled`n")
				$buttonclearapplog.Enabled = $false;
				}
		
		$buttonSave.Enabled = $false;
		$itemlocation = Get-Location | Out-String
		$itemlocation.Trim("Path, ---")
		# Get current location
		$richtextbox1.AppendText("Current location is $itemlocation")
		# Get windows version and add it to the box
		$windowsname = (Get-WmiObject win32_operatingsystem).caption | Out-String
		$richtextbox1.AppendText("`n")
		$richtextbox1.AppendText("$windowsname")
		$Error.Clear()
		# Grab all users and display them
		$users = Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount='True'" | Select PSComputername, Name, AccountType|Format-table -Wrap|Out-String
		$richtextbox1.AppendText("$users`n")
		#Get bit version of windows
		$richtextbox1.Appendtext("bit mode is $env:Processor_Architecture`n")
		# check for internet connectivity
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
		Write-Debug "Initalization done"
		}


	$buttonSearch_Click = {
		#Searches event log , creates a .net popup uses the input box as arguments for the commands itself , outputs 3 properties to the text box
		$richtextbox1.AppendText("Searching may take a while , the program may appear to be stuck")
		[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
		$logname = [Microsoft.VisualBasic.Interaction]::InputBox("log name , allowed are Application,System,Setup,Security", "LogName", "Application")
		$programname = [Microsoft.VisualBasic.Interaction]::InputBox("programname", "programname", "*")
		$how = [Microsoft.VisualBasic.Interaction]::InputBox("how many entries should be retrieved", "number", "60")

		$events = get-eventlog -logname $logname -Newest $how
		#$scan = $events | foreach-object -begin { clear-host; $i = 0; $out = "" } -process { if ($_.message -like "*$programname*") { $out = $out + $_.Message }; $i = $i + 1; write-progress -activity "Searching Events" -status "Progress:" -percentcomplete ($i/$events.count * 100) } -end { $out } | format-table ID, message | Out-String
		$scan = $events | Where-Object { $_.message -like "*$programname*" } |Select-Object -Property EntryType,Source,Message |  Format-table| Out-String
		$richtextbox1.AppendText("$scan")
		$error1 = $Error[0] | Format-table -Force | out-string
		if ($Error.Count -eq "0") { $buttonSave.Enabled = $true; }
		if ($Error.Count -ne "0") { $richtextbox1.AppendText("$Error1")}
		$Error.Clear()
	}


	$richtextbox1_TextChanged = {
		#fires everytime text is added to the textbox , always scroll down and clear any errors that may have occured
		$richtextbox1.ScrollToCaret();

}
			if ($Error.Count -eq "0") { $buttonSave.Enabled = $true; }
		if ($Error.Count -ne "0") { $richtextbox1.AppendText("$Error1") }
		$Error.Clear()
		

	$buttonclearapplog_Click = 	{
		# Clears the event log if persmissopn is given , uses a .net window with a inputbox to choose a eventlog, if there are no administrator rights this will fail , it is disabled for non admin runs during init
		[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")|Out-Null
		$OUTPUT = [System.Windows.Forms.MessageBox]::Show("This will clear the eventlog that is chosen in the next step.`nPress yes to continue`n no to cancel" , "Status" , 4) 
		if ($OUTPUT -eq "YES")
		{
			[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
			$logname2 = [Microsoft.VisualBasic.Interaction]::InputBox("Log name , allowed are Application,System,Setup and Security", "Logname", "Application")
			Clear-EventLog -LogName $logname2
			$richtextbox1.Appendtext("`nClearing $logname")
						
			$richtextbox1.AppendText("`nlog cleared")
		}
		else {
			$richtextbox1.AppendText("`n Eventlog Clear Cancled")
			}
		$error1 = $Error[0] | Out-String
		if ($Error.Count -eq "0") {}
		if ($Error.Count -ne "0") { $richtextbox1.AppendText("$Error1") }
		}
	$buttonList_Click = {
			#basicly the same thing as $buttonSearch except this will list x of the last entries in it , default is 60 entries in application log
			$richtextbox1.AppendText("Depending on the amount of entries this may take a while")
			$richtextbox1.AppendText("`n")
			$richtextbox1.AppendText("------- Event log Results ------");
			$richtextbox1.AppendText("`n")
			[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
			$logname2 = [Microsoft.VisualBasic.Interaction]::InputBox("Log name , allowed are Application,System,Setup and Security", "Logname", "Application")
			$how = [Microsoft.VisualBasic.Interaction]::InputBox("how many entries should be retrieved", "number", "60")
			$eventlist = Get-eventlog -logname $logname2 -Newest $how |Select-Object -Property EntryType,Source,Message | Format-table | Out-String 
			$richtextbox1.AppendText("$eventlist")
			$error1 = $Error[0] | Format-table -Force | out-string
			if ($Error.Count -eq "0") { $buttonSave.Enabled = $true; }
			if ($Error.Count -ne "0") { $richtextbox1.AppendText("$Error1") }
			$Error.clear()

		}

		$buttonSave_Click = {
			#Save current contents in $richtextbox1 to a file with spacing and enters intact
			$txtboxstuff = $richtextbox1.Lines |Format-List| Out-File results.txt
			
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
		}
		$buttonlistdrive_Click = {
			# Lists drives , uses math shenanigans to get to GB rather then bytes
			$drives = Get-PSDrive -PSProvider FileSystem |Format-Table -Wrap -AutoSize -Property Root, @{Name="UsedGB";Expression={[math]::round($_.used/1gb,2)}}, @{Name="FreeGB";Expression={[math]::round($_.free/1gb,2)}}, Description | Out-String
			$richtextbox1.AppendText("--------- Local Drives -------")
			$richtextbox1.AppendText("`n")
			$richtextbox1.AppendText("$drives")
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
				}



				$buttonInstalledPrograms_Click = {
					#Gets installed programs, keeps in mind if a system is 64 bit or not, currently has a issue with showing doubles and far too much empty space (dont know why)
					$richtextbox1.AppendText("this may take a while")
					$richtextbox1.AppendText("`n")
					$richtextbox1.AppendText("----- Installed Programs List ------")
					$richtextbox1.AppendText("`n")
					#64 bit
					if ($Env:PROCESSOR_ARCHITECTURE -eq "AMD64"){
					$getprograms = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher| Sort-Object DisplayName | Format-Table|Out-string
					$getprograms2 =  Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,DisplayVersion, Publisher|Sort-Object DisplayName|Format-Table|Out-string
					$programs = $getprograms + $getprograms2
					}
					Else {
					$programs = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,DisplayVersion, Publisher|Sort-Object DisplayName|Format-Table|Out-string
					}
					$pattern = '[^0-9a-zA-Z-]'
					$programs = ($programs -replace $pattern, ' ').trim()
					$richtextbox1.AppendText("$programs")
					$error1 = $Error[0] | Format-table -Force | out-string

				}

				$buttonPing_Click = {
					#loads .net window , adds a input box,uses input box as argument for ping , formats the list and output as string rather then powershell object
					[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
					$ip = [Microsoft.VisualBasic.Interaction]::InputBox("enter a ipadress`nvalid are x.x.x.x or a domain ex www.google.com", "Computer", "www.google.com")
					$richtextbox1.AppendText("------ Ping Results ------")
					$richtextbox1.AppendText("`n")
					$pingresult = Test-Connection $ip | Format-Table |out-string
					$richtextbox1.AppendText("$pingresult")
					$error1 = $Error[0] | Format-table -Force | out-string
				}

				$buttonIpconfig_Click = {
					#Grabs current IP Configuration from netword adapters and displays it
					$richtextbox1.AppendText("------- Ip Configuration -------")
					$ipconfig = get-netipconfiguration |Format-list|Out-String
					$richtextbox1.AppendText("$ipconfig")
					$error1 = $Error[0] | Format-table -Force | out-string
				}

				$button1_Click = {
					#Creates a log file about the status of windows update and any errors , this can take some time to complete
					$richtextbox1.AppendText("------ Windows Update logs----")
					$richtextbox1.AppendText("`n")
					$richtextbox1.AppendText("This may appear to hang")
					$updatelogcreate = Get-WindowsUpdateLog -LogPath $env:temp\UpdateLog.log
					$log = Get-Content -Path $env:temp\UpdateLog.log | Format-table | Out-String
					$richtextbox1.AppendText("$updatelogcreate")
					$richtextbox1.AppendText("$log")
				}

				$button2_Click = {
					#Grabs all running procceses and services , has an issue with too much white space
					$richtextbox1.AppendText("------- Running processes -------")
					$processes = Get-Process| Format-Table -property Name,ID,path |Out-string
					#$get = Get-Content temp.txt
					$richtextbox1.AppendText("`n")
					$richtextbox1.AppendText("$Processes")
					$richtextbox1.AppendText("`n---------Services------")
					$services = Get-Service|Sort-Object -Property Status |Format-table -Property Status,DisplayName |Out-String
					$richtextbox1.AppendText("`n$services")
					#Remove-Item tempt.txt
				}

				Get-Variable -Scope script 
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
				$formEventLogSearch.ClientSize = '1600, 900'
				$formEventLogSearch.Name = "formEventLogSearch"
				$formEventLogSearch.Text = "Event Log Search"
				$formEventLogSearch.add_FormClosing($formEventLogSearch_FormClosing)
				$formEventLogSearch.add_FormClosed($formMain_FormClosed)
				$formEventLogSearch.add_Load($formEventLogSearch_Load)
			
				#
				# button1
				#
				$button1.Location = '318, 12'
				$button1.Name = "Windows Update log"
				$button1.Size = '120, 23'
				$button1.TabIndex = 9
				$button1.Text = "Windows Update Log"
				$button1.UseVisualStyleBackColor = $True
				$button1.add_Click($button1_Click)
				#
				#processes
				$button2.Location = '830, 12'
				$button2.Name = "processes"
				$button2.Size = '75, 23'
				$button2.TabIndex = 9
				$button2.Text = "processes"
				$button2.UseVisualStyleBackColor = $True
				$button2.add_Click($button2_Click)
				#
				# buttonIpconfig
				#
				$buttonIpconfig.Location = '756, 12'
				$buttonIpconfig.Name = "buttonIpconfig"
				$buttonIpconfig.Size = '75, 23'
				$buttonIpconfig.TabIndex = 8
				$buttonIpconfig.Text = "ipconfig"
				$buttonIpconfig.UseVisualStyleBackColor = $True
				$buttonIpconfig.add_Click($buttonIpconfig_Click)
				#
				# buttonPing
				#
				$buttonPing.Location = '675, 13'
				$buttonPing.Name = "buttonPing"
				$buttonPing.Size = '75, 23'
				$buttonPing.TabIndex = 7
				$buttonPing.Text = "Ping"
				$buttonPing.UseVisualStyleBackColor = $True
				$buttonPing.add_Click($buttonPing_Click)
				#
				# buttonInstalledPrograms
				#
				$buttonInstalledPrograms.Location = '547, 12'
				$buttonInstalledPrograms.Name = "buttonInstalledPrograms"
				$buttonInstalledPrograms.Size = '111, 23'
				$buttonInstalledPrograms.TabIndex = 6
				$buttonInstalledPrograms.Text = "Installed programs"
				$buttonInstalledPrograms.UseVisualStyleBackColor = $True
				$buttonInstalledPrograms.add_Click($buttonInstalledPrograms_Click)
				#
				# buttonFirewallStatus
				#
				$buttonFirewallStatus.Location = '446, 12'
				$buttonFirewallStatus.Name = "buttonFirewallStatus"
				$buttonFirewallStatus.Size = '95, 23'
				$buttonFirewallStatus.TabIndex = 5
				$buttonFirewallStatus.Text = "Firewall Status"
				$buttonFirewallStatus.UseVisualStyleBackColor = $True
				$buttonFirewallStatus.add_Click($buttonFirewallStatus_Click)
				#
				# buttonAbout
				#
				$buttonAbout.Location = '1073, 13'
				$buttonAbout.Name = "buttonAbout"
				$buttonAbout.Size = '75, 23'
				$buttonAbout.TabIndex = 4
				$buttonAbout.Text = "About"
				$buttonAbout.UseVisualStyleBackColor = $True
				$buttonAbout.add_Click($buttonAbout_Click)
				#
				# buttonSave
				#
				$buttonSave.Location = '189, 12'
				$buttonSave.Name = "buttonSave"
				$buttonSave.Size = '75, 23'
				$buttonSave.TabIndex = 3
				$buttonSave.Text = "Save"
				$buttonSave.UseVisualStyleBackColor = $True
				$buttonSave.add_Click($buttonSave_Click)
				#
				# buttonList
				#
				$buttonList.Location = '107, 12'
				$buttonList.Name = "buttonList"
				$buttonList.Size = '75, 23'
				$buttonList.TabIndex = 2
				$buttonList.Text = "List"
				$buttonList.UseVisualStyleBackColor = $True
				$buttonList.add_Click($buttonList_Click)
				#
				# richtextbox1
				#
				$richtextbox1.Location = '12, 55'
				$richtextbox1.Name = "richtextbox1"
				$richtextbox1.Size = '1600, 850'
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
				$buttonSearch.Location = '13, 13'
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
				$buttonclearapplog.Location = '920, 13'
				$buttonclearapplog.Name = "eventclear"
				$buttonclearapplog.Size = '75, 23'
				$buttonclearapplogTabIndex = 0
				$buttonclearapplog.Text = "event clear"
				$buttonclearapplog.UseVisualStyleBackColor = $True
				$buttonclearapplog.add_Click($buttonclearapplog_Click)
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
Stop-Transcript

#dont do signing untill done