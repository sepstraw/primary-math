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
if errorlevel 1 (
  echo   没有找到 git，请先安装: https://git-scm.com/downloads
  echo.
  pause
  exit /b
)

if not exist ".git" (
  echo   [1/5] 初始化仓库...
  git init
  git branch -M main
) else (
  echo   [1/5] 已经是 git 仓库，跳过
)

git remote get-url origin >nul 2>nul
if errorlevel 1 (
  echo   [2/5] 设置远程地址...
  git remote add origin https://github.com/sepstraw/primary-math.git
) else (
  echo   [2/5] 已有 origin，跳过
)

echo   [3/5] 添加文件...
git add -A

echo   [4/5] 提交...
git commit -m "三年级四套单元页" 2>nul

echo   [5/5] 推送...
echo.
echo   第一次推送会弹出 GitHub 登录窗口，用你的账号登录即可。
echo.
git push -u origin main

if errorlevel 1 (
  echo.
  echo   推送失败，常见原因:
  echo     1. GitHub 上还没有 primary-math 仓库
  echo        去 https://github.com/new 建一个，名字填 primary-math
  echo        不要勾 Add a README，建好再运行本脚本
  echo     2. 没有登录或没有权限
  echo     3. 网络连不上 github.com
  echo.
) else (
  echo.
  echo   推送成功
  echo   仓库: https://github.com/sepstraw/primary-math
  echo   接着去 Settings - Pages，Source 选 main 分支根目录
  echo.
)
pause
