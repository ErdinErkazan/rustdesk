@echo off
setlocal

call "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat" -arch=x64 -host_arch=x64
if errorlevel 1 goto :fail

set "PROJECT_ROOT=D:\dev\rustdesk"
set "FLUTTER_ROOT=C:\src\flutter_3_24_5\flutter"
set "VCPKG_ROOT=C:\vcpkg"
set "PATH=%FLUTTER_ROOT%\bin;%PATH%"

cd /d "%PROJECT_ROOT%"
cargo clean
if errorlevel 1 goto :fail

cd /d "%PROJECT_ROOT%\flutter"
flutter clean
if errorlevel 1 goto :fail

cd /d "%PROJECT_ROOT%"
cargo build --features flutter --lib --release
if errorlevel 1 goto :fail

cd /d "%PROJECT_ROOT%\flutter"
flutter pub get
if errorlevel 1 goto :fail

flutter build windows
if errorlevel 1 goto :fail

echo.
echo CLEAN BUILD DONE
echo %PROJECT_ROOT%\flutter\build\windows\x64\runner\Release\PdRemote.exe
goto :end

:fail
echo.
echo CLEAN BUILD FAILED
exit /b 1

:end
endlocal