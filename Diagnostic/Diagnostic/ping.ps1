	#loads .net window , adds a input box,uses input box as argument for ping , formats the list and output as string rather then powershell object
					[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
					$ip = [Microsoft.VisualBasic.Interaction]::InputBox("enter a ipadress`nvalid are x.x.x.x or a domain ex www.google.com", "Computer", "www.google.com")
					$richtextbox1.AppendText("------ Ping Results ------")
					$richtextbox1.AppendText("`n")
					$pingresult = Test-Connection $ip | Format-Table |out-string
					$richtextbox1.AppendText("$pingresult")
					#write-debug $pingresult
					write-debug "ping was clicked"
					#write-debug $error