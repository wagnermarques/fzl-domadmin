Dim WshShell, BtnCode

Set WshShell = WScript.CreateObject("WScript.Shell")
Set objArgs = WScript.Arguments

if objArgs.Count>0 then
BtnCode = WshShell.Popup("Do you want to decode those files?", 10, "Answer This Question:", 1 + 32)
Select Case BtnCode
   case 1
        WScript.echo "This script will decode " & objArgs.Count & " *.asp
files in the same directory as itself and create a Decoded folder. If the
script fails be sure you have scrdec14.exe in the same directory."
        call decode_arg
   case 2
        WScript.Echo "Action canceled."
   case -1
        WScript.Echo "Is there anybody out there?"
End Select
else
BtnCode = WshShell.Popup("Do you want to decode all the *.asp files?", 10, "Answer This Question:", 1 + 32)
Select Case BtnCode
   case 1
        WScript.echo "This script will decode all *.asp files in the same
directory as itself and create a Decoded folder. If the script fails be sure
you have scrdec14.exe in the same directory."
        call decode_all
   case 2
        WScript.Echo "Action canceled."
   case -1
        WScript.Echo "Is there anybody out there?"
End Select
end if

sub decode_all()
Set fs = CreateObject("Scripting.FileSystemObject")
Set WshShell = WScript.CreateObject("WScript.Shell")
Set folder1 = fs.GetFolder(Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\")))
If Not fs.folderexists(Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\")) & "Decoded") Then
Set folder2 = fs.createfolder("Decoded")
End If
For Each FileName In folder1.Files
  If InStr(UCase(FileName.Name), ".ASP") Then
    intReturn = WshShell.Run("cmd /c scrdec14 " & FileName.Name & " Decoded\" & FileName.Name, 7, False)
  End If
Next
end sub

sub decode_arg()
Set fs = CreateObject("Scripting.FileSystemObject")
Set WshShell = WScript.CreateObject("WScript.Shell")

If Not fs.folderexists(Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\")) & "Decoded") Then
Set folder2 = fs.createfolder("Decoded")
End If
For I = 0 to objArgs.Count - 1
intReturn = WshShell.Run("cmd /c scrdec14 " & objArgs(I) & " Decoded\" & objArgs(I), 7, False)
Next
end sub

