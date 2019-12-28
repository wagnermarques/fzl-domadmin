strComputer = "." '(Any computer name or address)

Set wmi = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set wmiEvent = wmi.ExecNotificationQuery("select * from __InstanceOperationEvent within 1 where TargetInstance ISA 'Win32_PnPEntity' and TargetInstance.Description='USB Mass Storage Device'") 			
Set wshShell = WScript.CreateObject( "WScript.Shell" )




Function ReportFolderStatus(fldr)
   Dim fso
   msg = "ainda nao sei"
   
   Set fso = CreateObject("Scripting.FileSystemObject")
   If (fso.FolderExists(fldr)) Then
      'msg = fldr & " EXISTE!"
	  msg = "sim"
   Else
      'msg = fldr & " NAO EXISTE NO PENDRIVE!"
	  msg = "nao"
   End If
   ReportFolderStatus = msg
End Function

'Function temPeloMenosUmaPastaComMesmoNomeDeAtalho(strDriveLetter)
	'returnValue = "nao"
	
	'SETTING RETURN FNC VALUE
	'if returnValue = "sim" Then
	'	temPeloMenosUmaPastaComMesmoNomeDeAtalho = "sim"
	'else
		'temPeloMenosUmaPastaComMesmoNomeDeAtalho = "nao"
	'End if	
'	
'End Function	


Function temPastaRECICLER(strDriveLetter)
	
	
	WScript.Echo "Verificando se o pendrive" & strDriveLetter & "tem Pasta RECICLER" 
	
	
	'SETTING RETURN FNC VALUE
	if ReportFolderStatus(strDriveLetter & "\RECYCLER") = "sim" Then
		temPastaRECICLER = "sim"
	else
		temPastaRECICLER = "nao"
	End if	
	
End Function	



Function recicle_virus_is_present(strDriveLetter)
	
	isPresent = "nao"
	temPastaRECICLER_Func = "nao"
	'TODO melhorar o algoritmo de detecao com isto... temPeloMenosUmaPastaComMesmoNomeDeAtalho_Func = "nao"
				
	
	
	'METODOS PARA OBTER INFORMACOES NECESSARIAS PARA DECIDIR SE O VIRUS EXISTE OU NAO
	temPastaRECICLER_Func = temPastaRECICLER(strDriveLetter)
	
	
	'DECISAO FINAL SE O VIRUS ESTA PRESENTE OU NAO...
	'TODO, da pra melhorar esse algoritmo, claro
	if temPastaRECICLER_Func = "sim" Then
		isPresent = "sim"
	else 
		isPresent = "nao"
	End if
	
	
	'SETTING RETURN FNC VALUE
	if isPresent = "sim" Then
		recicle_virus_is_present = "sim"
	else
		recicle_virus_is_present = "nao"
	End if	
	
End Function	




Function remove_recycler_virus(strDriveLetter)
	wshShell.run "ATTRIB  -S  -R  -H  /D /S "& strDriveLetter
	wshShell.run "rd /q /s " & strDriveLetter & "\RECYCLER"
End Function




While True

	Set objEvent = wmiEvent.NextEvent()
	
	Select Case objEvent.Path_.Class
	
		Case "__InstanceCreationEvent" 	
			
			Message0 = "Voce conectou um pendrive na unidade !." 


			Message1 = "Deseja detectar o virus RECICLER?!." & vbCr & vbCr _
			& "O virus RECICLER e aquele que transforma suas pastas em atalhos"  & vbCr  & vbCr _
			& "e voce fica pensando que as pastas foram apagadas."	& vbCr  & vbCr _
			& "Qualquer duvida sobre essa acao comunique-se com seu gerente com com ramal 4059 do NSI." 

			'M1 = MsgBox(Message, vbYesNo + vbInformation, "AVISO DO NSI - Nucleo de Suporte a Informatica")		
			M1 = MsgBox(Message1, vbYesNo + vbInformation, "AVISO DO NSI - Nucleo de Suporte a Informatica")
						
			
			If M1 = vbYes Then
				WScript.Echo("Voce escolheu DETECTAR o virus RECICLER! Clique em OK para comecar! ")								
				MsgAlerta = "PARA ESSA OPERACAO FUNCIONAR..." & vbCr & vbCr _
				& "VOCE PRECISA TER APENAS UM PENDRIVE ESPETADO NA MAQUINA..."  & vbCr  & vbCr _
				& "SE VOCE TIVER MAIS DE UM,   R E M O V A   T O D O S   E REPITA A OPERACAO..."	& vbCr  & vbCr _
				& "ESPETANDO UM DE CADA VEZ E LIMPANDO!"	& vbCr  & vbCr _
				& "--------------------------------------"	& vbCr  & vbCr _
				& "Qualquer duvida sobre essa acao comunique-se com seu gerente com com ramal 4059 do NSI."	& vbCr  & vbCr _
				& "DESEJA CONTINUAR?"				


				MsgAlerta = MsgBox(MsgAlerta, vbYesNo + vbInformation, "AVISO DO NSI - Nucleo de Suporte a Informatica")
				if MsgAlerta = vbNo Then 
					WScript.Echo "Ok nenhuma acao foi realizada"					
				else									
					'AQUI O USUARIO DESEJA CONTINUAR COM A DETECCAO...
					Set objUSB = objEvent.TargetInstance
					strName = objUSB.Name
					strDeviceID = objUSB.DeviceID
	
					Set colDrives = wmi.ExecQuery("Select * From Win32_LogicalDisk Where DriveType = 2")
	
					For Each objDrive in colDrives
						strDriveLetter = objDrive.DeviceID
					Next
					Set colDrives = Nothing

					
					WScript.Echo strName & " was mounted as " & strDriveLetter				
					
					if recicle_virus_is_present(strDriveLetter)	= "sim" Then
						'E O VIRUS FOI DETECTADO
						WScript.Echo "O virus RECICLER  F O I   Detectado neste pendrive e sera removido"
						remove_recycler_virus(strDriveLetter)
						WScript.Echo "removido"
					else
						'AQUI O USUARIO DESEJOU CONTINUAR COM A DETECAO
						'E O VIRUS NAO FOI DETECTADO
						WScript.Echo "O virus RECICLER NAO FOI Detectado neste pendrive"
					End If
						
					
					'AQUI O USUARIO DESEJOU CONTINUAR COM A DETECCAO...	
				End if							
			else	
				WScript.Echo("Voce escolheu NAO DETECTAR o virus RECICLER! Nenhuma acao sera realizada!")
			End If
	Case "__InstanceDeletionEvent" WScript.Echo("USB device removed")
	Case "__InstanceModificationEvent" WScript.Echo("USB device modified")
End Select

Wend


