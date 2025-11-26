#!/usr/bin/env pwsh
<#
stop-logs.ps1
Para todos os jobs de captura de logs em background e remove arquivos de log.
Uso: Execute na raiz do repositório ou use .\scripts\stop-logs.ps1
#>

Write-Host "🛑 Parando jobs de captura de logs..." -ForegroundColor Yellow

# Parar e remover jobs
$jobs = Get-Job -Name 'log_*' -ErrorAction SilentlyContinue
if ($jobs) {
    Write-Host "Parando $($jobs.Count) job(s)..." -ForegroundColor Cyan
    $jobs | Stop-Job -ErrorAction SilentlyContinue
    $jobs | Remove-Job -ErrorAction SilentlyContinue
    Write-Host "✅ Jobs removidos" -ForegroundColor Green
} else {
    Write-Host "ℹ️ Nenhum job de log ativo encontrado" -ForegroundColor Blue
}

# Remover arquivos de log
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$logsPath = Join-Path $scriptDir '..\logs\*.log'
$logsPath = (Resolve-Path -Path $logsPath -ErrorAction SilentlyContinue).Path 2>$null

if ($null -ne $logsPath) {
    Write-Host "🗑️ Removendo arquivos de log: $logsPath" -ForegroundColor Cyan
    Remove-Item -Path $logsPath -Force -ErrorAction SilentlyContinue
    Write-Host "✅ Arquivos de log removidos" -ForegroundColor Green
} else {
    Write-Host "ℹ️ Nenhum arquivo de log encontrado" -ForegroundColor Blue
}

Write-Host "🎉 Captura de logs finalizada!" -ForegroundColor Green
    # Fallback: try relative path from current working directory
    $fallback = "./logs/*.log"
    Write-Output "No logs found at expected path; attempting fallback: $fallback"
    Remove-Item -Path $fallback -Force -ErrorAction SilentlyContinue
}

Write-Output "Stopped log jobs and removed log files (if any)."
# docker compose down