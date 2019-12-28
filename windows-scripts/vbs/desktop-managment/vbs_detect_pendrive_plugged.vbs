

strComputer = "." '(Any computer name or address)

Set wmi = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set wmiEvent = wmi.ExecNotificationQuery("select * from __InstanceOperationEvent within 1 where TargetInstance ISA 'Win32_PnPEntity' and TargetInstance.Description='USB Mass Storage Device'") 
Set wshShell = WScript.CreateObject( "WScript.Shell" )





strUserName = wshShell.ExpandEnvironmentStrings( "%USERNAME%" )

Wscript.Echo("Controle de seguranca de pendrives acionado...")

While True
	Set usb = wmiEvent.NextEvent()

	Select Case usb.Path_.Class
		Case "__InstanceCreationEvent" 	

		if strUserName = "outronaoautorizado" then
			WScript.Echo "voce, " & strUserName & ", esta autorizado a usar pendrives"			
			WSHShell.RegWrite "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR\Start",3 ,"REG_DWORD"
			Set WSHShell = nothing
		else 
			Message = "SCRIPT DE PROTECAO DA REDE DO IPGG: USO DE PENDRIVES RESTRITO!." & vbCr & vbCr _
			& "Qualquer duvida sobre essa acao comunique-se com seu gerente com com ramal 4059 do NSI." & vbCr  & vbCr _
			& "Por motivos de protecao contra virus, a utilizacao de pendrives fica restrita a"  & vbCr  & vbCr _
			& "usuarios autorizados. Obrigado."	
			
			'M = MsgBox(Message, vbYesNo + vbInformation, "AVISO DO NSI - Nucleo de Suporte a Informatica")		
			M = MsgBox(Message, vbOk + vbInformation, "AVISO DO NSI - Nucleo de Suporte a Informatica")
			
			WSHShell.RegWrite "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR\Start",4 ,"REG_DWORD"
							   
			Set WSHShell = nothing
		End If
	

	Case "__InstanceDeletionEvent" WScript.Echo("USB device removed")
	Case "__InstanceModificationEvent" WScript.Echo("USB device modified")
End Select

Wend


Function Password( myPrompt )
	Dim objPassword
	' Use ScriptPW.dll by creating an object
	Set objPassword = CreateObject( "ScriptPW.Password" )
		' Display the prompt text
	WScript.StdOut.Write myPrompt

	' Return the typed password
	Password = objPassword.GetPassword()

	' Clear prompt
	WScript.StdOut.Write String( Len( myPrompt ), Chr( 8 ) ) _
					& Space( Len( myPrompt ) ) _
					& String( Len( myPrompt ), Chr( 8 ) )
End Function

Function inserIsInPendriveAutorizedGroup (user)

		'TODO ver se o strUserName faz parte dos usuarios do grupo usuario_que_podem_usar_pendrives
		'http://www.activexperts.com/activmonitor/windowsmanagement/adminscripts/usersgroups/groups/#EnumGroupmembership.htm
		
End Function




