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