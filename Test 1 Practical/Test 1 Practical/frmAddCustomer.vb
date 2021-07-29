Public Class frmAddCustomer
    Private Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        ' loop through the textboxes and check to make sure there is data in them
        For Each cntrl As Control In CustomerInfo.Controls
            If TypeOf cntrl Is TextBox Then
                cntrl.Text = String.Empty
            End If
        Next

        txtFirstName.Focus()
    End Sub

    Private Sub btnExit_Click(sender As Object, e As EventArgs) Handles btnExit.Click
        ' Exits the form 
        Me.Close()
    End Sub

    Private Sub btnAddCustomer_Click(sender As Object, e As EventArgs) Handles btnAddCustomer.Click
        ' variables for new player data and select and insert statements
        Dim strSelect As String = ""
        Dim strInsert As String = ""
        Dim strFirstName As String = ""
        Dim strLastName As String = ""
        Dim strAddress As String = ""
        Dim strCity As String = ""
        Dim strState As String = ""
        Dim strZip As String = ""
        Dim strLoyaltyCard As String = ""

        Dim cmdSelect As OleDb.OleDbCommand         ' select command object
        Dim cmdInsert As OleDb.OleDbCommand         ' insert command object
        Dim drSourceTable As OleDb.OleDbDataReader  ' data reader for pulling info
        Dim intNextHighestRecordID As Integer       ' holds next highest PK value
        Dim intRowsAffected As Integer              ' how many rows were affected when sql executed

        Try

            ' validate data is entered
            If Validation() = True Then

                ' put values into strings
                strFirstName = txtFirstName.Text
                strLastName = txtLastName.Text
                strAddress = txtAddress.Text
                strCity = txtCity.Text
                strState = txtState.Text
                strZip = txtZip.Text
                strLoyaltyCard = txtLoyaltyCard.Text


                If OpenDatabaseConnectionSQLServer() = False Then

                    ' No, warn the user ...
                    MessageBox.Show(Me, "Database connection error." & vbNewLine &
                                            "The application will now close.",
                                            Me.Text + " Error",
                                            MessageBoxButtons.OK, MessageBoxIcon.Error)

                    ' and close the form/application
                    Me.Close()

                End If

                strSelect = "SELECT MAX(intCustomerID) + 1 AS intNextHighestRecordID " &
                                " FROM TCustomers"

                ' Execute command
                cmdSelect = New OleDb.OleDbCommand(strSelect, m_conAdministrator)
                drSourceTable = cmdSelect.ExecuteReader

                ' Read result( highest ID )
                drSourceTable.Read()

                ' Null? (empty table)
                If drSourceTable.IsDBNull(0) = True Then

                    ' Yes, start numbering at 1
                    intNextHighestRecordID = 1

                Else

                    ' No, get the next highest ID
                    intNextHighestRecordID = CInt(drSourceTable.Item(0))

                End If
                ' build insert statement (columns must match DB columns in name and the # of columns)
                strInsert = "Insert into TCustomers (intCustomerID, strFirstName, strLastName, strAddress, strCity, strState, strZip, strLoyaltyCard)" &
                        " Values (" & intNextHighestRecordID & ",'" & strFirstName & "'," & "'" & strLastName & "'," & "'" & strAddress & "'," & "'" & strCity & "'," & "'" & strState & "'," &
                        "'" & strZip & "'," & "'" & strLoyaltyCard & "'" & ")"

                ' use insert command with sql string and connection object
                cmdInsert = New OleDb.OleDbCommand(strInsert, m_conAdministrator)

                ' execute query to insert data
                intRowsAffected = cmdInsert.ExecuteNonQuery()

                ' If not 0 insert successful
                If intRowsAffected > 0 Then
                    MessageBox.Show("Customer has been added")    ' let user know success
                    CloseDatabaseConnection()                     ' close DB connection
                    Close()                                       ' close new player form
                End If



                CloseDatabaseConnection()       ' close connection if insert didn't work

            End If

        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try
    End Sub

    Public Function Validation() As Boolean
        ' loop through the textboxes and check to make sure there is data in them
        For Each cntrl As Control In CustomerInfo.Controls
            If TypeOf cntrl Is TextBox Then
                cntrl.BackColor = Color.White
                If cntrl.Text = String.Empty Then
                    cntrl.BackColor = Color.Yellow
                    cntrl.Focus()
                    ' MessageBox.Show("Something is blank! ")
                    Return False
                End If
            End If
        Next

        'every this is good so return true
        Return True
    End Function

    Private Sub ExitToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ExitToolStripMenuItem.Click
        btnExit_Click(sender, e)
    End Sub

    Private Sub ClearToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ClearToolStripMenuItem.Click
        btnClear_Click(sender, e)
    End Sub

    Private Sub UpdateInfoToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles UpdateInfoToolStripMenuItem.Click
        btnAddCustomer_Click(sender, e)
    End Sub
End Class