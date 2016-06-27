	# Clears the event log if persmissopn is given , uses a .net window with a inputbox to choose a eventlog, if there are no administrator rights this will fail , it is disabled for non admin runs during init
		[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")|Out-Null
		$OUTPUT = [System.Windows.Forms.MessageBox]::Show("This will clear the eventlog that is chosen in the next step.`nPress yes to continue`n no to cancel" , "Status" , 4) 
		if ($OUTPUT -eq "YES")
		{
			[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
			$logname2 = [Microsoft.VisualBasic.Interaction]::InputBox("Log name , allowed are Application,System,Setup and Security", "Logname", "Application")
			Clear-EventLog -LogName $logname2
			Write-Debug "Eventlog clear ran"
			$richtextbox1.Appendtext("`nClearing $logname")
						
			$richtextbox1.AppendText("`nlog cleared")
		}
		else {
			$richtextbox1.AppendText("`n Eventlog Clear Cancled")
			Write-Debug "Eventlog clear got cancled"
			}
		$error1 = $Error[0] | Out-String
		if ($Error.Count -eq "0") {}