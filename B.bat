@echo off
chcp 65001 > nul
title WorkHub Server - نظام السيولة
cls

rem -- تعريف الحساب وendpoint
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
echo                 WorkHub Server v2.0 - نظام السيولة
echo.
echo [1] ملاحظة: الرجاء استخدام الاستعلام من المصدر
echo [2] استعلام بيانات السيولة من المصدر
echo [3] جلب سجلات المعاملات المالية
echo [4] تنظيف الشاشة
echo [5] الخروج
echo.
set /p choice="اختر رقم الأمر: "

if "%choice%"=="1" goto localbalance
if "%choice%"=="2" goto fetchbalance
if "%choice%"=="3" goto fetchhistory
if "%choice%"=="4" goto clear
if "%choice%"=="5" goto exit
goto menu

:localbalance
echo.
echo ⚠️  لا يتم عرض أرقام محلية. الرجاء اختيار [2] للاستعلام المباشر من المصدر.
echo.
pause
goto menu

:fetchbalance
echo.
echo جاري استعلام بيانات السيولة من المصدر...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "try { $j = Invoke-RestMethod -Uri '%APIURL%'; if ($j.account_data -and $j.account_data.Balance) { $value = [math]::Round(($j.account_data.Balance/1000000),6); Write-Host ('✅ مستوى السيولة الحالي (WorkHub): ' + $value + ' وحدة سيولة') } else { Write-Host 'تعذر العثور على بيانات السيولة في الاستجابة.' } } catch { Write-Host 'خطأ أثناء الاتصال بالمصدر أو الشبكة: ' + $_.Exception.Message }"
echo.
pause
goto menu

:fetchhistory
echo.
echo جلب سجلات المعاملات المالية (أخر 10 سجلات)...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "try { $url = 'https://api.xrpscan.com/api/v1/account/%XRPL_ACCOUNT%/transactions'; $j = Invoke-RestMethod -Uri $url; if ($j.transactions) { $i=0; foreach ($t in $j.transactions | Select-Object -First 10) { $i++; $time = if ($t.date) { (Get-Date $t.date -Format 'yyyy-MM-dd HH:mm') } else { '-' }; $type = if ($t.type) { $t.type } else { 'N/A' }; $amt = if ($t.amount) { [math]::Round(($t.amount/1000000),6) } else { '-' }; Write-Host ($i.ToString() + '. ' + $type + ' | ' + $amt + ' وحدة سيولة | ' + $time) } } else { Write-Host 'لا توجد سجلات متاحة أو المسار غير مدعوم.' } } catch { Write-Host 'خطأ أثناء جلب سجلات المعاملات: ' + $_.Exception.Message }"
echo.
pause
goto menu

:clear
cls
goto menu

:exit
echo.
echo شكراً لاستخدامك WorkHub Server
timeout /t 1 > nul
exit /b
