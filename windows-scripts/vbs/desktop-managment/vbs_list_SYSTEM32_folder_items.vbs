' List Items in the System32 Folder


Const SYSTEM32 = &H25&
Dim objShell
Set objShell = CreateObject("Shell.Application")
Set objFolder = objShell.Namespace(SYSTEM32)
Set objFolderItem = objFolder.Self

WScript.Echo objFolderItem.Path




'Value	Meaning
Open_the_application_with_a_hidden_window = 0 
'If the window is minimized or maximized, 
'the system restores it to its original size and position.
Open_the_application_with_a_normal_window = 1 
Open_the_application_with_a_minimized_window = 2 
Open_the_application_with_a_maximized_window = 3 
'The active window remains active.
Open_the_application_with_its_window_at_its_most_recent_size_and_position = 4 
Open_the_application_with_its_window_at_its_current_size_and_position =  5 
'The active window remains active.
Open_the_application_with_a_minimized_window = 7 
Open_the_application_with_a_minimized_its_window_in_the_default_state_specified_by_the_application = 10 



'ShellExecute method
'Run a script or application in the Windows Shell.
'Syntax
'.ShellExecute "application", "parameters", "dir", "verb", window	
'.ShellExecute 'some program.exe', '"some parameters with spaces"', , "runas", 1
'objShell.ShellExecute "notepad.exe", "", "", "open", 5
objShell.ShellExecute "attrib", "", "", "open", 5
'objShell.ShellExecute "cscript.exe", objItem.Name, "", "runas", SAME_WINDOW	
       

Set colItems = objFolder.Items
For Each objItem in colItems
    
    'If objItem.Name = "attrib" Then
    If objItem.Name = "" Then
     Wscript.Echo objItem.Name
     
    End If
    
Next
set objShell = Nothing
