	#basicly the same thing as $buttonSearch except this will list x of the last entries in it , default is 60 entries in application log
			$richtextbox1.AppendText("Depending on the amount of entries this may take a while")
			$richtextbox1.AppendText("`n")
			$richtextbox1.AppendText("------- Event log Results ------");
			$richtextbox1.AppendText("`n")
			[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
			$logname2 = [Microsoft.VisualBasic.Interaction]::InputBox("Log name , allowed are Application,System,Setup and Security", "Logname", "Application")
			$how = [Microsoft.VisualBasic.Interaction]::InputBox("how many entries should be retrieved", "number", "60")
			Write-Debug "information gathered for event log fetch"
			$eventlist = Get-eventlog -logname $logname2 -Newest $how |Select-Object -Property EntryType,Source,Message | Tee-Object -Variable temp |Out-GridView -PassThru|Out-GridView
			$richtextbox1.AppendText("$eventlist")
			$error1 = $Error[0] | Format-table -Force | out-string
			if ($Error.Count -eq "0") { $buttonSave.Enabled = $true; }
			#write-debug Event log Listing ran $logname2 $how
			#write-debug $error
			$Error.clear()

# SIG # Begin signature block
# MIIOgQYJKoZIhvcNAQcCoIIOcjCCDm4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUym20j/Ee1CfbzEMDXkO1EvD/
# mbOgggqXMIIB+jCCAWegAwIBAgIQyzsBWwgxaIRDy/VbxwNwLjAJBgUrDgMCHQUA
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
# C9Oj7FDfCY/sp8kIk27nB9oOgEowDQYJKoZIhvcNAQEBBQAEgYA8xD44TLAAC1rc
# zI6OZ0YPrD/TBYyEH/qsMhpABQae2vwOQgCQiUj13vrM1WsPBfE6sAfoTGjkPQzA
# Ci07fvkhnZtjwNxCcuh7pAZcpzEBBScbNrDO4OZ1+sBzqZz1uai1Z/L5e3BN8NIZ
# d3ix1II86jIF1vZdPgcJ6OB7y+nPwaGCAgswggIHBgkqhkiG9w0BCQYxggH4MIIB
# 9AIBATByMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBD
# QSAtIEcyAhAOz/Q4yP6/NW4E2GqYGxpQMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0B
# CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNjA2MzAxMzQ5MzBaMCMG
# CSqGSIb3DQEJBDEWBBTqX8N54N9WFk8t2Se1lTckMgyENTANBgkqhkiG9w0BAQEF
# AASCAQA6sNUeovBNpLUsEcuxwwMWa6MZZCjBj7CRo8x/0TWjbvHgWwx1AJqhQI1l
# CUIRZ0ZnGln69ZQe9SYW1Er6sDmsifCPHSJAbgrBmHdJp39bAbT5/c8gUb3vrFz3
# od11BlhTnbUhqeh1aZ7ssRC7KHDOEq/y4DTMsAXj+tbpwnVnoba4L5BcMIaBMXKh
# tfjxB4XzhC7ndCL3j5j0mFFUlIsknc8qdOSYWR0CBPzKGCO2MyAKXg+HcFXoaZe3
# ExzR1BR0oc0pmFa+Qe43xCoMkrSSxPzbnaxOzV/KkWvfJsYAy4UUDXueOXH58FVd
# Jf5aBqYpF3pMrRLF0Mlw8ww4miAC
# SIG # End signature block
