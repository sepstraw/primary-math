@echo off
chcp 936 >nul
setlocal
cd /d "%~dp0"

echo.
echo   小学数学可视化  本地预览
echo   ==================================
echo   目录: %CD%
echo.

where python >nul 2>nul
if errorlevel 1 goto trypy
start "预览服务 - 关掉这个窗口就停止" cmd /k "python -m http.server 8765 --bind 127.0.0.1"
goto open

:trypy
where py >nul 2>nul
if errorlevel 1 goto nopy
start "预览服务 - 关掉这个窗口就停止" cmd /k "py -3 -m http.server 8765 --bind 127.0.0.1"
goto open

:nopy
echo   没有找到 Python。
echo.
echo   两种办法:
echo     1. 安装 Python: https://www.python.org/downloads/
echo        安装时勾选 Add Python to PATH
echo     2. 或者用 VS Code 的 Live Server 插件
echo.
pause
exit /b

:open
echo   服务已在新窗口启动，3 秒后打开浏览器...
ping -n 4 127.0.0.1 >nul
start "" "http://127.0.0.1:8765/grade3/"

echo.
echo   如果浏览器没自动打开，手动访问:
echo       http://127.0.0.1:8765/grade3/
echo.
echo   那个「预览服务」窗口不要关，关了网页就打不开。
echo.
timeout /t 8 >nul
