@echo off

::# elevate with native shell
>nul reg add hkcu\software\classes\.Admin\shell\runas\command /f /ve /d "cmd /x /d /r set \"f0=%%2\"& call \"%%2\" %%3"& set _= %*
>nul fltmc|| if "%f0%" neq "%~f0" (cd.>"%temp%\runas.Admin" & start "%~n0" /high "%temp%\runas.Admin" "%~f0" "%_:"=""%" & exit /b)
title CleanInstallW11 - Outils de suppression des apps Windows en batch part ps81frt
cls & echo ======================
echo Suppressions des Application du menu Demarrer
echo ======================& echo.
for /f %%a in ('REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount /s /k /f placeholdertilecollection') do (reg delete %%a\current /VA /F 2> nul)
REG add HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d 0 /f 2> nul
:: Show file extensions
REG add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v "HideFileExt" /t REG_DWORD /d 0 /f 2> nul
taskkill /f /im explorer.exe & start explorer.exe 2> nul

echo ======================
echo Installation de winget
echo ====================== & echo.

::installing dependies
$progressPreference = 'silentlyContinue'
Write-Information "Downloading WinGet and its dependencies..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx -OutFile Microsoft.UI.Xaml.2.7.x64.appx
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage Microsoft.UI.Xaml.2.7.x64.appx
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

powershell -command winget uninstall Google.Chrome --silent

:: Reinstallation de chrome
powershell -command winget install chrome
