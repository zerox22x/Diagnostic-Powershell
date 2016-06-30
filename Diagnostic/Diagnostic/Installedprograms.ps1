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
					
					
		
# SIG # Begin signature block
# MIIOgQYJKoZIhvcNAQcCoIIOcjCCDm4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUR01NVOZOJsvJ6IKdqn66KbAr
# 7CCgggqXMIIB+jCCAWegAwIBAgIQyzsBWwgxaIRDy/VbxwNwLjAJBgUrDgMCHQUA
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
# D5b4IMLDtl4hY4iWPufmXKGD0i8wDQYJKoZIhvcNAQEBBQAEgYBHnPnpQTjpkhsk
# u8eUAJJSNAan9jtqG0RM91E+DOIZK3ycVTAN79dZqwMaXavJxBdW+GtnS/M1u3tU
# b7K4m0TrE9uS/c1H6d62KWQF16bXH/tdspS9LToqRQYYHsnrWgnyew74bwZLfzSL
# bgAEKMGdX9MzFSbw4OXWUbZ2zcjyVaGCAgswggIHBgkqhkiG9w0BCQYxggH4MIIB
# 9AIBATByMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBD
# QSAtIEcyAhAOz/Q4yP6/NW4E2GqYGxpQMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0B
# CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNjA2MzAxMzQ5MDZaMCMG
# CSqGSIb3DQEJBDEWBBRYIvnNG+Sb+nfbhmynju08OdKcOTANBgkqhkiG9w0BAQEF
# AASCAQA/mZMzC7Yx42QfuUjODkNGCH8CT0q/Ai/d3VN833O3CSxem+1DcQGSgm6c
# K5JGs8tj5ggA5Thter30icMGUp2vYB2dsrVQU2IOjBJ95LrqTyrWTIX3XL+4P0GC
# vJn+gd4mptfK9fmV+yS2k9phZKIJkHEPEosQH2j73FRTvFUiF4lIJMxaUhl+Id+l
# L92eD9P8j0+/xziqc+avOirn3ykBQi7dkY1QRDF5bTNYU9HbH5ZVRu0beOHNQmyb
# VEVFxwgv4JqlbjY6MY71mVXI+d/O+t9mCOGeQWE4weluPy8Ev6zCfl9RYEs4MrxJ
# neCFbYIyUyXCq+HHBGVIULr6Gv7J
# SIG # End signature block
