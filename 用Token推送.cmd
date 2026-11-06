@echo off
chcp 936 >nul
setlocal
cd /d "%~dp0"

echo.
echo   用 Token 推送到 GitHub
echo   ==========================================
echo.
echo   先去这个地址生成一个 Token:
echo       https://github.com/settings/tokens/new
echo.
echo   生成时请注意:
echo     Note 随便填，比如 math
echo     Expiration 选 30 days 就行
echo     勾选 repo 这一整项
echo     点最下面 Generate token，把生成的字符串复制下来
echo.
echo   ------------------------------------------
echo.

set "TOKEN="
set /p TOKEN=把 Token 粘贴到这里，然后回车: 

if "%TOKEN%"=="" goto empty

echo.
echo   正在推送...
echo.

git push https://sepstraw:%TOKEN%@github.com/sepstraw/primary-math.git main
if errorlevel 1 goto failed

echo.
echo   推送成功
echo.
echo   仓库: https://github.com/sepstraw/primary-math
echo   下一步: Settings - Pages，Source 选 main 分支根目录
echo.
pause
exit /b

:empty
echo.
echo   没有输入 Token，已取消。
echo.
pause
exit /b

:failed
echo.
echo   推送失败，可能的原因:
echo     1. Token 复制不完整，或者已经过期
echo     2. 生成 Token 时没有勾选 repo 权限
echo     3. 仓库名不对，应该是 sepstraw/primary-math
echo     4. 网络连不上 github.com
echo.
pause
exit /b
