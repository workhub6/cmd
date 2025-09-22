@echo off
title WorkHub Server v2.0
cls

:menu
echo.
echo     ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗  ██╗██╗   ██╗██╗  
echo     ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║  ██║██║   ██║██║ ██ 
echo     ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████║██║   ██║█████╔ 
echo     ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██╔══██║██║   ██║██╔═██ 
echo     ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║  ██║╚██████╔╝██║  ██ 
echo      ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  
echo.
echo                WorkHub Server v2.0 - Liquidity System
echo ================================================================
echo [1] View Current Balance
echo [2] Update Data
echo [3] Clear Screen
echo [4] Exit
echo ================================================================
echo.
set /p choice="Enter your choice: "

if "%choice%"=="1" goto view_balance
if "%choice%"=="2" goto update_data
if "%choice%"=="3" goto clear_screen
if "%choice%"=="4" goto exit_system

echo.
echo Invalid choice, please try again.
echo.
pause
goto menu

:view_balance
echo.
echo ==================================
echo      Current Balance
echo ==================================
echo    Balance: $0.00
echo ==================================
echo.
pause
goto menu

:update_data
echo.
echo Updating data...
timeout /t 2 > nul
echo Data updated successfully.
echo.
pause
goto menu

:clear_screen
cls
goto menu

:exit_system
echo.
echo Thank you for using WorkHub Server.
timeout /t 2 > nul
exit
