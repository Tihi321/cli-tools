@echo off
setlocal enabledelayedexpansion

REM Determine the path to the PowerShell profile
for /f "delims=" %%a in ('powershell -NoProfile -Command "$PROFILE"') do set "profile=%%a"

REM Call the PowerShell cleanup script
powershell -ExecutionPolicy RemoteSigned -File "%~dp0scripts\cleanup\virenv.ps1" -ProfilePath "%profile%"

exit /b 0