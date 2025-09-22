@echo off
chcp 65001 > nul
title WorkHub Server - نظام السيولة
cls

:: ==============================
:: إعداد الحساب و الـ Endpoint
:: ==============================
set "XRPL_ACCOUNT=rBb27Rh5jZBSmjCvmyVb6cVfRKhhmxUYK8"
set "APIURL=https://api.xrpscan.com/api/v1/account/%XRPL_ACCOUNT%"

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
echo                WorkHub Server v2.0 - نظام السيولة
echo ================================================================
echo [1] ملاحظة: الرجاء استخدام الاستعلام من المصدر
echo [2] استعلام الرصيد المالي من المصدر
echo [3] جلب آخر 10 سجلات معاملات مالية
echo [4] تنظيف الشاشة
echo [5] الخروج
echo ================================================================
echo.
set /p choice="اختر رقم الأمر: "

if "%choice%"=="1" goto localbalance
if "%choice%"=="2" goto fetchbalance
if "%choice%"=="3" goto fetchhistory
if "%choice%"=="4" goto clear
if "%choice%"=="5" goto exit
goto invalid

:localbalance
echo.
echo ⚠️  لا يتم عرض أرقام محلية. الرجاء اختيار [2] للاستعلام المباشر من المصدر.
echo.
pause
goto menu

:fetchbalance
echo.
echo جاري استعلام الرصيد المالي من المصدر...
powershell -Command "try {$url = '%APIURL%'; $response = Invoke-RestMethod -Uri $url; if ($response.balance) {$value = [math]::Round(($response.balance/1000000),6); Write-Host ('💰 الرصيد المالي الحالي (WorkHub): ' + $value + ' XRP') -ForegroundColor Green} elseif ($response.account_data -and $response.account_data.Balance) {$value = [math]::Round(($response.account_data.Balance/1000000),6); Write-Host ('💰 الرصيد المالي الحالي (WorkHub): ' + $value + ' XRP') -ForegroundColor Green} else {Write-Host '❌ تعذر العثور على بيانات الرصيد في الاستجابة.' -ForegroundColor Red}} catch {Write-Host '❌ خطأ أثناء الاتصال بالمصدر أو الشبكة: ' + $_.Exception.Message -ForegroundColor Red}"
echo.
pause
goto menu

:fetchhistory
echo.
echo جلب آخر 10 سجلات معاملات مالية...
powershell -Command "try {$url = 'https://api.xrpscan.com/api/v1/account/%XRPL_ACCOUNT%/transactions'; $response = Invoke-RestMethod -Uri $url; if ($response.transactions) {$i=0; foreach ($t in $response.transactions | Select-Object -First 10) {$i++; $time = if ($t.date) {(Get-Date $t.date -Format 'yyyy-MM-dd HH:mm')} else {'-'}; $type = if ($t.type) {switch ($t.type) {'Payment' {'تحويل مالي'} 'OfferCreate' {'إنشاء عرض'} 'OfferCancel' {'إلغاء عرض'} default {$t.type}}} else {'N/A'}; $amt = if ($t.amount) {[math]::Round(($t.amount/1000000),6)} else {'-'}; Write-Host ($i.ToString() + '. ' + $type + ' | ' + $amt + ' XRP | ' + $time) -ForegroundColor Cyan}} else {Write-Host '⚠️ لا توجد سجلات متاحة أو المسار غير مدعوم.' -ForegroundColor Yellow}} catch {Write-Host '❌ خطأ أثناء جلب سجلات المعاملات: ' + $_.Exception.Message -ForegroundColor Red}"
echo.
pause
goto menu

:clear
cls
goto menu

:invalid
echo.
echo ❌ خيار غير صحيح، حاول مرة أخرى.
echo.
pause
goto menu

:exit
echo.
echo شكراً لاستخدامك WorkHub Server
timeout /t 2 > nul
exit