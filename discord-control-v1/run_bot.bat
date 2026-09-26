@echo off
chcp 65001 >nul
cd /d "%~dp0"
title 거래소 Discord 관제 V1

if not exist ".venv\Scripts\python.exe" (
  echo [오류] 설치가 아직 안 되어 있습니다.
  echo setup_windows.bat을 먼저 실행하세요.
  pause
  exit /b 1
)

if not exist ".env" (
  echo [오류] .env 파일이 없습니다.
  echo setup_windows.bat을 먼저 실행하세요.
  pause
  exit /b 1
)

echo ========================================
echo   거래소 Discord 관제 V1 시작
echo ========================================
echo 창을 닫으면 관제 Bot도 종료됩니다.
echo.
".venv\Scripts\python.exe" bot_server.py

echo.
echo Bot이 종료되었습니다.
pause
