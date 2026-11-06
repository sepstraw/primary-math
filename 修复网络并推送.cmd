@echo off
chcp 936 >nul
setlocal
cd /d "%~dp0"

echo.
echo   修复网络并推送
echo   ==========================================
echo   你的系统代理是 127.0.0.1:10808，但 git 默认不走代理。
echo   下面自动试几个常见端口，找到能用的就推送。
echo.

set "REMOTE=https://github.com/sepstraw/primary-math.git"
set "FOUND="

call :try "http://127.0.0.1:10808"
call :try "socks5h://127.0.0.1:10808"
call :try "http://127.0.0.1:10809"
call :try "socks5h://127.0.0.1:10809"
call :try "http://127.0.0.1:7890"

if not "%FOUND%"=="" goto found

echo.
echo   直连再试一次...
git -c http.proxy= ls-remote "%REMOTE%" >nul 2>&1
if errorlevel 1 goto noconn
set "FOUND=direct"
goto found

:noconn
echo.
echo   所有方式都连不上。检查一下:
echo     1. 代理软件是不是开着
echo     2. 代理端口是多少（v2rayN 在「设置 - 参数设置」里能看到）
echo     3. 把端口号告诉我，我改成对应的
echo.
pause
exit /b

:found
echo.
echo   使用: %FOUND%
echo.

if "%FOUND%"=="direct" goto direct
git config http.proxy "%FOUND%"
git config https.proxy "%FOUND%"
goto dopush

:direct
git config --unset http.proxy >nul 2>nul
git config --unset https.proxy >nul 2>nul

:dopush
git add -A
git commit -m "更新页面" >nul 2>nul
git branch -M main

echo   正在推送...
echo.
git push -u origin main
if errorlevel 1 goto failed

echo.
echo   推送成功
echo   仓库: https://github.com/sepstraw/primary-math
echo   下一步: Settings - Pages，Source 选 main 分支根目录
echo.
pause
exit /b

:failed
echo.
echo   连上了但推送失败，多半是权限问题。
echo   改用 Token 方式: 双击 用Token推送.cmd
echo.
pause
exit /b

:try
set "P=%~1"
echo   试 %P% ...
git -c http.proxy=%P% -c https.proxy=%P% ls-remote "%REMOTE%" >nul 2>&1
if errorlevel 1 goto :eof
set "FOUND=%P%"
echo       连上了
goto :eof
