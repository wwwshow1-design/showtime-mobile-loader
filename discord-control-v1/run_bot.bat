@echo off
setlocal
cd /d "%~dp0"
title Market Scanner Discord Control

if not exist ".venv\Scripts\python.exe" (
  echo [ERROR] Setup is not complete.
  echo Run setup_windows.bat first.
  pause
  exit /b 1
)

if not exist ".env" (
  echo [ERROR] .env file was not found.
  echo Run setup_windows.bat first.
  pause
  exit /b 1
)

echo ========================================
echo   Market Scanner Discord Control
echo ========================================
echo Close this window to stop the bot.
echo.
".venv\Scripts\python.exe" "bot_server.py"

echo.
echo Bot stopped.
pause
