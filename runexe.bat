@echo off

set EXE=D:\dev\rustdesk\flutter\build\windows\x64\runner\Release\PdRemote.exe

if exist "%EXE%" (
    echo Starting PdRemote...
    start "" "%EXE%"
) else (
    echo EXE NOT FOUND
    echo Run build_exe.bat first
)

pause