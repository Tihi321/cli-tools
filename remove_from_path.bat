@echo off
setlocal enabledelayedexpansion

REM Get the current directory
set "current_dir=%cd%"

REM Set the scripts directory path
set "scripts_dir=%current_dir%\scripts"

REM Get the current PATH environment variable
for /f "tokens=*" %%i in ('powershell -command "[System.Environment]::GetEnvironmentVariable('PATH', 'User')"') do set "user_path=%%i"

REM Remove the scripts directory from the PATH
set "new_path="
for %%i in (!user_path:;=!;!) do (
    if /i not "%%i"=="%scripts_dir%" (
        if defined new_path (
            set "new_path=!new_path!;%%i"
        ) else (
            set "new_path=%%i"
        )
    )
)

REM Update the user's PATH environment variable
powershell -command "[System.Environment]::SetEnvironmentVariable('PATH', '%new_path%', 'User')"

echo The scripts directory has been removed from the user's PATH environment variable.