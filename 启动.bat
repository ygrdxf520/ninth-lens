@echo off
chcp 65001 >nul
title 第九镜头 - AI 智能视频创作平台

echo ========================================
echo    第九镜头 - AI 智能视频创作平台
echo ========================================
echo.

REM 检查 Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Node.js，请先安装 Node.js 20+
    echo 下载地址: https://nodejs.org/
    pause
    exit /b 1
)

REM 检查 pnpm
where pnpm >nul 2>nul
if %errorlevel% neq 0 (
    echo [提示] 正在安装 pnpm...
    npm install -g pnpm
)

REM 检查 Python
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Python，请先安装 Python 3.12+
    echo 下载地址: https://www.python.org/downloads/
    pause
    exit /b 1
)

echo [1/3] 启动后端服务...
cd /d "%~dp0server"
start "第九镜头-后端" cmd /k "uv run uvicorn server.app:app --host 0.0.0.0 --port 1241"

REM 等待后端启动
timeout /t 5 /nobreak >nul

echo [2/3] 启动前端服务...
cd /d "%~dp0frontend"
start "第九镜头-前端" cmd /k "pnpm dev"

REM 等待前端启动
timeout /t 10 /nobreak >nul

echo [3/3] 打开浏览器...
start http://localhost:5173

echo.
echo ========================================
echo   启动完成！
echo   前端地址: http://localhost:5173
echo   后端地址: http://localhost:1241
echo ========================================
echo.
echo 提示：关闭此窗口不会停止服务
echo       请在弹出的两个 cmd 窗口中停止
echo.
pause
