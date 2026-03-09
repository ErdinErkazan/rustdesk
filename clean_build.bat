@echo off
setlocal

echo CLEANING PROJECT...

cd /d D:\dev\rustdesk

cargo clean

cd flutter
call flutter clean

echo CLEAN COMPLETE

endlocal
pause