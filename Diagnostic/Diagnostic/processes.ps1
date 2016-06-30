function BuildProcessesList {
  $arr = New-Object Collections.ArrayList
  $script:col = ps | select Name, Id, BasePriority, Description, Company,Path | sort Name
  $arr.AddRange($col)
  $dtgGrid.DataSource = $arr
  $frmMain.Refresh()
}

function SelectedItemModules {
  $ErrorActionPreference = "SilentlyContinue"
  $lstView.Items.Clear()
  $sbRules.Text = ""
  $row = $dtgGrid.CurrentRowIndex

  if ($itm = $script:col[$row].Id) {
    trap { $sbRules.Text = $_.Exception.Message }
    (ps | ? {$_.Id -eq $itm}).Modules | % {
      $sel = $lstView.Items.Add($_.Size)
      [void]$sel.Subitems.Add($_.ModuleName)
      [void]$sel.Subitems.Add($_.FileName)
    }
  }
}

function AutoUpdate {
  if (!($mnuAuto.Checked)) {
    $mnuAuto.Checked = $true
    $trTimer.Start()
    $sbRules.Text = "Auto update has been enabled."
  }
  else {
    $mnuAuto.Checked = $false
    $trTimer.Stop()
    $sbRules.Text = "Auto update has been disabled."
  }
}

$frmMain_OnLoad= {
  BuildProcessesList
}

function ShowMainWindow {
  [void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
  [void][Reflection.Assembly]::LoadWithPartialName("System.Drawing")

  [Windows.Forms.Application]::EnableVisualStyles()

  $frmMain = New-Object Windows.Forms.Form
  $mnuMain = New-Object Windows.Forms.MainMenu
  $mnuFile = New-Object Windows.Forms.MenuItem
  $mnuAuto = New-Object Windows.Forms.MenuItem
  $mnuRfrs = New-Object Windows.Forms.MenuItem
  $mnuNull = New-Object Windows.Forms.MenuItem
  $mnuExit = New-Object Windows.Forms.MenuItem
  $mnuHelp = New-Object Windows.Forms.MenuItem
 # $mnuInfo = New-Object Windows.Forms.MenuItem
  $scSplit = New-Object Windows.Forms.SplitContainer
  $dtgGrid = New-Object Windows.Forms.DataGrid
  $lstView = New-Object Windows.Forms.ListView
  $chSizeK = New-Object Windows.Forms.ColumnHeader
  $chFileM = New-Object Windows.Forms.ColumnHeader
  $chFileP = New-Object Windows.Forms.ColumnHeader
  $trTimer = New-Object Windows.Forms.Timer
  $sbRules = New-Object Windows.Forms.StatusBar

  #mnuMain
  $mnuMain.MenuItems.AddRange(@($mnuFile, $mnuHelp))

  #mnuFile
  $mnuFile.MenuItems.AddRange(@($mnuAuto, $mnuRfrs, $mnuNull, $mnuExit))
  $mnuFile.Text = "&File"

  #mnuAuto
  $mnuAuto.Shortcut = "CtrlA"
  $mnuAuto.Text = "Auto &Update"
  $mnuAuto.Add_Click( { AutoUpdate } )

  #mnuRfrs
  $mnuRfrs.Shortcut = "F5"
  $mnuRfrs.Text = "&Refresh"
  $mnuRfrs.Add_Click( { $sbRules.Text = ""; BuildProcessesList } )

  #mnuNull
  $mnuNull.text = "-"

  #mnuExit
  $mnuExit.Shortcut = "CtrlX"
  $mnuExit.Text = "E&xit"
  $mnuExit.Add_Click( { $frmMain.Close() })

  #mnuHelp
  #[void]$mnuHelp.MenuItems.Add($mnuInfo)
 # $mnuHelp.Text = "&Help"

  #mnuInfo
 # $mnuInfo.Text = "About..."
  #$mnuInfo.Add_Click( { ShowAboutWindow } )

  #scSplit
  $scSplit.Dock = "Fill"
  $scSplit.Orientation = "Horizontal"
  $scSplit.Panel1.Controls.Add($dtgGrid)
  $scSplit.Panel2.Controls.Add($lstView)
  $scSplit.SplitterWidth = 1

  #dtgGrid
  $dtgGrid.CaptionVisible = $false
  $dtgGrid.Dock = "Fill"
  $dtgGrid.PreferredColumnWidth = 109
  $dtgGrid.Add_Click( { SelectedItemModules } )

  #lstView
  $lstView.Columns.AddRange(@($chSizeK, $chFileM, $chFileP))
  $lstView.Dock = "Fill"
  $lstView.FullRowSelect = $true
  $lstView.GridLines = $true
  $lstView.Sorting = "Ascending"
  $lstView.View = "Details"

  #chSizeK
  $chSizeK.Text = "Size (K)"
  $chSizeK.Width = 70

  #chFileM
  $chFileM.Text = "Module Name"
  $chFileM.Width = 130

  #chFileP
  $chFileP.Text = "Path"
  $chFileP.Width = 380

  #trTimer
  $trTimer.Interval = 10000
  $trTimer.Add_Tick( { BuildProcessesList } )

  #sbRules
  $sbRules.SizingGrip = $false
 
  #frmMain
  $frmMain.ClientSize = New-Object Drawing.Size(1024, 768)
  $frmMain.Controls.AddRange(@($scSplit, $sbRules))
  $frmMain.FormBorderStyle = "FixedSingle"
  $frmMain.Menu = $mnuMain
  $frmMain.StartPosition = "CenterScreen"
  $frmMain.Text = "PExplore"
  $frmMain.Add_Load($frmMain_OnLoad)
  $frmMain.Add_FormClosing($frmMain_close)
  
				$frmMainclose = [System.Windows.Forms.FormClosedEventHandler]{
					#Event Argument: $_ = [System.Windows.Forms.FormClosedEventArgs]
          $trTimer.Stop()

				}
  [void]$frmMain.ShowDialog()
}

function ShowAboutWindow {
  $frmMain = New-Object Windows.Forms.Form
  $lblThis = New-Object Windows.Forms.Label
  $btnExit = New-Object Windows.Forms.Button

  #lblThis
  $lblThis.Location = New-Object Drawing.Point(5, 29)
  $lblThis.Size = New-Object Drawing.Size(330, 50)
  $lblThis.Text = "(C) 2008 Grigori Zakharov `n
  This is just an example that you can make better."
  $lblThis.TextAlign = "MiddleCenter"

  #btnExit
  $btnExit.Location = New-Object Drawing.Point(132, 97)
  $btnExit.Text = "Close"
  $btnExit.Add_Click( { $frmMain.Close() } )

  #frmMain
  $frmMain.ClientSize = New-Object Drawing.Size(350, 137)
  $frmMain.ControlBox = $false
  $frmMain.Controls.AddRange(@($lblThis, $btnExit))
  $frmMain.FormBorderStyle = "FixedSingle"
  $frmMain.ShowInTaskbar = $false
  $frmMain.StartPosition = "CenterScreen"
  $frmMain.Text = "About..."

  [void]$frmMain.ShowDialog()
}

ShowMainWindow
$trTimer.Stop()


# SIG # Begin signature block
# MIIOgQYJKoZIhvcNAQcCoIIOcjCCDm4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUUCuIrzPnYrGK/Wfe6NCd6ACy
# 28+gggqXMIIB+jCCAWegAwIBAgIQyzsBWwgxaIRDy/VbxwNwLjAJBgUrDgMCHQUA
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
# 6PjyT6vSVoj9wA8KYNxQ0bPVIJswDQYJKoZIhvcNAQEBBQAEgYACzLfROrhjHwaw
# FhwK1x3rhspcN2BRFLc0M1JZCISsNuyltWAcXlxz+AeGSjhIa0/whFnEg+XEfvgw
# etoksO6bLscTnECFpGixKXqxcs3RMalpyHcu6UkHh28u1EJuUEsTbNIhvMXh3q2t
# +K+SQjQKFRO6tsYiDJG0vKYL+qfGmqGCAgswggIHBgkqhkiG9w0BCQYxggH4MIIB
# 9AIBATByMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBD
# QSAtIEcyAhAOz/Q4yP6/NW4E2GqYGxpQMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0B
# CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNjA2MzAxMzQ4NDlaMCMG
# CSqGSIb3DQEJBDEWBBRlBbHyQBB4isKY7Xw+mXq6e2g9jjANBgkqhkiG9w0BAQEF
# AASCAQCblSy5zzWr/LNS1DpGarmezZQ8MpAJVXindbmepwu4YZkyTvx02ABarxfC
# yn1ZGlq8LUWuAoPU/Kci9kL3xDlwQNRS1rYeuloD15XC9DryHTAprqtcHBqOO4La
# heIuccInr38tUUItaW71dBDL80y18OdHundBea8z8uDiFXs/AfWaUrtdADvmvCJm
# uy4t7LJBErEhCp8dsKXU5Sl5RmM1mGqZ7hSJ8XDhTHHfE8udZXhn8sg/BkQ7fIc3
# uYXeyZYVD6tiR8HnUM4h5rq4RLxh1bJRhoY2aH04nWsVbe8BFQ2c7Pg2/Q9LupYC
# MbEO4/exYvJJ8726UC6o40nAr3SC
# SIG # End signature block
