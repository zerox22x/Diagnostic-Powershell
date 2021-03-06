#Searches event log , creates a .net popup uses the input box as arguments for the commands itself , outputs 3 properties to the text box
		$richtextbox1.AppendText("Searching may take a while , the program may appear to be stuck")
		[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
		$logname = [Microsoft.VisualBasic.Interaction]::InputBox("log name , allowed are Application,System,Setup,Security", "LogName", "Application")
		$programname = [Microsoft.VisualBasic.Interaction]::InputBox("programname", "programname", "*")
		$how = [Microsoft.VisualBasic.Interaction]::InputBox("how many entries should be retrieved", "number", "60")
		write-debug "Information gathered for event log search"
		$events = get-eventlog -logname $logname -Newest $how
		Write-Debug "Got specified entries"
		$scan = $events | Where-Object { $_.message -like "*$programname*" } |Select-Object -Property EntryType,Source,Message | Tee-Object -Variable temp |Out-GridView -PassThru | Out-GridView
		#$scan = $events | Where-Object { $_.message -like "*$programname*" } |Select-Object -Property EntryType,Source,Message | Format-table| Out-String
		Write-Debug "Get only the things we want , the rest can go away"
		$richtextbox1.AppendText("$temp")
		$error1 = $Error[0] | Format-table -Force | out-string
		if ($Error.Count -eq "0") { $buttonSave.Enabled = $true; }
		#write-debug Event log Search ran
		
		$Error.Clear()
		
# SIG # Begin signature block
# MIIOgQYJKoZIhvcNAQcCoIIOcjCCDm4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUoDyH+dMECilJ+TC+gn5P0Ggu
# g4SgggqXMIIB+jCCAWegAwIBAgIQyzsBWwgxaIRDy/VbxwNwLjAJBgUrDgMCHQUA
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
# FJUatDAvUX+o5sy7RwfsTn6fIcgwDQYJKoZIhvcNAQEBBQAEgYAhLfvLf6c/77ZC
# WQTgjPOsgjXs1ySK9Gt3/7ANdIVXEp54YNNO42y3Y90eVKaq4IxDJpSRfoOcW4ar
# WeqS6ViqQvqvHPazg5Mf8yy2lokxCHQwbJ4LJwEY4wvlBZAdUI8qWGpo9BeSpkIj
# lYMTUA74oEHwIqFraa0y9P8khPpPpKGCAgswggIHBgkqhkiG9w0BCQYxggH4MIIB
# 9AIBATByMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBD
# QSAtIEcyAhAOz/Q4yP6/NW4E2GqYGxpQMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0B
# CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNjA2MzAxMzQ5MjVaMCMG
# CSqGSIb3DQEJBDEWBBT5P5DmtwrKnoahfgiG6sAvijJGhjANBgkqhkiG9w0BAQEF
# AASCAQArEq5cyXQ5FE25FHb5fnoGcPyCGlBDsJYGYyzgGSWa86oT5dvwFhAQIJ4u
# aDxf4c/K+lUOrbdvu4Bb0f225XpX36tIb2DSZZgqqMA2rTSLGFL5HzfWaLnlMlbq
# ca40QzhUEmo6NxwHHiJDwIUaZy9TJnv27TA93vtTekHhZBkIe3efMDaGfv7IagN5
# YoPZSSvywb8EY3sGgQmwofPxexhvPTFq9KEDPqEErM9+FQakPrORc/vPbqOWlZhT
# wpQcqnqNQ7Gaq81hUCMYXY+MuhSnkacUlZ51WmH3lji1tMYczJ0ffL5/g8/Zax0r
# Rbq1vwqxxADI7Sy5luhxYeP0PN0+
# SIG # End signature block
