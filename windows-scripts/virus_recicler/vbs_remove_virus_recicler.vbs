'DESABILITA AUTORUN
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf\", "@SYS:DoesNotExist", "REG_SZ"