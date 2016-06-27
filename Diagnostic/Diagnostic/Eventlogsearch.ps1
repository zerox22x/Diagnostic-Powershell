#Searches event log , creates a .net popup uses the input box as arguments for the commands itself , outputs 3 properties to the text box
		$richtextbox1.AppendText("Searching may take a while , the program may appear to be stuck")
		[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
		$logname = [Microsoft.VisualBasic.Interaction]::InputBox("log name , allowed are Application,System,Setup,Security", "LogName", "Application")
		$programname = [Microsoft.VisualBasic.Interaction]::InputBox("programname", "programname", "*")
		$how = [Microsoft.VisualBasic.Interaction]::InputBox("how many entries should be retrieved", "number", "60")
		write-debug "Information gathered for event log search"
		$events = get-eventlog -logname $logname -Newest $how
		Write-Debug "Got specified entries"
		$scan = $events | Where-Object { $_.message -like "*$programname*" } |Select-Object -Property EntryType,Source,Message | Format-table| Out-String
		Write-Debug "Get only the things we want , the rest can go away"
		$richtextbox1.AppendText("$scan")
		$error1 = $Error[0] | Format-table -Force | out-string
		if ($Error.Count -eq "0") { $buttonSave.Enabled = $true; }
		#write-debug Event log Search ran
		
		$Error.Clear()