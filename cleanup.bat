@echo off
setlocal enabledelayedexpansion

REM Run remove_path.bat from the setup subfolder
call "%~dp0setup\remove_path.bat"

REM Run cleanup_scripts.bat from the setup subfolder
call "%~dp0setup\cleanup_scripts.bat"

exit /b 0