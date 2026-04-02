@echo off
setlocal ENABLEEXTENSIONS

cd /d "%~dp0"

echo ===============================================
echo  Free Claude Code - Windows Installer
echo ===============================================
echo.

where uv >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [1/6] uv not found. Installing uv...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://astral.sh/uv/install.ps1 | iex"
    if %ERRORLEVEL% neq 0 (
        echo.
        echo Failed to install uv automatically.
        echo Please install uv manually: https://docs.astral.sh/uv/getting-started/installation/
        exit /b 1
    )
)

set "UV_LOCAL_BIN=%USERPROFILE%\.local\bin"
if exist "%UV_LOCAL_BIN%\uv.exe" (
    set "PATH=%UV_LOCAL_BIN%;%PATH%"
)

where uv >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo.
    echo uv was installed but is not available in PATH in this terminal.
    echo Please reopen terminal and run install.bat again.
    exit /b 1
)

echo [2/6] Updating uv...
uv self update

echo [3/6] Installing Python 3.14 (if needed)...
uv python install 3.14
if %ERRORLEVEL% neq 0 (
    echo.
    echo Failed to install Python 3.14 via uv.
    exit /b 1
)

echo [4/6] Installing project dependencies (including optional extras)...
uv sync --all-extras
if %ERRORLEVEL% neq 0 (
    echo.
    echo Dependency installation failed.
    exit /b 1
)

echo [5/6] Creating .env from .env.example if missing...
if not exist ".env" (
    if exist ".env.example" (
        copy /Y ".env.example" ".env" >nul
        echo Created .env file.
    ) else (
        echo WARNING: .env.example not found. Please create .env manually.
    )
) else (
    echo .env already exists.
)

echo [6/6] Setup complete.
echo.
echo Next step: Run start.bat to start the server.
echo.
pause
exit /b 0
