@echo off
setlocal enabledelayedexpansion

REM Version of the script
set "version=1.2.0"

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

REM Function to add a package to requirements.txt
if "%1"=="add" (
    if "%2"=="" (
        echo Please provide the name of the package to add.
        exit /b 1
    )
    pip install %2
    if not exist "requirements.txt" (
        echo %2 > requirements.txt
    ) else (
        echo %2 >> requirements.txt
    )
    echo Package '%2' added to requirements.txt.
    exit /b 0
)

REM Function to remove a package from requirements.txt
if "%1"=="remove" (
    if "%2"=="" (
        echo Please provide the name of the package to remove.
        exit /b 1
    )
    pip uninstall -y %2
    if exist "requirements.txt" (
        findstr /v /i "%2" requirements.txt > temp.txt
        move /y temp.txt requirements.txt > nul
    )
    echo Package '%2' removed from requirements.txt.
    exit /b 0
)

REM Function to update Python path in virtual environment
if "%1"=="updatepy" (
    call :do_updatepy %2
    exit /b !errorlevel!
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
echo install - Install requirements from requirements.txt
echo update - Update packages from requirements.txt
echo list - list installed packages in the activated virtual environment
echo freeze - Check all packages in the activated virtual environment and populate requirements.txt
echo add [package-name] - Install and adds a package to requirements.txt
echo remove [package-name] - Uninstall and removes a package from requirements.txt
echo updatepy [path] - Update Python path in a virtual environment (auto-detects if no path given)
echo --help - Display this help information
echo --version - Display the script version
echo ---------
echo Environment commands, used without virenv command:
echo deactivate - Deactivates current environment
exit /b

:display_version
echo version %version%
exit /b

:invalid_command
echo Invalid command. Use one of the following:
call :display_help
exit /b

:do_updatepy
set "venv_path=%~1"
if "!venv_path!"=="" (
    for /d %%d in (*) do (
        if exist "%%d\pyvenv.cfg" (
            set "venv_path=%%d"
            goto :found_venv
        )
    )
    echo No virtual environment found in current directory.
    echo Usage: virenv updatepy [venv_path]
    exit /b 1
)
:found_venv
if not exist "!venv_path!\pyvenv.cfg" (
    echo Error: '!venv_path!' is not a valid virtual environment.
    exit /b 1
)
echo Updating Python path in virtual environment: !venv_path!
echo ===============================
echo.
for /f "tokens=1,* delims==" %%a in ('findstr /i "^home" "!venv_path!\pyvenv.cfg"') do set "old_home=%%b"
for /f "tokens=*" %%x in ("!old_home!") do set "old_home=%%x"
echo Current Python home: !old_home!
for /f "delims=" %%a in ('where python 2^>nul') do (
    set "new_python=%%a"
    goto :got_python
)
echo Error: Python not found in PATH.
exit /b 1
:got_python
for %%F in ("!new_python!") do set "new_home=%%~dpF"
if "!new_home:~-1!"=="\" set "new_home=!new_home:~0,-1!"
echo New Python home:     !new_home!
echo.
if /i "!old_home!"=="!new_home!" (
    echo Python path is already up to date. No changes needed.
    exit /b 0
)
python -m venv --upgrade "!venv_path!"
if !errorlevel! equ 0 (
    echo.
    echo Virtual environment updated successfully.
) else (
    echo.
    echo Warning: --upgrade failed. Attempting manual pyvenv.cfg update...
    powershell -Command "$cfg = '!venv_path!\pyvenv.cfg'; (Get-Content $cfg) -replace '^home\s*=.*', ('home = ' + '!new_home!') | Set-Content $cfg"
    if !errorlevel! equ 0 (
        echo pyvenv.cfg updated manually.
    ) else (
        echo Failed to update virtual environment.
        exit /b 1
    )
)
exit /b 0