@echo off
setlocal ENABLEEXTENSIONS

cd /d "%~dp0"

if exist "start.bat" (
    call "start.bat"
    exit /b %ERRORLEVEL%
)

echo start.bat not found in project root.
echo Please run install.bat first or restore start.bat.
pause
exit /b 1
