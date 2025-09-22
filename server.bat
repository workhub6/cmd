@echo off
chcp 65001 > nul
title Liquidity Balance System
cls

:: ==============================
:: System Configuration
:: ==============================
set "BALANCE_FILE=%TEMP%\liquidity_balance.txt"

:: Initialize balance if not exists
if not exist "%BALANCE_FILE%" echo 0 > "%BALANCE_FILE%"

:menu
cls
echo.
echo    ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗  ██╗██╗   ██╗██╗  ██╗
echo    ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║  ██║██║   ██║██║ ██╔╝
echo    ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████║██║   ██║█████╔╝ 
echo    ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██╔══██║██║   ██║██╔═██╗ 
echo    ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║  ██║╚██████╔╝██║  ██╗
echo     ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
echo.
echo                WorkHub Server v2.0 - Liquidity System
echo ================================================================
echo [1] View Liquidity Balance
echo [2] Set Custom Balance
echo [3] Switch to Arabic Version
echo [4] Clear Screen
echo [5] Exit
echo ================================================================
echo.
set /p choice="Select option number: "

if "%choice%"=="1" goto viewbalance
if "%choice%"=="2" goto setbalance
if "%choice%"=="3" goto arabicversion
if "%choice%"=="4" goto clear
if "%choice%"=="5" goto exit
goto invalid

:viewbalance
set /p BALANCE=<"%BALANCE_FILE%"
echo.
echo Current Liquidity Balance: %BALANCE% USD
echo.
pause
goto menu

:setbalance
echo.
set /p NEW_BALANCE="Enter new balance amount: "
echo %NEW_BALANCE% > "%BALANCE_FILE%"
echo.
echo Balance successfully set to %NEW_BALANCE% USD
echo.
pause
goto menu

:arabicversion
echo Switching to Arabic version...
timeout /t 2 > nul
call :arabic_menu
goto menu

:clear
cls
goto menu

:invalid
echo.
echo Invalid selection, please try again.
echo.
pause
goto menu

:exit
echo.
echo Thank you for using Liquidity Balance System
timeout /t 2 > nul
exit

:: ==============================================
:: Arabic Menu Function
:: ==============================================
:arabic_menu
cls
echo.
echo    ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗  ██╗██╗   ██╗██╗  ██╗
echo    ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║  ██║██║   ██║██║ ██╔╝
echo    ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████║██║   ██║█████╔╝ 
echo    ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██╔══██║██║   ██║██╔═██╗ 
echo    ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║  ██║╚██████╔╝██║  ██╗
echo     ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
echo.
echo                WorkHub Server v2.0 - نظام السيولة
echo ================================================================
echo [1] عرض رصيد السيولة
echo [2] تعيين رصيد مخصص
echo [3] الرجوع للنسخة الإنجليزية
echo [4] تنظيف الشاشة
echo [5] الخروج
echo ================================================================
echo.
set /p choice="اختر رقم الأمر: "

if "%choice%"=="1" goto viewbalance_ar
if "%choice%"=="2" goto setbalance_ar
if "%choice%"=="3" goto englishversion
if "%choice%"=="4" goto clear_ar
if "%choice%"=="5" goto exit_ar
goto invalid_ar

:viewbalance_ar
set /p BALANCE=<"%BALANCE_FILE%"
echo.
echo الرصيد الحالي: %BALANCE% دولار
echo.
pause
goto arabic_menu

:setbalance_ar
echo.
set /p NEW_BALANCE="أدخل المبلغ الجديد: "
echo %NEW_BALANCE% > "%BALANCE_FILE%"
echo.
echo تم تعيين الرصيد إلى %NEW_BALANCE% دولار
echo.
pause
goto arabic_menu

:englishversion
echo.
echo العودة إلى النسخة الإنجليزية...
timeout /t 2 > nul
goto :eof

:clear_ar
cls
goto arabic_menu

:invalid_ar
echo.
echo اختيار غير صحيح، الرجاء المحاولة مرة أخرى
echo.
pause
goto arabic_menu

:exit_ar
echo.
echo شكراً لاستخدامك النظام
timeout /t 2 > nul
exit