mode 55, 10
@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check pour les permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> Si erreurs, vous n etes pas administrateur.
if '%errorlevel%' NEQ '0' (
    echo Requiert les droit Administrateur...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
color a
echo   -----------------------------
echo        Suppresion Cookies
echo   -----------------------------

::@echo off
REM --> Suppression profile Firefox

::taskkill /im "firefox.exe"

::set DataDir=C:\Users\%USERNAME%\AppData\Local\Mozilla\Firefox\Profiles

::del /q /s /f "%DataDir%"

::rd /s /q "%DataDir%"

::for /d %%x in (C:\Users\%USERNAME%\AppData\Roaming\Mozilla\Firefox\Profiles\*) do del /q /s /f %%x\*sqlite

@echo off
REM --> Suppression Profil Chrome

set ChromeDir=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data

del /q /s /f "%ChromeDir%"

rd /s /q "%ChromeDir%"

REM --> Suppression historique de chrome

taskkill.exe /F /IM chrome.exe
del /q /s /f "c:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\History"

::REM --> Suppression historique de Edge s'execute 3 fois la merde edge pour delete

::taskkill.exe /F /IM msedge.exe
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\History"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\History-journal"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Network\Cookies"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Network-Journal"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Visited Links"

::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\History"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\History-journal"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Network\Cookies"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Network-Journal"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Visited Links"

::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\History"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\History-journal"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Network\Cookies"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Network-Journal"
::del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Visited Links"

net session >nul 2>&1
if %errorLevel% == 0 (
    @RD /S /Q "C:\Windows\Temp"
    @RD /S /Q "C:\Windows\Prefetch"
    @RD /S /Q "%userprofile%\AppData\Local\Temp"
    @RD /S /Q "C:\$Recycle.Bin"

del /s /f /q %WinDir%\Temp\*.*
del /s /f /q %WinDir%\Prefetch\*.*
del /s /f /q %Temp%\*.*
del /s /f /q %AppData%\Temp\*.*
del /s /f /q %HomePath%\AppData\LocalLow\Temp\*.*
cls
rd /s /q %WinDir%\Temp
rd /s /q %WinDir%\Prefetch
rd /s /q %Temp%
rd /s /q %AppData%\Temp
rd /s /q %HomePath%\AppData\LocalLow\Temp
cls
md %WinDir%\Temp
md %WinDir%\Prefetch
md %Temp%
md %AppData%\Temp
md %HomePath%\AppData\LocalLow\Temp


cls
echo   -----------------------------
echo        Nettoyage terminer
echo   -----------------------------
ping localhost -n 3 >nul
    exit
) ELSE (
   echo Demarrer le programme en tant que Administrateur ...
   PAUSE
   EXIT
)
