	#basicly the same thing as $buttonSearch except this will list x of the last entries in it , default is 60 entries in application log
			$richtextbox1.AppendText("Depending on the amount of entries this may take a while")
			$richtextbox1.AppendText("`n")
			$richtextbox1.AppendText("------- Event log Results ------");
			$richtextbox1.AppendText("`n")
			[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
			$logname2 = [Microsoft.VisualBasic.Interaction]::InputBox("Log name , allowed are Application,System,Setup and Security", "Logname", "Application")
			$how = [Microsoft.VisualBasic.Interaction]::InputBox("how many entries should be retrieved", "number", "60")
			Write-Debug "information gathered for event log fetch"
			$eventlist = Get-eventlog -logname $logname2 -Newest $how |Select-Object -Property EntryType,Source,Message | Format-table | Out-String 
			$richtextbox1.AppendText("$eventlist")
			$error1 = $Error[0] | Format-table -Force | out-string
			if ($Error.Count -eq "0") { $buttonSave.Enabled = $true; }
			#write-debug Event log Listing ran $logname2 $how
			#write-debug $error
			$Error.clear()
