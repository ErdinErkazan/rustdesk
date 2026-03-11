@echo off
setlocal

call "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat" -arch=x64 -host_arch=x64
if errorlevel 1 goto :fail

set "PROJECT_ROOT=D:\dev\rustdesk"
set "FLUTTER_ROOT=C:\src\flutter3245\flutter"
set "PATH=%FLUTTER_ROOT%\bin;%PATH%"

cd /d "%PROJECT_ROOT%"
cargo build --features flutter --lib --release
if errorlevel 1 goto :fail

cd /d "%PROJECT_ROOT%\flutter"
call flutter build windows --debug
if errorlevel 1 goto :fail

start "" "%PROJECT_ROOT%\flutter\build\windows\x64\runner\Debug\PdRemote.exe"
goto :end

:fail
echo BUILD FAILED
exit /b 1

:end
endlocal