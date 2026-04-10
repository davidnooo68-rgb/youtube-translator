# 视频双语朗读 - v1.2 打包+上传脚本 (PowerShell)
# 使用方法: 右键此文件 → 使用 PowerShell 运行

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   视频双语朗读 - v1.2 打包+上传脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 切换到脚本所在目录
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

Write-Host "[1/5] 正在打包插件..." -ForegroundColor Yellow
$zipPath = Join-Path $scriptPath "视频双语朗读-v1.2.zip"
$extensionPath = Join-Path $scriptPath "extension"

if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
}

Compress-Archive -Path "$extensionPath\*" -DestinationPath $zipPath -Force
Write-Host "      完成: 视频双语朗读-v1.2.zip" -ForegroundColor Green
Write-Host ""

Write-Host "[2/5] 配置Git..." -ForegroundColor Yellow
git config core.autocrlf false
git config core.quotepath false
Write-Host "      Git配置完成" -ForegroundColor Green
Write-Host ""

Write-Host "[3/5] 添加文件到Git..." -ForegroundColor Yellow
git add index.html
if (Test-Path $zipPath) {
    git add "视频双语朗读-v1.2.zip"
}
git add extension/
Write-Host "      文件已添加" -ForegroundColor Green
Write-Host ""

Write-Host "[4/5] 提交更改..." -ForegroundColor Yellow
$commitMessage = "v1.2: 支持多平台(B站/爱奇艺/抖音/知乎)，优化UI"
git commit -m $commitMessage
Write-Host "      提交完成" -ForegroundColor Green
Write-Host ""

Write-Host "[5/5] 推送到GitHub..." -ForegroundColor Yellow
git push origin main
Write-Host "      推送完成" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "   完成！访问:" -ForegroundColor Green
Write-Host "   https://davidnooo68-rgb.github.io/youtube-translator/" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Green

Read-Host "按回车键退出"
