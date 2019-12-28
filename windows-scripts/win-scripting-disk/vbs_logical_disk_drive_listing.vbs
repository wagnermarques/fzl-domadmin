strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colDisks = objWMIService.ExecQuery _
    ("Select * from Win32_LogicalDisk")
For each objDisk in colDisks
    Wscript.Echo "Compressed: " & vbTab &  objDisk.Compressed  
    Wscript.Echo "Description: " & vbTab &  objDisk.Description       
    Wscript.Echo "DeviceID: " & vbTab &  objDisk.DeviceID      
    Wscript.Echo "DriveType: " & vbTab &  objDisk.DriveType    
    Wscript.Echo "FileSystem: " & vbTab &  objDisk.FileSystem  
    Wscript.Echo "FreeSpace: " & vbTab &  objDisk.FreeSpace    
    Wscript.Echo "MediaType: " & vbTab &  objDisk.MediaType    
    Wscript.Echo "Name: " & vbTab &  objDisk.Name      
    Wscript.Echo "QuotasDisabled: " & vbTab &  objDisk.QuotasDisabled
    Wscript.Echo "QuotasIncomplete: " & vbTab &  objDisk.QuotasIncomplete
    Wscript.Echo "QuotasRebuilding: " & vbTab &  objDisk.QuotasRebuilding
    Wscript.Echo "Size: " & vbTab &  objDisk.Size      
    Wscript.Echo "SupportsDiskQuotas: " & vbTab & _
        objDisk.SupportsDiskQuotas      
    Wscript.Echo "SupportsFileBasedCompression: " & vbTab & _
        objDisk.SupportsFileBasedCompression   
    Wscript.Echo "SystemName: " & vbTab &  objDisk.SystemName  
    Wscript.Echo "VolumeDirty: " & vbTab &  objDisk.VolumeDirty       
    Wscript.Echo "VolumeName: " & vbTab &  objDisk.VolumeName  
    Wscript.Echo "VolumeSerialNumber: " & vbTab &  _
        objDisk.VolumeSerialNumber      
Next