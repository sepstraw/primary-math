@echo off
chcp 936 >nul
setlocal
cd /d "%~dp0"

echo.
echo   推送到 GitHub  sepstraw/primary-math
echo   ==========================================
echo   当前目录: %CD%
echo.

where git >nul 2>nul
if not errorlevel 1 goto gitok
echo   没有找到 git，请先安装: https://git-scm.com/downloads
echo.
pause
exit /b
:gitok

if exist ".git" goto hasgit
echo   [1/5] 初始化仓库...
git init
goto identity
:hasgit
echo   [1/5] 已经是 git 仓库

:identity
echo   [2/5] 检查提交身份...
git config user.name >nul 2>nul
if not errorlevel 1 goto idok
git config user.name "sepstraw"
git config user.email "sepstraw@users.noreply.github.com"
echo         之前没有设置，已补上默认身份
goto remote
:idok
echo         身份已存在

:remote
git remote get-url origin >nul 2>nul
if not errorlevel 1 goto remok
echo   [3/5] 设置远程地址...
git remote add origin https://github.com/sepstraw/primary-math.git
goto add
:remok
echo   [3/5] 远程地址已存在

:add
echo   [4/5] 添加并提交...
git add -A
git commit -m "更新页面"
git branch -M main

echo   [5/5] 推送...
echo.
echo   第一次推送会弹出 GitHub 登录窗口，用你的账号登录即可。
echo.
git push -u origin main
if not errorlevel 1 goto ok

echo.
echo   推送失败，常见原因:
echo     1. GitHub 上还没有 primary-math 仓库
echo        去 https://github.com/new 建一个，名字填 primary-math
echo     2. 没有登录或没有权限
echo     3. 网络连不上 github.com
echo.
pause
exit /b

:ok
echo.
echo   推送成功
echo   仓库: https://github.com/sepstraw/primary-math
echo   下一步: Settings - Pages，Source 选 main 分支根目录
echo.
pause
exit /b
