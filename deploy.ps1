# Reason Network 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://reasonmachines.com/network
# 更新日期：2026-11-02
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

irm https://reasonmachines.com/network/install.ps1 | iex
reason-network who
Write-Host "登录后把邀请链接发给队友，他们的电脑用同一账号加入"

Write-Host ''

Write-Host '部署完成'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://reasonmachines.com/network'
