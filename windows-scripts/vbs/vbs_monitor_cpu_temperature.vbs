On Error Resume Next 

strComputer = "." 

Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\WMI") 


Set colItems = objWMIService.ExecQuery( _ 
"SELECT * FROM MSAcpi_ThermalZoneTemperature",,48) 

Set objInstances = objWMI.InstancesOf("MSAcpi_ThermalZoneTemperature",48)




For Each objInstance in objInstances
   WScript.Echo objInstance.getObjectText_
Next

For Each objInstance in objInstances
    With objInstance
        WScript.Echo .Active
        WScript.Echo Join(.ActiveTripPoint, ", ")
        WScript.Echo .ActiveTripPointCount
        WScript.Echo .CriticalTripPoint
        WScript.Echo .CurrentTemperature
        WScript.Echo .InstanceName
        WScript.Echo .PassiveTripPoint
        WScript.Echo .Reserved
        WScript.Echo .SamplingPeriod
        WScript.Echo .ThermalConstant1
        WScript.Echo .ThermalConstant2
        WScript.Echo .ThermalStamp
    End With
Next




'For Each objItem in colItems 
'
'    Wscript.Echo "-----------------------------------" 
'    Wscript.Echo "MSAcpi_ThermalZoneTemperature instance" 
'    Wscript.Echo "-----------------------------------" 
'    Wscript.Echo "CurrentTemperature: " & objItem.CurrentTemperature 
'    Wscript.Echo "CurrentTemperature: " & objItem.CriticalTripPoint 
'    Wscript.Echo "CurrentTemperature: " & objItem.ThermalStamp '
'
'Next