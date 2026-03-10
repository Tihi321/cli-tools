@echo off
setlocal enabledelayedexpansion

REM Version of the script
set "version=1.3.0"

REM Function to list all processes with ports
if "%1"=="listall" (
    echo All processes with open ports:
    echo ===============================
    echo.
    powershell -Command "$connections = Get-NetTCPConnection -State Listen 2>$null; if ($connections) { $connections | ForEach-Object { $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue; if ($proc) { [PSCustomObject]@{ Port = $_.LocalPort; PID = $_.OwningProcess; Name = $proc.ProcessName; Path = $proc.Path } } } | Sort-Object Port -Unique | Format-Table -AutoSize Port, PID, Name, Path } else { Write-Host 'No listening processes found.' }"
    exit /b 0
)

REM Function to find processes by name
if "%1"=="find" (
    if "%2"=="" (
        echo Please provide a process name.
        exit /b 1
    )
    echo Processes matching '%2':
    echo ===============================
    echo.
    powershell -Command "$connections = Get-NetTCPConnection -State Listen 2>$null; if ($connections) { $results = $connections | ForEach-Object { $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue; if ($proc -and $proc.ProcessName -like '*%2*') { [PSCustomObject]@{ Port = $_.LocalPort; PID = $_.OwningProcess; Name = $proc.ProcessName; Path = $proc.Path } } } | Sort-Object Port -Unique; if ($results) { $results | Format-Table -AutoSize Port, PID, Name, Path } else { Write-Host 'No processes found matching ''%2''.' } } else { Write-Host 'No listening processes found.' }"
    exit /b 0
)

REM Function to list processes on a specific port
if "%1"=="list" (
    if "%2"=="" (
        echo Please provide a port number.
        exit /b 1
    )
    echo Processes running on port %2:
    echo ===============================
    echo.
    powershell -Command "$connections = Get-NetTCPConnection -LocalPort %2 -ErrorAction SilentlyContinue; if ($connections) { $connections | ForEach-Object { $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue; if ($proc) { [PSCustomObject]@{ Port = $_.LocalPort; PID = $_.OwningProcess; Name = $proc.ProcessName; Path = $proc.Path } } } | Sort-Object PID -Unique | Format-Table -AutoSize Port, PID, Name, Path } else { Write-Host 'No processes found on port %2.' }"
    exit /b 0
)

REM Function to stop processes on a specific port
if "%1"=="stop" (
    if "%2"=="" (
        echo Please provide a port number.
        exit /b 1
    )
    echo Stopping processes on port %2...
    set "killed=0"
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%2 "') do (
        set "pid=%%a"
        if not "!pid!"=="0" (
            taskkill /PID !pid! /F >nul 2>&1
            if !errorlevel! equ 0 (
                echo Killed process with PID: !pid!
                set "killed=1"
            )
        )
    )
    if "!killed!"=="0" (
        echo No processes found on port %2.
    ) else (
        echo All processes on port %2 have been stopped.
    )
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
echo VITASKS - Port Process Manager
echo.
echo Commands:
echo   listall            - List all processes with open ports (name, path, port)
echo   list [port]        - List all processes running on the specified port (name, path, PID)
echo   find [name]        - Find all processes matching the specified name
echo   stop [port]        - Stop all processes running on the specified port
echo   updatepy [path]    - Update Python path in a virtual environment (default: .venv or venv)
echo   --help             - Display this help information
echo   --version          - Display the script version
echo.
echo Examples:
echo   vitasks listall           - List all processes with their ports
echo   vitasks list 3000         - List processes on port 3000
echo   vitasks find node         - Find all processes with 'node' in the name
echo   vitasks stop 8080         - Kill all processes on port 8080
echo   vitasks updatepy          - Update Python path in .venv or venv
echo   vitasks updatepy myenv    - Update Python path in myenv
exit /b

:display_version
echo vitasks version %version%
exit /b

:invalid_command
echo Invalid command. Use one of the following:
call :display_help
exit /b

:do_updatepy
set "venv_path=%~1"
if "!venv_path!"=="" (
    if exist ".venv\pyvenv.cfg" (
        set "venv_path=.venv"
    ) else if exist "venv\pyvenv.cfg" (
        set "venv_path=venv"
    ) else (
        echo No virtual environment found in current directory.
        echo Usage: vitasks updatepy [venv_path]
        exit /b 1
    )
)
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
