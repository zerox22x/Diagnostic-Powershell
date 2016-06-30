#Grabs current IP Configuration from netword adapters and displays it
					$richtextbox1.AppendText("------- Ip Configuration -------")
					$ipconfig = get-netipconfiguration |Format-list|Out-String
					$richtextbox1.AppendText("$ipconfig")
					#write-debug $ipconfig
					write-debug "ipconfig was clicked"
					#write-debug $error

					