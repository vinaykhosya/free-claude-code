@echo off
setlocal ENABLEEXTENSIONS

cd /d "%~dp0"

echo ===============================================
echo  Free Claude Code - Start Server
echo  Made by Vinay Khosya
echo ===============================================
echo.

where uv >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo uv is not installed or not in PATH.
    echo Please run install.bat first.
    pause
    exit /b 1
)

set "UV_LOCAL_BIN=%USERPROFILE%\.local\bin"
if exist "%UV_LOCAL_BIN%\uv.exe" (
    set "PATH=%UV_LOCAL_BIN%;%PATH%"
)

if not exist ".env" (
    if exist ".env.example" (
        copy /Y ".env.example" ".env" >nul
        echo Created .env from .env.example.
        echo IMPORTANT: Open .env and add your real keys before using the proxy.
        echo.
    ) else (
        echo .env not found and .env.example is missing.
        echo Please create .env manually.
        pause
        exit /b 1
    )
)

echo Starting server on http://0.0.0.0:8082 ...
echo Press Ctrl+C to stop.
echo.

uv run uvicorn server:app --host 0.0.0.0 --port 8082

set "EXIT_CODE=%ERRORLEVEL%"
echo.
echo Server exited with code %EXIT_CODE%.
pause
exit /b %EXIT_CODE%
