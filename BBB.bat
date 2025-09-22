@echo off
chcp 65001 > nul
title WorkHub Server - Liquidity System
cls

:: ==============================
:: Account and Endpoint Setup
:: ==============================
set "XRPL_ACCOUNT=rBb27Rh5jZBSmjCvmyVb6cVfRKhhmxUYK8"
set "APIURL=https://data.xrplf.org/v1/account/%XRPL_ACCOUNT%"

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
echo [1] View Local Demo Balance
echo [2] Fetch Real-time Balance from XRPL
echo [3] Get Last 10 Transaction Records
echo [4] Switch to Arabic Version
echo [5] Clear Screen
echo [6] Exit
echo ================================================================
echo.
set /p choice="Select option number: "

if "%choice%"=="1" goto localbalance
if "%choice%"=="2" goto fetchbalance
if "%choice%"=="3" goto fetchhistory
if "%choice%"=="4" goto arabicversion
if "%choice%"=="5" goto clear
if "%choice%"=="6" goto exit
goto invalid

:localbalance
echo.
echo Demo Balance: 10,000 XRP
echo Note: This is a demo value. Select option 2 for real-time data.
echo.
pause
goto menu

:fetchbalance
echo.
echo Fetching real-time balance from XRPL...
powershell -Command "try {$url = '%APIURL%'; $response = Invoke-RestMethod -Uri $url; if ($response.account_data -and $response.account_data.Balance) {$value = [math]::Round(($response.account_data.Balance/1000000),6); Write-Host ('Current Balance: ' + $value + ' XRP') -ForegroundColor Green} else {Write-Host 'Balance data not found in response.' -ForegroundColor Red}} catch {Write-Host 'Error connecting to XRPL: ' + $_.Exception.Message -ForegroundColor Red}"
echo.
pause
goto menu

:fetchhistory
echo.
echo Fetching last 10 transaction records...
powershell -Command "try {$url = 'https://data.xrplf.org/v1/account/%XRPL_ACCOUNT%/transactions'; $response = Invoke-RestMethod -Uri $url; if ($response.transactions) {$i=0; foreach ($t in $response.transactions | Select-Object -First 10) {$i++; $time = if ($t.date) {(Get-Date $t.date -Format 'yyyy-MM-dd HH:mm')} else {'-'}; $type = if ($t.tx -and $t.tx.TransactionType) {switch ($t.tx.TransactionType) {'Payment' {'Payment'} 'OfferCreate' {'Offer Create'} 'OfferCancel' {'Offer Cancel'} default {$t.tx.TransactionType}}} else {'N/A'}; $amt = if ($t.tx -and $t.tx.Amount) {if ($t.tx.Amount -is [string]) {[math]::Round(($t.tx.Amount/1000000),6)} else {[math]::Round(($t.tx.Amount/1000000),6)}} else {'-'}; Write-Host ($i.ToString() + '. ' + $type + ' | ' + $amt + ' XRP | ' + $time) -ForegroundColor Cyan}} else {Write-Host 'No transaction records available.' -ForegroundColor Yellow}} catch {Write-Host 'Error fetching transactions: ' + $_.Exception.Message -ForegroundColor Red}"
echo.
pause
goto menu

:arabicversion
echo Switching to Arabic version...
timeout /t 2 > nul
start "" "%~f0" arabic
exit

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
echo Thank you for using WorkHub Server
timeout /t 2 > nul
exit

:: ==============================================
:: Arabic Version (starts if parameter is passed)
:: ==============================================
:arabic
@echo off
chcp 65001 > nul
title WorkHub Server - نظام السيولة
cls

set "XRPL_ACCOUNT=rBb27Rh5jZBSmjCvmyVb6cVfRKhhmxUYK8"
set "APIURL=https://data.xrplf.org/v1/account/%XRPL_ACCOUNT%"

:menu_ar
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
echo [1] عرض رصيد تجريبي
echo [2] استعلام الرصيد المالي من XRPL
echo [3] جلب آخر 10 سجلات معاملات مالية
echo [4] التبديل إلى النسخة الإنجليزية
echo [5] تنظيف الشاشة
echo [6] الخروج
echo ================================================================
echo.
set /p choice="اختر رقم الأمر: "

if "%choice%"=="1" goto localbalance_ar
if "%choice%"=="2" goto fetchbalance_ar
if "%choice%"=="3" goto fetchhistory_ar
if "%choice%"=="4" goto englishversion
if "%choice%"=="5" goto clear_ar
if "%choice%"=="6" goto exit_ar
goto invalid_ar

:localbalance_ar
echo.
echo الرصيد التجريبي: 10,000 XRP
echo ملاحظة: هذه قيمة تجريبية. اختر الخيار 2 للبيانات الفعلية.
echo.
pause
goto menu_ar

:fetchbalance_ar
echo.
echo جاري استعلام الرصيد المالي من XRPL...
powershell -Command "try {$url = '%APIURL%'; $response = Invoke-RestMethod -Uri $url; if ($response.account_data -and $response.account_data.Balance) {$value = [math]::Round(($response.account_data.Balance/1000000),6); Write-Host ('الرصيد الحالي: ' + $value + ' XRP') -ForegroundColor Green} else {Write-Host 'تعذر العثور على بيانات الرصيد في الاستجابة.' -ForegroundColor Red}} catch {Write-Host 'خطأ في الاتصال بـ XRPL: ' + $_.Exception.Message -ForegroundColor Red}"
echo.
pause
goto menu_ar

:fetchhistory_ar
echo.
echo جلب آخر 10 سجلات معاملات مالية...
powershell -Command "try {$url = 'https://data.xrplf.org/v1/account/%XRPL_ACCOUNT%/transactions'; $response = Invoke-RestMethod -Uri $url; if ($response.transactions) {$i=0; foreach ($t in $response.transactions | Select-Object -First 10) {$i++; $time = if ($t.date) {(Get-Date $t.date -Format 'yyyy-MM-dd HH:mm')} else {'-'}; $type = if ($t.tx -and $t.tx.TransactionType) {switch ($t.tx.TransactionType) {'Payment' {'تحويل مالي'} 'OfferCreate' {'إنشاء عرض'} 'OfferCancel' {'إلغاء عرض'} default {$t.tx.TransactionType}}} else {'N/A'}; $amt = if ($t.tx -and $t.tx.Amount) {if ($t.tx.Amount -is [string]) {[math]::Round(($t.tx.Amount/1000000),6)} else {[math]::Round(($t.tx.Amount/1000000),6)}} else {'-'}; Write-Host ($i.ToString() + '. ' + $type + ' | ' + $amt + ' XRP | ' + $time) -ForegroundColor Cyan}} else {Write-Host 'لا توجد سجلات معاملات متاحة.' -ForegroundColor Yellow}} catch {Write-Host 'خطأ في جلب سجلات المعاملات: ' + $_.Exception.Message -ForegroundColor Red}"
echo.
pause
goto menu_ar

:englishversion
echo Switching to English version...
timeout /t 2 > nul
start "" "%~f0"
exit

:clear_ar
cls
goto menu_ar

:invalid_ar
echo.
echo خيار غير صحيح، يرجى المحاولة مرة أخرى.
echo.
pause
goto menu_ar

:exit_ar
echo.
echo شكراً لاستخدامك WorkHub Server
timeout /t 2 > nul
exit