rem desabilita modem conexoes 3g
rem SET Wmenu=%wopc% Desbloquear Modem

REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\Modem" /V Start /t REG_DWORD /d 3 /f

