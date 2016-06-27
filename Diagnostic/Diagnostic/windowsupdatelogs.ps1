#Creates a log file about the status of windows update and any errors , this can take some time to complete
					$richtextbox1.AppendText("------ Windows Update logs----")
					$richtextbox1.AppendText("`n")
					$richtextbox1.AppendText("This may appear to hang")
					$updatelogcreate = Get-WindowsUpdateLog -LogPath $env:temp\UpdateLog.log
					Write-Debug "Windows update log was clicked , still need to see if this can be faster"
					$log = Get-Content -Path $env:temp\UpdateLog.log | Format-table | Out-String
					$updatelogcreate
					$richtextbox1.AppendText("$log")
					#write-debug windows update was clicked
					#write-debug $error
                    return 0