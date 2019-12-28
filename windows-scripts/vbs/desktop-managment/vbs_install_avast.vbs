'Small Vbscript to silently install Malwarebytes
On Error Resume Next  

ObjShell.popup "Sera instalado o software malwarebytes.  Duvidas , contactar ramal 4059."

exePath = "C:\Users\wagner\Downloads\avast_free_antivirus_setup.exe"
set objShell=wscript.createObject("wscript.shell")
ObjShell.Run("cmd.exe /c" & exePath & " /VERYSILENT /NORESTART /SP- /'Chrome'='false'")  
				 
'If err.number<>0 then
'	WScript.Echo ("A Instalacao falhou, favor avisar NSI, ramal 4059. Provavelmente o software Avast ja esteja instalado.") 
'	Wscript.Quit 1001
'Else 
'	WScript.Echo ("Instalacao realizada com sucesso")
'	Wscript.Quit 0
'End If  
