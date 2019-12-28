

strComputer = "." '(Any computer name or address)

Set wmi = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set wmiEvent = wmi.ExecNotificationQuery("select * from __InstanceOperationEvent within 1 where TargetInstance ISA 'Win32_PnPEntity' and TargetInstance.Description='USB Mass Storage Device'") 
Set wshShell = WScript.CreateObject( "WScript.Shell" )

WSHShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR\Start",4 ,"REG_DWORD"
Set WSHShell = nothing
