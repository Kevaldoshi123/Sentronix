@echo off
title SentroniX Cyberdefense Platform (Zero-Docker Standalone)
color 0B

echo =====================================================================
echo           SENTRONIX PURPLE TEAM CYBERDEFENSE PLATFORM
echo                    (Standalone Launcher - No Docker Required)
echo =====================================================================
echo.

cd /d "%~dp0"

:: 1. Check Python
where python >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Python is not installed or not in PATH!
    echo Please download and install Python 3.10+ from https://www.python.org/
    pause
    exit /b 1
)

:: 2. Locate Backend Directory & Python Virtualenv
if exist "backend\venv\Scripts\python.exe" (
    set "BACKEND_DIR=%~dp0backend"
    set "VENV_PY=%~dp0backend\venv\Scripts\python.exe"
) else if exist "sentronix-platform\backend\venv\Scripts\python.exe" (
    set "BACKEND_DIR=%~dp0sentronix-platform\backend"
    set "VENV_PY=%~dp0sentronix-platform\backend\venv\Scripts\python.exe"
) else (
    echo [ERROR] Backend virtual environment not found!
    pause
    exit /b 1
)

:: 3. Launching SentroniX Single-Port Unified Server
echo [*] Starting SentroniX Server on http://localhost:8000 ...
echo [*] Frontend, API, and SQLite Database are fully integrated on port 8000.
echo.

:: Automatically open browser after 2 seconds in the background
start "" timeout /t 2 /nobreak >nul & start http://localhost:8000/

:: Start Uvicorn
cd /d "%BACKEND_DIR%"
"%VENV_PY%" -m uvicorn app.main:app --host 127.0.0.1 --port 8000

pause
