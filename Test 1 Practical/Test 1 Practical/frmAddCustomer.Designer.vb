<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmAddCustomer
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.btnAddCustomer = New System.Windows.Forms.Button()
        Me.btnExit = New System.Windows.Forms.Button()
        Me.CustomerInfo = New System.Windows.Forms.GroupBox()
        Me.txtFirstName = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txtLastName = New System.Windows.Forms.TextBox()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.txtLoyaltyCard = New System.Windows.Forms.TextBox()
        Me.txtAddress = New System.Windows.Forms.TextBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.txtZip = New System.Windows.Forms.TextBox()
        Me.txtCity = New System.Windows.Forms.TextBox()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.txtState = New System.Windows.Forms.TextBox()
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.FileToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ExitToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ProjectToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.UpdateInfoToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.btnClear = New System.Windows.Forms.Button()
        Me.ClearToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.CustomerInfo.SuspendLayout()
        Me.MenuStrip1.SuspendLayout()
        Me.SuspendLayout()
        '
        'btnAddCustomer
        '
        Me.btnAddCustomer.Location = New System.Drawing.Point(12, 268)
        Me.btnAddCustomer.Name = "btnAddCustomer"
        Me.btnAddCustomer.Size = New System.Drawing.Size(96, 52)
        Me.btnAddCustomer.TabIndex = 36
        Me.btnAddCustomer.Text = "&Add Customer"
        Me.btnAddCustomer.UseVisualStyleBackColor = True
        '
        'btnExit
        '
        Me.btnExit.Location = New System.Drawing.Point(320, 270)
        Me.btnExit.Name = "btnExit"
        Me.btnExit.Size = New System.Drawing.Size(96, 52)
        Me.btnExit.TabIndex = 34
        Me.btnExit.Text = "E&xit"
        Me.btnExit.UseVisualStyleBackColor = True
        '
        'CustomerInfo
        '
        Me.CustomerInfo.Controls.Add(Me.txtFirstName)
        Me.CustomerInfo.Controls.Add(Me.Label1)
        Me.CustomerInfo.Controls.Add(Me.txtLastName)
        Me.CustomerInfo.Controls.Add(Me.Label6)
        Me.CustomerInfo.Controls.Add(Me.Label2)
        Me.CustomerInfo.Controls.Add(Me.txtLoyaltyCard)
        Me.CustomerInfo.Controls.Add(Me.txtAddress)
        Me.CustomerInfo.Controls.Add(Me.Label7)
        Me.CustomerInfo.Controls.Add(Me.Label4)
        Me.CustomerInfo.Controls.Add(Me.txtZip)
        Me.CustomerInfo.Controls.Add(Me.txtCity)
        Me.CustomerInfo.Controls.Add(Me.Label8)
        Me.CustomerInfo.Controls.Add(Me.Label3)
        Me.CustomerInfo.Controls.Add(Me.txtState)
        Me.CustomerInfo.Location = New System.Drawing.Point(12, 31)
        Me.CustomerInfo.Name = "CustomerInfo"
        Me.CustomerInfo.Size = New System.Drawing.Size(404, 231)
        Me.CustomerInfo.TabIndex = 31
        Me.CustomerInfo.TabStop = False
        Me.CustomerInfo.Text = "Customer Info"
        '
        'txtFirstName
        '
        Me.txtFirstName.Location = New System.Drawing.Point(161, 26)
        Me.txtFirstName.Name = "txtFirstName"
        Me.txtFirstName.Size = New System.Drawing.Size(180, 22)
        Me.txtFirstName.TabIndex = 0
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(71, 29)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(84, 17)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "First Name: "
        '
        'txtLastName
        '
        Me.txtLastName.Location = New System.Drawing.Point(161, 54)
        Me.txtLastName.Name = "txtLastName"
        Me.txtLastName.Size = New System.Drawing.Size(180, 22)
        Me.txtLastName.TabIndex = 2
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(6, 197)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(149, 17)
        Me.Label6.TabIndex = 13
        Me.Label6.Text = "Loyalty Card Number: "
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(71, 57)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(84, 17)
        Me.Label2.TabIndex = 3
        Me.Label2.Text = "Last Name: "
        '
        'txtLoyaltyCard
        '
        Me.txtLoyaltyCard.Location = New System.Drawing.Point(161, 194)
        Me.txtLoyaltyCard.Name = "txtLoyaltyCard"
        Me.txtLoyaltyCard.Size = New System.Drawing.Size(180, 22)
        Me.txtLoyaltyCard.TabIndex = 12
        '
        'txtAddress
        '
        Me.txtAddress.Location = New System.Drawing.Point(161, 82)
        Me.txtAddress.Name = "txtAddress"
        Me.txtAddress.Size = New System.Drawing.Size(180, 22)
        Me.txtAddress.TabIndex = 4
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(82, 169)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(73, 17)
        Me.Label7.TabIndex = 11
        Me.Label7.Text = "Zip Code: "
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(45, 85)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(110, 17)
        Me.Label4.TabIndex = 5
        Me.Label4.Text = "Street Address: "
        '
        'txtZip
        '
        Me.txtZip.Location = New System.Drawing.Point(161, 166)
        Me.txtZip.Name = "txtZip"
        Me.txtZip.Size = New System.Drawing.Size(180, 22)
        Me.txtZip.TabIndex = 10
        '
        'txtCity
        '
        Me.txtCity.Location = New System.Drawing.Point(161, 110)
        Me.txtCity.Name = "txtCity"
        Me.txtCity.Size = New System.Drawing.Size(180, 22)
        Me.txtCity.TabIndex = 6
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(106, 141)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(49, 17)
        Me.Label8.TabIndex = 9
        Me.Label8.Text = "State: "
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(116, 113)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(39, 17)
        Me.Label3.TabIndex = 7
        Me.Label3.Text = "City: "
        '
        'txtState
        '
        Me.txtState.Location = New System.Drawing.Point(161, 138)
        Me.txtState.Name = "txtState"
        Me.txtState.Size = New System.Drawing.Size(180, 22)
        Me.txtState.TabIndex = 8
        '
        'MenuStrip1
        '
        Me.MenuStrip1.ImageScalingSize = New System.Drawing.Size(20, 20)
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.FileToolStripMenuItem, Me.ProjectToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(443, 28)
        Me.MenuStrip1.TabIndex = 35
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'FileToolStripMenuItem
        '
        Me.FileToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ExitToolStripMenuItem})
        Me.FileToolStripMenuItem.Name = "FileToolStripMenuItem"
        Me.FileToolStripMenuItem.Size = New System.Drawing.Size(46, 24)
        Me.FileToolStripMenuItem.Text = "File"
        '
        'ExitToolStripMenuItem
        '
        Me.ExitToolStripMenuItem.Name = "ExitToolStripMenuItem"
        Me.ExitToolStripMenuItem.Size = New System.Drawing.Size(224, 26)
        Me.ExitToolStripMenuItem.Text = "Exit"
        '
        'ProjectToolStripMenuItem
        '
        Me.ProjectToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.UpdateInfoToolStripMenuItem, Me.ClearToolStripMenuItem})
        Me.ProjectToolStripMenuItem.Name = "ProjectToolStripMenuItem"
        Me.ProjectToolStripMenuItem.Size = New System.Drawing.Size(69, 24)
        Me.ProjectToolStripMenuItem.Text = "Project"
        '
        'UpdateInfoToolStripMenuItem
        '
        Me.UpdateInfoToolStripMenuItem.Name = "UpdateInfoToolStripMenuItem"
        Me.UpdateInfoToolStripMenuItem.Size = New System.Drawing.Size(224, 26)
        Me.UpdateInfoToolStripMenuItem.Text = "Add  Customer"
        '
        'btnClear
        '
        Me.btnClear.Location = New System.Drawing.Point(162, 268)
        Me.btnClear.Name = "btnClear"
        Me.btnClear.Size = New System.Drawing.Size(96, 52)
        Me.btnClear.TabIndex = 37
        Me.btnClear.Text = "&Clear"
        Me.btnClear.UseVisualStyleBackColor = True
        '
        'ClearToolStripMenuItem
        '
        Me.ClearToolStripMenuItem.Name = "ClearToolStripMenuItem"
        Me.ClearToolStripMenuItem.Size = New System.Drawing.Size(224, 26)
        Me.ClearToolStripMenuItem.Text = "Clear"
        '
        'frmAddCustomer
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(443, 334)
        Me.Controls.Add(Me.btnClear)
        Me.Controls.Add(Me.btnAddCustomer)
        Me.Controls.Add(Me.btnExit)
        Me.Controls.Add(Me.CustomerInfo)
        Me.Controls.Add(Me.MenuStrip1)
        Me.Name = "frmAddCustomer"
        Me.Text = "New Customer"
        Me.CustomerInfo.ResumeLayout(False)
        Me.CustomerInfo.PerformLayout()
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnAddCustomer As Button
    Friend WithEvents btnExit As Button
    Friend WithEvents CustomerInfo As GroupBox
    Friend WithEvents txtFirstName As TextBox
    Friend WithEvents Label1 As Label
    Friend WithEvents txtLastName As TextBox
    Friend WithEvents Label6 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents txtLoyaltyCard As TextBox
    Friend WithEvents txtAddress As TextBox
    Friend WithEvents Label7 As Label
    Friend WithEvents Label4 As Label
    Friend WithEvents txtZip As TextBox
    Friend WithEvents txtCity As TextBox
    Friend WithEvents Label8 As Label
    Friend WithEvents Label3 As Label
    Friend WithEvents txtState As TextBox
    Friend WithEvents MenuStrip1 As MenuStrip
    Friend WithEvents FileToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents ExitToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents ProjectToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents UpdateInfoToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents btnClear As Button
    Friend WithEvents ClearToolStripMenuItem As ToolStripMenuItem
End Class
