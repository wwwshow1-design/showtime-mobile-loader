@echo off
chcp 65001 >nul
cd /d "%~dp0"
title 거래소 Discord 관제 V1 - 첫 설치

echo.
echo ========================================
echo   거래소 Discord 관제 V1 - 첫 설치
echo ========================================
echo.

py -3.13 --version >nul 2>nul
if %errorlevel%==0 (
  set "PY_CMD=py -3.13"
  goto :python_ok
)

python --version >nul 2>nul
if %errorlevel%==0 (
  set "PY_CMD=python"
  goto :python_ok
)

echo [오류] Python을 찾지 못했습니다.
echo 먼저 Python 3.13 64-bit를 설치한 뒤 다시 실행하세요.
echo 설치할 때 Add Python to PATH를 체크하세요.
pause
exit /b 1

:python_ok
echo [1/4] Python 확인 완료
%PY_CMD% --version

if not exist ".venv\Scripts\python.exe" (
  echo [2/4] 전용 가상환경 생성 중...
  %PY_CMD% -m venv .venv
  if errorlevel 1 goto :failed
) else (
  echo [2/4] 기존 가상환경 사용
)

echo [3/4] 필요한 패키지 설치 중...
call ".venv\Scripts\python.exe" -m pip install --upgrade pip
call ".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 goto :failed

if not exist ".env" (
  copy /Y ".env.example" ".env" >nul
  echo [4/4] .env 파일 생성 완료
) else (
  echo [4/4] 기존 .env 파일 유지
)

echo.
echo ========================================
echo 설치 완료
echo ========================================
echo 다음 단계:
echo 1. 이 폴더의 .env 파일을 메모장으로 엽니다.
echo 2. Discord Bot Token / 서버 ID / 사용자 ID를 입력합니다.
echo 3. run_bot.bat을 실행합니다.
echo.
pause
exit /b 0

:failed
echo.
echo [실패] 설치 중 오류가 발생했습니다.
echo 이 창을 닫지 말고 오류 화면을 확인하세요.
pause
exit /b 1
