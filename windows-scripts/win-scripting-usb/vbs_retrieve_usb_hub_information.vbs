On Error Resume Next
strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_USBHub")
For Each objItem in colItems
    Wscript.Echo "Configuration Manager Error Code: " & _
        objItem.ConfigManagerErrorCode
    Wscript.Echo "Configuration Manager User Configuration: " & _
        objItem.ConfigManagerUserConfig
    Wscript.Echo "Description: " & objItem.Description
    Wscript.Echo "Device ID: " & objItem.DeviceID
    Wscript.Echo "PNP Device ID: " & objItem.PNPDeviceID
    Wscript.Echo
Next