@echo off
setlocal

echo ==========================================
echo RustDesk / PdRemote Windows EXE Build
echo ==========================================
echo.

call "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat" -arch=x64 -host_arch=x64
if errorlevel 1 goto :fail

set "PROJECT_ROOT=D:\dev\rustdesk"
set "FLUTTER_ROOT=C:\src\flutter_3_24_5\flutter"
set "VCPKG_ROOT=C:\vcpkg"
set "PATH=%FLUTTER_ROOT%\bin;%PATH%"

echo [1/6] Checking paths...
if not exist "%PROJECT_ROOT%\Cargo.toml" (
  echo ERROR: Cargo.toml not found in %PROJECT_ROOT%
  goto :fail
)
if not exist "%PROJECT_ROOT%\flutter\pubspec.yaml" (
  echo ERROR: flutter\pubspec.yaml not found
  goto :fail
)
if not exist "%FLUTTER_ROOT%\bin\flutter.bat" (
  echo ERROR: flutter.bat not found in %FLUTTER_ROOT%\bin
  goto :fail
)
if not exist "%VCPKG_ROOT%" (
  echo ERROR: VCPKG_ROOT not found: %VCPKG_ROOT%
  goto :fail
)

echo [2/6] Flutter version...
call flutter --version
if errorlevel 1 goto :fail

echo [3/6] Building Rust library...
cd /d "%PROJECT_ROOT%"
cargo build --features flutter --lib --release
if errorlevel 1 goto :fail

echo [4/6] Flutter packages...
cd /d "%PROJECT_ROOT%\flutter"
call flutter pub get
if errorlevel 1 goto :fail

echo [5/6] Building Windows app...
call flutter build windows
if errorlevel 1 goto :fail

echo [6/6] Done.
echo.
echo EXE:
echo %PROJECT_ROOT%\flutter\build\windows\x64\runner\Release\PdRemote.exe
echo.
if exist "%PROJECT_ROOT%\flutter\build\windows\x64\runner\Release\PdRemote.exe" (
  echo Launching EXE...
  start "" "%PROJECT_ROOT%\flutter\build\windows\x64\runner\Release\PdRemote.exe"
)

goto :end

:fail
echo.
echo BUILD FAILED
exit /b 1

:end
endlocal