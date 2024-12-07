@echo off
setlocal enabledelayedexpansion

REM Run add_path.bat from the setup subfolder
call "%~dp0setup\add_path.bat"

REM Run setup_scripts.bat from the setup subfolder
call "%~dp0setup\setup_scripts.bat"

exit /b 0