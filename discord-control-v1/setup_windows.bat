@echo off
setlocal
cd /d "%~dp0"
title Market Scanner Discord Control - Setup

echo.
echo ========================================
echo   Market Scanner Discord Control Setup
echo ========================================
echo.

py -3.13 --version >nul 2>nul
if not errorlevel 1 goto use_py313

py --version >nul 2>nul
if not errorlevel 1 goto use_py

python --version >nul 2>nul
if not errorlevel 1 goto use_python

echo [ERROR] Python was not found.
echo Install Python 3.13 64-bit and enable Add Python to PATH.
pause
exit /b 1

:use_py313
echo [1/4] Python found:
py -3.13 --version
echo [2/4] Creating virtual environment...
if not exist ".venv\Scripts\python.exe" py -3.13 -m venv ".venv"
if errorlevel 1 goto failed
goto install_packages

:use_py
echo [1/4] Python found:
py --version
echo [2/4] Creating virtual environment...
if not exist ".venv\Scripts\python.exe" py -m venv ".venv"
if errorlevel 1 goto failed
goto install_packages

:use_python
echo [1/4] Python found:
python --version
echo [2/4] Creating virtual environment...
if not exist ".venv\Scripts\python.exe" python -m venv ".venv"
if errorlevel 1 goto failed
goto install_packages

:install_packages
if not exist ".venv\Scripts\python.exe" (
  echo [ERROR] Virtual environment was not created.
  goto failed
)

echo [3/4] Installing required packages...
".venv\Scripts\python.exe" -m pip install --upgrade pip
if errorlevel 1 goto failed
".venv\Scripts\python.exe" -m pip install -r "requirements.txt"
if errorlevel 1 goto failed

echo [4/4] Preparing .env...
if not exist ".env" copy /Y ".env.example" ".env" >nul

echo.
echo ========================================
echo   SETUP COMPLETE
echo ========================================
echo Open the .env file with Notepad and enter:
echo - DISCORD_BOT_TOKEN
echo - DISCORD_GUILD_ID
echo - DISCORD_USER_IDS
echo - AGENT_TOKEN
echo.
pause
exit /b 0

:failed
echo.
echo ========================================
echo   SETUP FAILED
echo ========================================
echo Please keep this window open and take a screenshot.
echo.
pause
exit /b 1
