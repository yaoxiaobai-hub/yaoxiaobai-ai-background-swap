<#
yaoxiaobai-ai-background-swap 一键发布脚本
把运行中的 skill 同步到本地发布目录并推送到 GitHub。
用法：powershell -ExecutionPolicy Bypass -File publish.ps1
#>
$ErrorActionPreference = "Stop"

$src  = "C:\Users\YYDS\AppData\Local\Doubao\User Data\Profile 1\.doubao\agent_mode\workspace\.user_skills\yaoxiaobai-ai-background-swap"
$pub  = "D:\YYDS\GitHub\yaoxiaobai-ai-background-swap"
$dest = Join-Path $pub "yaoxiaobai-ai-background-swap"

if (-not (Test-Path $src)) { Write-Error "找不到源 skill：$src"; exit 1 }
if (-not (Test-Path $pub)) { Write-Error "找不到发布目录：$pub"; exit 1 }

Write-Host "==> 1/3 同步 skill 文件到发布目录"
Copy-Item (Join-Path $src "*") $dest -Recurse -Force
Get-ChildItem $dest -Recurse -File | ForEach-Object { Write-Host ("    " + $_.FullName.Replace($pub, "")) }

Write-Host "==> 2/3 提交"
Set-Location $pub
git add -A
$msg = "sync skill: " + (Get-Date -Format "yyyy-MM-dd HH:mm")
git commit -m $msg

Write-Host "==> 3/3 推送到 GitHub"
git push

Write-Host "完成，已发布到 https://github.com/yaoxiaobai-hub/yaoxiaobai-ai-background-swap"
