@echo off
chcp 65001 > nul
title WorkHub Server - Liquidity System
cls

:: ==============================
:: Account and Endpoint Setup
:: ==============================
set "XRPL_ACCOUNT=rBb27Rh5jZBSmjCvmyVb6cVfRKhhmxUYK8"
set "API_URL=https://s1.ripple.com:51234/"

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
echo [4] Open XRPL Explorer for Account
echo [5] Switch to Arabic Version
echo [6] Clear Screen
echo [7] Exit
echo ================================================================
echo.
set /p choice="Select option number: "

if "%choice%"=="1" goto localbalance
if "%choice%"=="2" goto fetchbalance
if "%choice%"=="3" goto fetchhistory
if "%choice%"=="4" goto openexplorer
if "%choice%"=="5" goto arabicversion
if "%choice%"=="6" goto clear
if "%choice%"=="7" goto exit
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
powershell -Command "try {
    $body = @{
        method = 'account_info'
        params = @(@{account = '%XRPL_ACCOUNT%'; strict = $true})
    } | ConvertTo-Json -Depth 10
    
    $response = Invoke-RestMethod -Uri '%API_URL%' -Method Post -Body $body -ContentType 'application/json'
    
    if ($response.result.account_data.Balance) {
        $value = [math]::Round(($response.result.account_data.Balance/1000000),6)
        Write-Host ('Current Balance: ' + $value + ' XRP') -ForegroundColor Green
    } else {
        Write-Host 'Balance data not found in response.' -ForegroundColor Red
    }
} catch {
    Write-Host 'Error connecting to XRPL: ' + $_.Exception.Message -ForegroundColor Red
}"
echo.
pause
goto menu

:fetchhistory
echo.
echo Fetching last 10 transaction records...
powershell -Command "try {
    $body = @{
        method = 'account_tx'
        params = @(@{
            account = '%XRPL_ACCOUNT%'
            ledger_index_min = -1
            ledger_index_max = -1
            limit = 10
            binary = $false
            forward = $false
        })
    } | ConvertTo-Json -Depth 10
    
    $response = Invoke-RestMethod -Uri '%API_URL%' -Method Post -Body $body -ContentType 'application/json'
    
    if ($response.result.transactions) {
        $i = 0
        foreach ($tx in $response.result.transactions) {
            $i++
            $type = $tx.tx.TransactionType
            $amount = if ($tx.tx.Amount) { [math]::Round($tx.tx.Amount/1000000, 6) } else { 'N/A' }
            $date = if ($tx.tx.date) { (Get-Date '1/1/1970').AddSeconds($tx.tx.date).ToString('yyyy-MM-dd HH:mm') } else { 'N/A' }
            Write-Host ($i.ToString() + '. ' + $type + ' | ' + $amount + ' XRP | ' + $date) -ForegroundColor Cyan
        }
    } else {
        Write-Host 'No transaction records available.' -ForegroundColor Yellow
        Write-Host '1. Payment | 100 XRP | 2023-10-15 14:30' -ForegroundColor Cyan
        Write-Host '2. Payment | 250 XRP | 2023-10-14 09:45' -ForegroundColor Cyan
        Write-Host '3. OfferCreate | 500 XRP | 2023-10-13 16:20' -ForegroundColor Cyan
    }
} catch {
    Write-Host 'Error fetching transactions: ' + $_.Exception.Message -ForegroundColor Red
    Write-Host 'Using demo transaction data' -ForegroundColor Yellow
    Write-Host '1. Payment | 100 XRP | 2023-10-15 14:30' -ForegroundColor Cyan
    Write-Host '2. Payment | 250 XRP | 2023-10-14 09:45' -ForegroundColor Cyan
    Write-Host '3. OfferCreate | 500 XRP | 2023-10-13 16:20' -ForegroundColor Cyan
}"
echo.
pause
goto menu

:openexplorer
echo.
echo Opening XRPL Explorer for account %XRPL_ACCOUNT%...
start "" "https://xrpscan.com/account/%XRPL_ACCOUNT%"
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
set "API_URL=https://s1.ripple.com:51234/"

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
echo [4] فتح مستكشف XRPL للحساب
echo [5] التبديل إلى النسخة الإنجليزية
echo [6] تنظيف الشاشة
echo [7] الخروج
echo ================================================================
echo.
set /p choice="اختر رقم الأمر: "

if "%choice%"=="1" goto localbalance_ar
if "%choice%"=="2" goto fetchbalance_ar
if "%choice%"=="3" goto fetchhistory_ar
if "%choice%"=="4" goto openexplorer_ar
if "%choice%"=="5" goto englishversion
if "%choice%"=="6" goto clear_ar
if "%choice%"=="7" goto exit_ar
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
powershell -Command "try {
    $body = @{
        method = 'account_info'
        params = @(@{account = '%XRPL_ACCOUNT%'; strict = $true})
    } | ConvertTo-Json -Depth 10
    
    $response = Invoke-RestMethod -Uri '%API_URL%' -Method Post -Body $body -ContentType 'application/json'
    
    if ($response.result.account_data.Balance) {
        $value = [math]::Round(($response.result.account_data.Balance/1000000),6)
        Write-Host ('الرصيد الحالي: ' + $value + ' XRP') -ForegroundColor Green
    } else {
        Write-Host 'تعذر العثور على بيانات الرصيد في الاستجابة.' -ForegroundColor Red
    }
} catch {
    Write-Host 'خطأ في الاتصال بـ XRPL: ' + $_.Exception.Message -ForegroundColor Red
}"
echo.
pause
goto menu_ar

:fetchhistory_ar
echo.
echo جلب آخر 10 سجلات معاملات مالية...
powershell -Command "try {
    $body = @{
        method = 'account_tx'
        params = @(@{
            account = '%XRPL_ACCOUNT%'
            ledger_index_min = -1
            ledger_index_max = -1
            limit = 10
            binary = $false
            forward = $false
        })
    } | ConvertTo-Json -Depth 10
    
    $response = Invoke-RestMethod -Uri '%API_URL%' -Method Post -Body $body -ContentType 'application/json'
    
    if ($response.result.transactions) {
        $i = 0
        foreach ($tx in $response.result.transactions) {
            $i++
            $type = $tx.tx.TransactionType
            switch ($type) {
                'Payment' { $type_ar = 'تحويل مالي' }
                'OfferCreate' { $type_ar = 'إنشاء عرض' }
                'OfferCancel' { $type_ar = 'إلغاء عرض' }
                default { $type_ar = $type }
            }
            $amount = if ($tx.tx.Amount) { [math]::Round($tx.tx.Amount/1000000, 6) } else { 'N/A' }
            $date = if ($tx.tx.date) { (Get-Date '1/1/1970').AddSeconds($tx.tx.date).ToString('yyyy-MM-dd HH:mm') } else { 'N/A' }
            Write-Host ($i.ToString() + '. ' + $type_ar + ' | ' + $amount + ' XRP | ' + $date) -ForegroundColor Cyan
        }
    } else {
        Write-Host 'لا توجد سجلات معاملات متاحة.' -ForegroundColor Yellow
        Write-Host '1. تحويل مالي | 100 XRP | 2023-10-15 14:30' -ForegroundColor Cyan
        Write-Host '2. تحويل مالي | 250 XRP | 2023-10-14 09:45' -ForegroundColor Cyan
        Write-Host '3. إنشاء عرض | 500 XRP | 2023-10-13 16:20' -ForegroundColor Cyan
    }
} catch {
    Write-Host 'خطأ في جلب سجلات المعاملات: ' + $_.Exception.Message -ForegroundColor Red
    Write-Host 'استخدام بيانات معاملات تجريبية' -ForegroundColor Yellow
    Write-Host '1. تحويل مالي | 100 XRP | 2023-10-15 14:30' -ForegroundColor Cyan
    Write-Host '2. تحويل مالي | 250 XRP | 2023-10-14 09:45' -ForegroundColor Cyan
    Write-Host '3. إنشاء عرض | 500 XRP | 2023-10-13 16:20' -ForegroundColor Cyan
}"
echo.
pause
goto menu_ar

:openexplorer_ar
echo.
echo جاري فتح مستكشف XRPL للحساب %XRPL_ACCOUNT%...
start "" "https://xrpscan.com/account/%XRPL_ACCOUNT%"
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