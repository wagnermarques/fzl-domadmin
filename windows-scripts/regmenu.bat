@echo off
set wopc=000
:w000
cls
title=MENU - ALTERACAO [ REGEDIT ]
COLOR 1e
MODE CON COLS=113 LINES=58
set wopc=000
rem @ipconfig /all | find "Endereço IP"
ECHO.
ECHO                                             SECRETARIA DE ESTADO DA SAUDE
ECHO                                             CIC - Centro de Informacao e Comunicacao
Echo                                             Autor: Kazuo - (11) 3065-4712
Echo                                             E-mail: ckazuo@saude.sp.gov.br
echo.

ECHO.
echo [ Nome do Computador: %COMPUTERNAME% ] [ UserName: %USERNAME% ] [ Dominio: %USERDOMAIN% ] [ %USERDNSDOMAIN% ]
ECHO [ Sist.Operacional..: %OS% ] [ Drive System: %SystemDrive% ] [ WinDir: %WinDir% ]
rem ECHO 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 
ECHO ================================================================================================================
echo  000-Fim (Reinicia Computador) ... 043-Desabilitar Cache para Thumbnails   086-.................................
echo  001-Pagina Inicial Internet...... 044-Otimizacao para o Cache de DNS      087-.................................
echo  002-Bloquear Painel de Controle.. 045-Remover Executar do Menu Iniciar    088-.................................
echo  003-Estilo clas. Painel Controle. 046-Esconder Relogio do Windows         089-.................................
echo  004-Bloquear alt. Papel Parede... 047-Limpar Arquivos Temporarios do IE   090-.................................
echo  005-Desab.Limpeza area Trabalho.. 048-Desab. Notific.Antivirus Desativado 091-.................................
echo  006-Remove Lixeira area Trabalho. 049-Desab. Notific.Firewall Desativado  092-.................................
echo  007-Remove Meus Doc.area Trabalho 050-Desab. Notific.Atual.Autom.Desativad093-.................................
echo  008-Remove Meu Compu.area Trabalho051-Desab. Auto-Run do CD-ROM           094-.................................
echo  009-Remove "Propr." Menu Meus Doc.052-Desab. Sistema Encriptacao Arquivos 095-.................................
echo  010-Remove "Propr." Menu Meu Comp.053-Desab. Mens.Notif.Espaco Disco Insuf096-.................................
echo  011-Remove "Propr." Menu Lixeira. 054-Desabilitar Beeps de Erros          097-.................................
echo  012-Ocultar Locais Rede-Desktop.. 055-Desabilitar Restauracao de Sistema  098-.................................
echo  013-Remover IE area Trabalho..... 056-Desabilitar Windows Messenger       099-.................................
echo  014-Nao altere caminho Meus Docum.057-Desabilita Firewall Windows XP      100-.................................
echo  015-Nao Permitir Compartilhamento 058-Mostrar Versao do Windows Desktop   101-.................................
echo  016-Remove LOGOFF Menu Iniciar..  059-Editar Inform. Registro do Windows  102-.................................
echo  017-Remove DESLIGAR Menu Iniciar  060-Alterar Diretorio do CD do Windows  103-.................................
echo  018-Nao manter Hist.Doc. Recente  061-Alt.Pasta Root [Padrao: C:\Windows] 104-.................................
echo  019-Limpar Hist.Doc.Recente sair  062-Alterar a Descricao do Computador   105-.................................
echo  020-Remove Menus Personalizados.  063-Habilitar Assistencia Remota        106-.................................
echo  021-Desativar Rastreamento Usuario064-Desocultar o Relogio do Windows     107-.................................
echo  022-Bloquear BARRA DE TAREFAS...  065-Ocultar o Relogio do Windows        108-.................................
echo  023-MENU INICIAR estilo Classico  066-Opc. IE-Desabilita Conexoes         109-.................................
echo  024-Remove dicas do MENU INICIAR  067-....................................110-.................................
echo  025-Nao Exibir "Bar.Fer.Pers."..  068-....................................111-.................................
echo  026-Desab.Atualiz.Autom. Windows  069-....................................112-.................................
echo  027-Remove [Ctrl+Alt+Del].......  070-....................................113-.................................
echo  028-Limpar Urls IE a cada 1 dia   071-....................................114-.................................
echo  029-Bloco de Notas Editor Html IE 072-....................................115-.................................
echo  030-Nao Permitir IE AutoCompletar 073-....................................116-.................................
echo  031-Habilitar o Bloqueio de Foco  074-....................................117-.................................
echo  032-Finalizacao Automatica tarefas075-....................................118-.................................
echo  033-Optimizacao no Boot.........  076-....................................119-.................................
echo  034-Ativar Num-Lock  no Windows.  077-....................................120-.................................
echo  035-Menu Iniciar Mais Rapido....  078-....................................121-Hab. Opcoes de Internet..........
echo  036-Descarrega DLLs inutil.Memoria079-....................................122-Des. Opcoes de Internet..........
echo  037-Qt Downloads Simultaneos IE.  080-....................................123-Hab. UAC.........................
echo  038-Aumentar a Taxa de Upload...  081-....................................124-Des. UAC.........................
echo  039-Limpeza de Disco Mais Eficaz  082-....................................125-Hab. Proxy.......................
echo  040-Limpar Arq.Troca Encerrar Win 083-....................................126-Des. Proxy.......................
echo  041-Otimizacao TCP/IP             084-....................................127-Des. Modem.......................
echo  042-Pesquisa Compupt. Mais Eficaz 085-....................................128-Hab. Modem.......................
ECHO ================================================================================================================
set /p wopc=                                  Digite opcao..: 

SET Wmenu=
if %wopc% equ	128	goto	w128
if %wopc% equ	127	goto	w127
if %wopc% equ	126	goto	w126
if %wopc% equ	125	goto	w125
if %wopc% equ	124	goto	w124
if %wopc% equ	123	goto	w123
if %wopc% equ	122	goto	w122
if %wopc% equ	121	goto	w121
if %wopc% equ	120	goto	w120
if %wopc% equ	119	goto	w119
if %wopc% equ	118	goto	w118
if %wopc% equ	117	goto	w117
if %wopc% equ	116	goto	w116
if %wopc% equ	115	goto	w115
if %wopc% equ	114	goto	w114
if %wopc% equ	113	goto	w113
if %wopc% equ	112	goto	w112
if %wopc% equ	111	goto	w111
if %wopc% equ	110	goto	w110
if %wopc% equ	109	goto	w109
if %wopc% equ	108	goto	w108
if %wopc% equ	107	goto	w107
if %wopc% equ	106	goto	w106
if %wopc% equ	105	goto	w105
if %wopc% equ	104	goto	w104
if %wopc% equ	103	goto	w103
if %wopc% equ	102	goto	w102
if %wopc% equ	101	goto	w101
if %wopc% equ	100	goto	w100
if %wopc% equ	099	goto	w099
if %wopc% equ	098	goto	w098
if %wopc% equ	097	goto	w097
if %wopc% equ	096	goto	w096
if %wopc% equ	095	goto	w095
if %wopc% equ	094	goto	w094
if %wopc% equ	093	goto	w093
if %wopc% equ	092	goto	w092
if %wopc% equ	091	goto	w091
if %wopc% equ	090	goto	w090
if %wopc% equ	089	goto	w089
if %wopc% equ	088	goto	w088
if %wopc% equ	087	goto	w087
if %wopc% equ	086	goto	w086
if %wopc% equ	085	goto	w085
if %wopc% equ	084	goto	w084
if %wopc% equ	083	goto	w083
if %wopc% equ	082	goto	w082
if %wopc% equ	081	goto	w081
if %wopc% equ	080	goto	w080
if %wopc% equ	079	goto	w079
if %wopc% equ	078	goto	w078
if %wopc% equ	077	goto	w077
if %wopc% equ	076	goto	w076
if %wopc% equ	075	goto	w075
if %wopc% equ	074	goto	w074
if %wopc% equ	073	goto	w073
if %wopc% equ	072	goto	w072
if %wopc% equ	071	goto	w071
if %wopc% equ	070	goto	w070
if %wopc% equ	069	goto	w069
if %wopc% equ	068	goto	w068
if %wopc% equ	067	goto	w067
if %wopc% equ	066	goto	w066
if %wopc% equ	065	goto	w065
if %wopc% equ	064	goto	w064
if %wopc% equ	063	goto	w063
if %wopc% equ	062	goto	w062
if %wopc% equ	061	goto	w061
if %wopc% equ	060	goto	w060
if %wopc% equ	059	goto	w059
if %wopc% equ	058	goto	w058
if %wopc% equ	057	goto	w057
if %wopc% equ	056	goto	w056
if %wopc% equ	055	goto	w055
if %wopc% equ	054	goto	w054
if %wopc% equ	053	goto	w053
if %wopc% equ	052	goto	w052
if %wopc% equ	051	goto	w051
if %wopc% equ	050	goto	w050
if %wopc% equ	049	goto	w049
if %wopc% equ	048	goto	w048
if %wopc% equ	047	goto	w047
if %wopc% equ	046	goto	w046
if %wopc% equ	045	goto	w045
if %wopc% equ	044	goto	w044
if %wopc% equ	043	goto	w043
if %wopc% equ	042	goto	w042
if %wopc% equ	041	goto	w041
if %wopc% equ	040	goto	w040
if %wopc% equ	039	goto	w039
if %wopc% equ	038	goto	w038
if %wopc% equ	037	goto	w037
if %wopc% equ	036	goto	w036
if %wopc% equ	035	goto	w035
if %wopc% equ	034	goto	w034
if %wopc% equ	033	goto	w033
if %wopc% equ	032	goto	w032
if %wopc% equ	031	goto	w031
if %wopc% equ	030	goto	w030
if %wopc% equ	029	goto	w029
if %wopc% equ	028	goto	w028
if %wopc% equ	027	goto	w027
if %wopc% equ	026	goto	w026
if %wopc% equ	025	goto	w025
if %wopc% equ	024	goto	w024
if %wopc% equ	023	goto	w023
if %wopc% equ	022	goto	w022
if %wopc% equ	021	goto	w021
if %wopc% equ	020	goto	w020
if %wopc% equ	019	goto	w019
if %wopc% equ	018	goto	w018
if %wopc% equ	017	goto	w017
if %wopc% equ	016	goto	w016
if %wopc% equ	015	goto	w015
if %wopc% equ	014	goto	w014
if %wopc% equ	013	goto	w013
if %wopc% equ	012	goto	w012
if %wopc% equ	011	goto	w011
if %wopc% equ	010	goto	w010
if %wopc% equ	009	goto	w009
if %wopc% equ	008	goto	w008
if %wopc% equ	007	goto	w007
if %wopc% equ	006	goto	w006
if %wopc% equ	005	goto	w005
if %wopc% equ	004	goto	w004
if %wopc% equ	003	goto	w003
if %wopc% equ	002	goto	w002
if %wopc% equ	001     goto	w001
if %wopc% equ	000	goto	fim

SET Wmenu=%wopc% NENHUMA OPCAO SELECIONADA!!! 
echo                                 %wmenu%
echo                                 %Wfim%
pause
goto w000

:w128
SET Wmenu=%wopc% Bloquear Modem
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Modem" /V Start /t REG_DWORD /d 4 /f
echo                                 %wmenu%
pause
goto w000

:w127
SET Wmenu=%wopc% Desbloquear Modem
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Modem" /V Start /t REG_DWORD /d 3 /f
echo                                 %wmenu%
pause
goto w000

:w126
SET Wmenu=%wopc% Desabilita Proxy!!! 
REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS"              /V ProxyEnable   /t REG_DWORD /D 00000000 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer   /t REG_SZ    /d "proxy.gov.br:3128" /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ    /d "<local;>" /f
rem REG ADD “HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings” /v ProxyOverride /d <local> /f
echo                                 %wmenu%
pause
goto w000

:w125
SET Wmenu=%wopc% Habilita Proxy!!! 
REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS"     /V ProxyEnable   /t REG_DWORD /D 00000001 /f
REG ADD "HKCU\Software\Policies\Microsoft\Inte rnet Explorer\Control Panel" /V ConnectionsTab /t REG_DWORD /d 0x00000001 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer   /t REG_SZ    /d "proxy.gov.br:3128" /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ    /d "<local;>" /f

echo                                 %wmenu%
pause
goto w000

:w124
SET Wmenu=%wopc% Desabilita UAC!!! 
ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
echo                                 %wmenu%
pause
goto w000

:w123
SET Wmenu=%wopc% Habilita UAC!!! 
ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
echo                                 %wmenu%
pause
goto w000

:w122
SET Wmenu=%wopc% Bloqueia Opcoes da Internet!!! 
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v NoBrowserOptions /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w121
SET Wmenu=%wopc% Desbloqueia Opcoes da Internet!!! 
REG ADD "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v NoBrowserOptions /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w120
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w119
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w118
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w117
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w116
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w115
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w114
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w113
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w112
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w111
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w110
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w109
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w108
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w107
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w106
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w105
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w104
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w103
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w102
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w101
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w100
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w099
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w098
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w097
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w096
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w095
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w094
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w093
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w092
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w091
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w090
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w089
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w088
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w087
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w086
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w085
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w084
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w083
pause
goto w000

:w082
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w081
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w080
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w079
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w078
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w077
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w076
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w075
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w074
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w073
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w072
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w071
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w070
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w069
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w068
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w067
SET Wmenu=%wopc% Opcao Selecionada Vazia!!! 

echo                                 %wmenu%
pause
goto w000

:w066
SET Wmenu=%wopc% Bloquear opcoes Internet - Desabilitar Conexoes
REG ADD "HKCU\Software\Policies\Microsoft\Inte rnet Explorer\Control Panel" /V ConnectionsTab /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w065
SET Wmenu=%wopc% Ocultar o Relogio do Windows
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v HideClock /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w064
SET Wmenu=%wopc% Desocultar o Relogio do Windows
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v HideClock /t REG_DWORD /d 0x00000000 /f
echo                                 %wmenu%
pause
goto w000

:w063
SET Wmenu=%wopc% Habilitar Assistencia Remota
REG ADD "HKLM\System\CurrentControlSet\Cont rol\Terminal Server" /v AllowTSConnections /t REG_DWORD /d 0x00000001 /f
REG ADD "HKLM\System\CurrentControlSet\Cont rol\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0x00000001 /f
REG ADD "HKLM\System\CurrentControlSet\Cont rol\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w062
SET Wmenu=%wopc% Alterar a Descricao do Computador
REG ADD "HKLM\System\CurrentControlSet\Serv ices\Lanmanserver\parameters" /v srvcomment /t REG_SZ /d descricao /f
echo                                 %wmenu%
pause
goto w000

:w061
SET Wmenu=%wopc% Alterar a Pasta Root do Sistema [Padrao: C:\Windows]
REG ADD "HKLM\Software\Microsoft\Window s NT\CurrentVersion" /v SystemRoot /t REG_SZ /d C:\Windows /f
echo                                 %wmenu%
pause
goto w000

:w060
SET Wmenu=%wopc% Alterar Diretorio do CD do Windows
REG ADD "HKLM\Software\Microsoft\Window s NT\CurrentVersion" /v SourcePath /t REG_SZ /d D:\I836 /f
echo                                 %wmenu%
pause
goto w000

:w059
SET Wmenu=%wopc% Editar as Informacoes de Registro do Windows
REG ADD "HKLM\Software\Microsoft\Window s NT\CurrentVersion" /v RegisteredOrganization /t REG_SZ /d CompanyNameHere /f
REG ADD "HKLM\Software\Microsoft\Window s NT\CurrentVersion" /v RegisteredOwner        /t REG_SZ /d OwnerNameHere   /f
echo                                 %wmenu%
pause
goto w000

:w058
SET Wmenu=%wopc% Mostrar a VersAo do Windows no Desktop
REG ADD "HKCU\Control Panel\Desktop" /v PaintDesktopVersion /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w057
SET Wmenu=%wopc% Disabilita Firewall Windows XP
REG ADD "HKLM\System\CurrentControlSet\Seri ces\SharedAccess\Parameters\Firewal lPolicy\StandardProfile" /v EnableFirewall /t REG_DWORD /d 0x00000000 /f
echo                                 %wmenu%
pause
goto w000

:w056
SET Wmenu=%wopc% Desabilitar Windows Messenger
REG ADD "HKLM\Software\Policies\Microsoft\M essenger\Client" /v PreventRun /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w055
SET Wmenu=%wopc% Desabilitar Restauracao de Sistema
REG ADD "HKLM\Software\Microsoft\Window s NT\CurrentVersion\SystemRestore\" /v DisableSR /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w054
SET Wmenu=%wopc% Disabilitar Beeps de Erros
REG ADD "HKCU\Control Panel\Sound" /v Beep /t REG_SZ /d no /f
echo                                 %wmenu%
pause
goto w000

:w053
SET Wmenu=%wopc% Desabilitar Mensagem de Notificacao de Espaco em Disco Insuficiente
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoLowDiskSpaceChecks /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w052
SET Wmenu=%wopc% Desabilitar o Sistema de Encriptacao de Arquivos
REG ADD "HKLM\Software\Microsoft\Window s NT\CurrentVersion\EFS" /v EfsConfiguratiom /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w051
SET Wmenu=%wopc% Disabilitar Auto-Run do CD-ROM
REG ADD "HKLM\Software\CurrentControlSet\Se rvices\Cdrom" /v AutoRun /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w050
SET Wmenu=%wopc% Desabilitar a Notificacao de Atualizacoes Automaticas Desativada
REG ADD "HKLM\Software\Microsoft\Securi ty Center" /v UpdatesDisableNotify /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w049
SET Wmenu=%wopc% Desabilitar a Notificacao de Firewall Desativado
REG ADD "HKLM\Software\Microsoft\Securi ty Center" /v FirewallDisableNotify /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w048
SET Wmenu=%wopc% Desabilitar a Notificacao de Antivirus Desativado
REG ADD "HKLM\Software\Microsoft\Securi ty Center" /v AntiVirusDisableNotify /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w047
SET Wmenu=%wopc% Limpar Arquivos Temporarios do Internet Explorer
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Internet Settings\Cache" /v Persistent /t REG_DWORD /d 0x00000000 /f
echo                                 %wmenu%
pause
goto w000

:w046
SET Wmenu=%wopc% Esconder Relogio do Windows
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v HideClock /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w045
SET Wmenu=%wopc% Remover Executar do Menu Iniciar
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoRun /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w044
SET Wmenu=%wopc% Otimizacao para o Cache de DNS
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Dnscache\Parameters" /v CacheHashTableBucketSize /t REG_DWORD /d 0x00000001 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Dnscache\Parameters" /v CacheHashTableSize       /t REG_DWORD /d 0x00000180 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Dnscache\Parameters" /v MaxCacheEntryTtLimit     /t REG_DWORD /d 0x0000fa00 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Dnscache\Parameters" /v MaxSOACacheEntryTtLimit  /t REG_DWORD /d 0x0000012d /f
echo                                 %wmenu%
pause
goto w000

:w043
SET Wmenu=%wopc% Desabilitar Cache para Thumbnails (Miniaturas)
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Explorer\Advanced" /v DisableThumbnailCache /t REG_SZ /d 1 /f
echo                                 %wmenu%
pause
goto w000

:w042
SET Wmenu=%wopc% Pesquisa de Computadores Mais Eficaz
REG DELETE "HKLM\Software\Microsoft\Windows\Cu rrentVersion\Explorer\RemoteCompute r\NameSpace\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}" /f
echo                                 %wmenu%
pause
goto w000

:w041
SET Wmenu=%wopc% Otimizacao TCP/IP
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Lanmanserver\parameters" /v SizReqBuf     /t REG_DWORD /d 0x00014596 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Tcpip\ServiceProvider"   /v class         /t REG_DWORD /d 0x00000001 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Tcpip\ServiceProvider"   /v DnsPriority   /t REG_DWORD /d 0x00000007 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Tcpip\ServiceProvider"   /v HostsPriority /t REG_DWORD /d 0x00000006 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Tcpip\ServiceProvider"   /v LocalPriority /t REG_DWORD /d 0x00000005 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Tcpip\ServiceProvider"   /v NetbtPriority /t REG_DWORD /d 0x00000008 /f
echo                                 %wmenu%
pause
goto w000


:w040
SET Wmenu=%wopc% Limpar o Arquivo de Troca ao Encerrar o Windows
REG ADD "HKLM\SYSTEM\CurrentControlSet\Cont rol\Session Manager\Memory Management" /v ClearPageFileATShutdown /t REG_SZ /d 1 /f
echo                                 %wmenu%
pause
goto w000

:w039
SET Wmenu=%wopc% Limpeza de Disco Mais Eficaz (Prevencao contra Travamentos)
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\Cu rrentVersion\Explorer\VolumeCaches\ Compress old files" /f
echo                                 %wmenu%
pause
goto w000

:w038
SET Wmenu=%wopc% Aumentar a Taxa de Upload
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\AFD\Parameters"   /v DefaultSendWindow   /t REG_DWORD /d 0x00018000 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Serv ices\Tcpip\Parameters" /v EnablePMTUDiscovery /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w037
SET Wmenu=%wopc% Aumentar o Numero de Downloads Simultaneos no Internet Explorer
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Internet Settings" /v MaxConnectionsPer1_0Server /t REG_DWORD /d 0x0000000a /f
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Internet Settings" /v MaxConnectionsPerServer    /t REG_DWORD /d 0000000a   /f
echo                                 %wmenu%
pause
goto w000

:w036
SET Wmenu=%wopc% Descarregar DLLs inutilizadas da Memoria
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\Cu rrentVersion\Explorer" /v AlwaysUnloadDLL /t REG_SZ /d 1 /f
echo                                 %wmenu%
pause
goto w000

:w035
SET Wmenu=%wopc% Menu Iniciar Mais Rapido
REG ADD "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 100 /f
REG ADD "HKU\.DEFAULT\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 100 /f
echo                                 %wmenu%
pause
goto w000

:w034
SET Wmenu=%wopc% Ativar Num-Lock quando Entrar no Windows
REG ADD "HKCU\Control Panel\Keyboard\"       /v InitialKeyboardIndicators /t REG_SZ /d 2 /f
REG ADD "HKU\.DEFAULT\Control Panel\Desktop" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f boardIndicators /t REG_SZ /d 2 /f
echo                                 %wmenu%
pause
goto w000

:w033
SET Wmenu=%wopc% Optimizacao no Boot
REG ADD "HKLM\SOFTWARE\Microsoft\Dfrg\BootO ptimizeFunction" /v Enable           /t REG_SZ /d Y   /f
REG ADD "HKLM\SOFTWARE\Microsoft\Dfrg\BootO ptimizeFunction" /v OptimizeComplete /t REG_SZ /d Yes /f
echo                                 %wmenu%
pause
goto w000

:w032
SET Wmenu=%wopc% Finalizacao Automatica das tarefas
REG ADD "HKCU\Control Panel\Desktop"         /v AutoEndTasks /t REG_SZ /d 1 /f
REG ADD "HKU\.DEFAULT\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d 1 /f
echo                                 %wmenu%
pause
goto w000

:w031
SET Wmenu=%wopc% Habilitar o Bloqueio de Foco
REG ADD "HKCU\Control Panel\Desktop"         /v ForegroundLockTimeout /t REG_DWORD /d 0x00030d40 /f
REG ADD "HKU\.DEFAULT\Control Panel\Desktop" /v ForegroundLockTimeout /t REG_DWORD /d 0x00030d40 /f
echo                                 %wmenu%
pause
goto w000

:w030
SET Wmenu=%wopc% Nao Permitir o Internet Explorer coletar informacoes do AutoCompletar
REG ADD "HKCU\Software\Microsoft\Intern et Explorer\Main" /v Use FormSuggest /t REG_SZ /d no /f
REG ADD "HKCU\Software\Microsoft\Intern et Explorer\Main" /v FormSuggest Passwords /t REG_SZ /d no /f
REG ADD "HKCU\Software\Microsoft\Intern et Explorer\Main" /v FormSuggest PW Ask /t REG_SZ /d no /f
echo                                 %wmenu%
pause
goto w000

:w029
SET Wmenu=%wopc% Bloco de Notas como Editor Html padrao no Internet Explorer
REG ADD "HKCU\Software\Microsoft\Intern et Explorer\Default HTML Editor" /v Description /t REG_SZ /v "Bloco de notas" /f
echo                                 %wmenu%
pause
goto w000

:w028
SET Wmenu=%wopc% Limpar o Historico de Urls acessadas no Internet Explorer a cada 1 dia
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Internet Settings\Url History" /v DaysToKeep /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w027
SET Wmenu=%wopc% Remover o "Gerenciador de Tarefas" [Ctrl+Alt+Del]
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\System" /v DisableTaskMgr /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
pause
goto w000

:w026
SET Wmenu=%wopc% Desabilitar Atualizacoes Automaticas do Windows
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoAutoUpdate /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w025
SET Wmenu=%wopc% Nao Exibir "Barras de Ferramentas Personalizadas" na "Barra de Tarefas"
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoToolbarOnTaskbar /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w024
SET Wmenu=%wopc% Remover as dicas dos baloes nos itens do "Menu Iniciar"
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoSMBalloonTip /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w023
SET Wmenu=%wopc% Forcar "Menu Iniciar" no estilo Classico
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoSimpleStartMenu /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w022
SET Wmenu=%wopc% Bloquear "Barra de Tarefas"
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v LockTaskbar /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w021
SET Wmenu=%wopc% Desativar Rastreamento do Usuario
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoInstrumentation /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w020
SET Wmenu=%wopc% Remover Menus Personalizados
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v Intellimenus /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w019
SET Wmenu=%wopc% Limpar Historico de Documentos abertos recentemente ao sair
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v ClearRecentDocsOnExit /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w018
SET Wmenu=%wopc% Nao manter Historico de Documentos abertos recentemente
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoRecentDocHistory /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w017
SET Wmenu=%wopc% Remover e Impedir Acesso a Opcao "Desligar" do Menu Iniciar
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoClose /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w016
SET Wmenu=%wopc% Remover Logoff do Menu Iniciar
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoLogoff /t REG_DWORD /d 0x00000001 /f
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v ForceStartMenuLogOff /t REG_DWORD /d 0x00000000 /f
echo                                 %wmenu%
pause
goto w000

:w015
cls
SET Wmenu=%wopc% Nao Permitir o Compartilhamento de arquivos recentemente abertos
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoRecentDocsNetHood /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w014
cls
SET Wmenu=%wopc%  Nao permitir que o usuario altere o caminho de Meus Documentos
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v DisablePersonalDirChange /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w013
cls
SET Wmenu=%wopc%  Remover o Internet Explorer da area de Trabalho
REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoInternetIcon /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w012
cls
SET Wmenu=%wopc% Ocultar Meus Locais de Rede da area de Trabalho
REM REG ADD "HKCU\Software\Microsoft\Windows \CurrentVersion\Policies\Explorer" /v NoNetHood /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w011
cls
SET Wmenu=%wopc% Remover "Propriedades" do Menu de Contexto da Lixeira
REM REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoPropertiesRecycleBin /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w010
cls
SET Wmenu=%wopc% Remover "Propriedades" do Menu de Contexto de Meu Computador
REM REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoPropertiesMyComputer /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w009
cls
SET Wmenu=%wopc% Remover "Propriedades" do Menu de Contexto de Meus Documentos
REM REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoPropertiesMyDocuments /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w008
cls
SET Wmenu=%wopc% Remover Meu Computador da area de Trabalho
REM REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\NonEnum" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w007
cls
SET Wmenu=%wopc% Remover Meus Documentos da area de Trabalho
REM REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\NonEnum" /v {450D8FBA-AD25-11D0-98A8-0800361B1103} /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w006
cls
SET Wmenu=%wopc% Remover a Lixeira da area de Trabalho
REM REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\NonEnum" /v {645FF040-5081-101B-9F08-00AA002F954E} /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w005
cls
SET Wmenu=%wopc% Desabilitar a Limpeza da area de Trabalho
REM REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoDesktopCleanupWizard /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w004
cls
SET Wmenu=%wopc% Bloquear a alteracao do Papel de Parede
REM REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoDesktopCleanupWizard /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w003
cls
SET Wmenu=%wopc% Forcar o estilo classico no Painel de Controle
REM REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v ForceClassicControlPanel /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w002
cls
SET Wmenu=%wopc% Bloquear acesso ao Painel de Controle
REM REG ADD "HKCU\Software\Microsoft\Windows\Cu rrentVersion\Policies\Explorer" /v NoControlPanel /t REG_DWORD /d 0x00000001 /f
echo                                 %wmenu%
pause
goto w000

:w001
cls
SET Wmenu=%wopc% Pagina Incial de Internet 
REM reg add "HKCU\software\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d http://www.portal.saude.sp.gov.br/ /f
echo                                 %wmenu%
pause
goto w000


:fim
@echo off
cls
SET Wmenu=Se voce fez qualquer alteracao no Registro do Windows e necessario reiniciar o computador
SET Wfim=%wopc% [    F   I   M    ]
echo.
echo.
echo           %wmenu%
echo.
echo                                     %Wfim%
echo.
echo.
gpupdate /force
pause