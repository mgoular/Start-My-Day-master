  #Content
  
  # Starts OneNote Online
  Start-Process -FilePath Chrome -ArgumentList https://www.onenote.com/hrd
  Write-Host "One Note Online will be ready soon" -ForegroundColor Yellow
  Start-Sleep -s 5
  
  # Starts ARS  
  Start-Process -FilePath Chrome -ArgumentList https://arserver.nike.com/ARServerAdmin/default.aspx
  Write-Host "ARS will be ready soon" -ForegroundColor Green
  Start-Sleep -s 5
  
  # Starts AD Tools
  Start-Process -FilePath Chrome -ArgumentList http://adtools.nike.com/
  Write-Host "AD Tools will be ready soon" -ForegroundColor Yellow
  Start-Sleep -s 5
  
  # Starts outlook  
  Start-Process -FilePath outlook.exe
  Write-Host "Outlook email will be ready soon" -ForegroundColor Green
  Start-Sleep -s 5
    
  # Starts a PowerShell process with "Run as Administrator" permissions.  
  Start-Process -FilePath "powershell.exe"
  Write-Host "Please click yes so Powershell will ran with highest priviledges" -ForegroundColor Yellow
  Start-Sleep -s 5
  
  
  # Starts a DSA process with "Run as Administrator" permissions.  
  Start-Process -FilePath "dsa.msc"
  Write-Host "Please click yes so DSA will ran with highest priviledges" -ForegroundColor Green
  Start-Sleep -s 5

# Add a clock timer to your screen so you get your coffee 
Write-Host "Please click START and you have 3 minutes and 45 seconds to get your coffee" -ForegroundColor Red

function Show-Countdown {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	Add-Type -AssemblyName System.Windows.Forms
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$form1 = New-Object 'System.Windows.Forms.Form'
	$buttonStart = New-Object 'System.Windows.Forms.Button'
	$textbox1 = New-Object 'System.Windows.Forms.TextBox'
	$buttonOK = New-Object 'System.Windows.Forms.Button'
	$timer1 = New-Object 'System.Windows.Forms.Timer'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	$code = @'
using System;
using System.Drawing;
using System.Windows.Forms;

namespace Helper{
  public static class ControlMover{
    public enum Direction
    {
      Any,
      Horizontal,
      Vertical
    }

    public static void Init(Control control){
      Init(control, Direction.Any);
    }

    public static void Init(Control control, Direction direction){
      Init(control, control, direction);
    }

    public static void Init(Control control, Control container, Direction direction){
      bool Dragging = false;
      Point DragStart = Point.Empty;

      control.MouseDown += delegate(object sender, MouseEventArgs e){
        Dragging = true;
        DragStart = new Point(e.X, e.Y);
        control.Capture = true;
      };

      control.MouseUp += delegate(object sender, MouseEventArgs e){
        Dragging = false;
        control.Capture = false;
      };

      control.MouseMove += delegate(object sender, MouseEventArgs e){
        if (Dragging){
          if (direction != Direction.Vertical)
            container.Left = Math.Max(0, e.X + container.Left - DragStart.X);
          if (direction != Direction.Horizontal)
            container.Top = Math.Max(0, e.Y + container.Top - DragStart.Y);
        }
      };
    }
  }
}
'@
	Add-Type $code -referencedAssemblies System.Windows.Forms, System.Drawing
	
	$form1_Load={
		[Helper.ControlMover]::init($textbox1)
	}
	
	$1second=[timespan]'0:0:0:1'
	$timer1_Tick={
		$script:ts1=$ts1.Subtract($1second)
		Write-Host $ts1
		$textbox1.Text = $ts1.ToString('hh\:mm\:ss')
		if($ts1.Ticks -le 0){
			$timer1.Stop()
			$buttonStart.Enabled=$true
		}
	}
	
	$buttonStart_Click={
		$this.Enabled=$false
		$script:ts1 = [timespan]'0:0:3:45'
		$timer1.Start()
	}
	
	$textbox1_MouseCaptureChanged={
		Write-Host $textbox1.Capture
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$form1.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonStart.remove_Click($buttonStart_Click)
			$textbox1.remove_MouseCaptureChanged($textbox1_MouseCaptureChanged)
			$form1.remove_Load($form1_Load)
			$timer1.remove_Tick($timer1_Tick)
			$form1.remove_Load($Form_StateCorrection_Load)
			$form1.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$form1.SuspendLayout()
	#
	# form1
	#
	$form1.Controls.Add($buttonStart)
	$form1.Controls.Add($textbox1)
	$form1.Controls.Add($buttonOK)
	$form1.AcceptButton = $buttonOK
	$form1.AutoScaleDimensions = '8, 17'
	$form1.AutoScaleMode = 'Font'
	$form1.ClientSize = '616, 462'
	$form1.FormBorderStyle = 'FixedDialog'
	$form1.Margin = '5, 5, 5, 5'
	$form1.MaximizeBox = $False
	$form1.MinimizeBox = $False
	$form1.Name = 'GET YOUR COFFEE'
	$form1.StartPosition = 'CenterScreen'
	$form1.Text = 'GET YOUR COFFEE'
	$form1.add_Load($form1_Load)
	#
	# buttonStart
	#
	$buttonStart.Font = 'Microsoft Sans Serif, 15.75pt, style=Bold'
	$buttonStart.Location = '343, 93'
	$buttonStart.Margin = '4, 4, 4, 4'
	$buttonStart.Name = 'buttonStart'
	$buttonStart.Size = '150, 50'
	$buttonStart.TabIndex = 2
	$buttonStart.Text = ' Start '
	$buttonStart.UseCompatibleTextRendering = $True
	$buttonStart.UseVisualStyleBackColor = $True
	$buttonStart.add_Click($buttonStart_Click)
	#
	# textbox1
	#
	$textbox1.Font = 'Microsoft Sans Serif, 14.25pt, style=Bold'
	$textbox1.Location = '68, 93'
	$textbox1.Margin = '4, 4, 4, 4'
	$textbox1.Name = 'textbox1'
	$textbox1.Size = '200, 34'
	$textbox1.TabIndex = 1
	$textbox1.add_MouseCaptureChanged($textbox1_MouseCaptureChanged)
	#
	# buttonOK
	#
	$buttonOK.Anchor = 'Bottom, Right'
	$buttonOK.DialogResult = 'OK'
	$buttonOK.Location = '500, 416'
	$buttonOK.Margin = '4, 4, 4, 4'
	$buttonOK.Name = 'buttonOK'
	$buttonOK.Size = '100, 30'
	$buttonOK.TabIndex = 0
	$buttonOK.Text = '&OK'
	$buttonOK.UseCompatibleTextRendering = $True
	$buttonOK.UseVisualStyleBackColor = $True
	#
	# timer1
	#
	$timer1.Interval = 1000
	$timer1.add_Tick($timer1_Tick)
	$form1.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $form1.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$form1.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$form1.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $form1.ShowDialog()

} 

Show-Countdown





