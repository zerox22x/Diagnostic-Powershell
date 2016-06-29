#Gets installed programs, keeps in mind if a system is 64 bit or not,was doeing things far to complicated
					$ErrorActionPreference = "SilentlyContinue"
					$VerbosePreference = "Continue"
					$richtextbox1.AppendText("this may take a while")
					$richtextbox1.AppendText("`n")
					$richtextbox1.AppendText("----- Installed Programs List ------")
					$richtextbox1.AppendText("`n")
				$ErrorActionPreference = "SilentlyContinue"
						#64 bit
					if ($Env:PROCESSOR_ARCHITECTURE -eq "AMD64"){
					$getprograms = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |Where-object {$_.DisplayName -ne $null}| Where-Object {$_.DisplayName -ne ' '} | Select-Object DisplayName, DisplayVersion, Publisher,InstallLocation
					$getprograms2 =  Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |Where-object {$_.DisplayName -ne $null}| Where-Object {$_.DisplayName -ne ' '} | Select-Object DisplayName,DisplayVersion, Publisher,InstallLocation
					# add $getprograms and $getprograms2 together then sort on display name and save as a string
					$programs = $getprograms + $getprograms2 | Sort-Object DisplayName | Out-String
					Write-Debug "64 bit path for installed programs ran"
					$richtextbox1.AppendText("$programs")
				
					
					Else {
					$programs = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |Where-object {$_.DisplayName -ne $null}| Where-Object {$_.DisplayName -ne ' '} | Select-Object DisplayName,DisplayVersion, Publisher,InstallLocation|Sort-Object DisplayName |Out-string
					Write-Debug "32 bit path for installed programs ran"
					Write-Verbose "ignore the errors $programs"
					$richtextbox1.AppendText("$programs")}}
		