@echo off
setlocal enabledelayedexpansion

REM Version of the script
set "version=1.1.0"

REM Function to create a virtual environment
if "%1"=="create" (
    if "%2"=="" (
        echo Please provide a name for the virtual environment.
        exit /b 1
    )
    python -m venv %2
    echo Virtual environment '%2' created.
    exit /b 0
)

REM Function to activate a virtual environment
if "%1"=="activate" (
    set "venv_name=%2"
    if "%venv_name%"=="" (
        for /d %%d in (*) do (
            if exist "%%d\Scripts\activate.bat" (
                set "venv_name=%%d"
                goto :activate_venv
            )
        )
        echo No virtual environment found in the current directory.
        exit /b 1
    )
    :activate_venv
    for /f "tokens=*" %%i in ('powershell -command "$PSVersionTable.PSVersion"') do set "ps_version=%%i"
    if defined ps_version (
        powershell -ExecutionPolicy RemoteSigned -File "%venv_name%\Scripts\Activate.ps1"
    ) else (
        call "%venv_name%\Scripts\activate.bat"
    )
    echo Virtual environment '%venv_name%' activated.
    exit /b 0
)

REM Function to check if a virtual environment is activated
if "%1"=="check" (
    python "%~dp0virenv_check.py"
    exit /b 0
)


REM Function to deactivate a virtual environment
if "%1"=="deactivate" (
    if defined VIRTUAL_ENV (
        call deactivate
        echo Virtual environment deactivated.
    ) else (
        echo No virtual environment is currently activated.
    )
    exit /b 0
)

REM Function to install requirements
if "%1"=="install" (
    if not exist "requirements.txt" (
        echo requirements.txt not found in the current directory.
        exit /b 1
    )
    pip install -r requirements.txt
    echo Requirements installed.
    exit /b 0
)

REM Function to update requirements
if "%1"=="update" (
    if not exist "requirements.txt" (
        echo requirements.txt not found in the current directory.
        exit /b 1
    )
    pip install --upgrade -r requirements.txt
    echo Requirements updated.
    exit /b 0
)

REM Function to list installed packages
if "%1"=="list" (
    pip list
    exit /b 0
)

REM Function to check all packages in the activated virtual environment and populate requirements.txt
if "%1"=="freeze" (
    if defined VIRTUAL_ENV (
        pip freeze > requirements.txt
        echo requirements.txt has been populated with the installed packages.
        exit /b 0
    ) else (
        echo No virtual environment is currently activated.
        exit /b 1
    )
)

REM Function to display help information about the script
if "%~1"=="--help" (
    call :display_help
    exit /b 0
)

REM Function to display the version
if "%~1"=="--version" (
    call :display_version
    exit /b 0
)

REM If no valid command is provided
call :invalid_command
exit /b 1

:display_help
echo Commands:
echo create name - Create a virtual environment with the specified name
echo activate [name] - Activate a virtual environment, optionally by name
echo check - Check if a virtual environment is activated and return its name
echo deactivate - Deactivate the current virtual environment
echo install - Install requirements from requirements.txt
echo update - Update packages from requirements.txt
echo list - list installed packages in the activated virtual environment
echo freeze - Check all packages in the activated virtual environment and populate requirements.txt
echo help - Display this help information
echo version - Display the script version
exit /b

:display_version
echo version %version%
exit /b

:invalid_command
echo Invalid command. Use one of the following:
call :display_help
exit /b