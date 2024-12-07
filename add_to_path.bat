@echo off
setlocal

REM Get the current directory
set "current_dir=%cd%"

REM Set the scripts directory path
set "scripts_dir=%current_dir%\scripts"

REM Add the scripts directory to the user's PATH environment variable
setx PATH "%PATH%;%scripts_dir%"

echo The scripts directory has been added to the user's PATH environment variable.