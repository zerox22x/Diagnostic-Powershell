[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
            	$site = [Microsoft.VisualBasic.Interaction]::InputBox("Enter a Website", "Computer", "www.google.com")
            	Write-Debug "get website for http connection check,"
				$richtextbox1.AppendText("Testing connection to $site`n")
				$webtest = Invoke-WebRequest -Uri "$site"|Select-Object Statuscode, StatusDescription, Headers, Baseresponse| Format-list |Out-string
				$ping = Test-NetConnection $site | Out-String
				$richtextbox1.AppendText("ping result`n$ping")
				$richtextbox1.AppendText("website test result`n$webtest")
				Write-Debug "Connection check ran"