'Disable CD Auto Run in XP Home

Dim WshShell, ObjShell,  Message

Set WshShell = WScript.CreateObject("WScript.Shell")

If WScript.Arguments.length = 0 Then
	Set ObjShell = CreateObject("Shell.Application")
	ObjShell.ShellExecute "wscript.exe", """" & _
	WScript.ScriptFullName & """" & " uac","", "runas", 1
Else

Message = "This script will Disable CD Auto Run." & vbCr & vbCr _
 & "To work correctly, the script will Close and restart the Windows Explorer shell.  This will harm you computer." & vbCr  & vbCr _
 & "If you do not trust the source of this information, do not add it to the registry."  & vbCr  & vbCr _
 & "Would you like to continue?"

M = MsgBox(Message, vbYesNo + vbInformation, "Paul's XP, Vista and Windows 7 Tweaks")
If M = 6 Then 

WshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoDriveTypeAutoRun", 181, "REG_DWORD"

For Each Process in GetObject("winmgmts:"). _
ExecQuery ("select * from Win32_Process where name='explorer.exe'")
Process.terminate(0)

Next

Message = "CD AutoRun is now Disabled!" & vbCr & vbCr _
 & "This script was downloaded from www.paulsxp.com." 
MsgBox Message, 64, "Paul's XP, Vista and Windows 7 Tweaks"
End If
 End If