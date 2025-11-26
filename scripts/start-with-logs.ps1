# start-with-logs.ps1
# Script para iniciar containers com captura automática de logs
# Uso: .\scripts\start-with-logs.ps1

param(
    [switch]$NoBuild,
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'

# Cores para output
$Green = "Green"
$Yellow = "Yellow"
$Red = "Red"
$Cyan = "Cyan"

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message
}

# Verificar se estamos na raiz do projeto
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$repoRoot = Resolve-Path (Join-Path $scriptDir '..')
Set-Location -Path $repoRoot

Write-ColorOutput "[START] Iniciando containers com captura de logs..." $Green
Write-ColorOutput "Diretório: $repoRoot" $Cyan

# Limpar containers se solicitado
if ($Clean) {
    Write-ColorOutput "🧹 Limpando containers e volumes..." $Yellow
    docker compose down -v --remove-orphans 2>$null
    Write-ColorOutput "[OK] Limpeza concluída" $Green
}

# Build e iniciar containers
if ($NoBuild) {
    Write-ColorOutput "📦 Iniciando containers (sem rebuild)..." $Cyan
    docker compose up -d
} else {
    Write-ColorOutput "🔨 Fazendo build e iniciando containers..." $Cyan
    docker compose up --build -d
}

# Aguardar containers ficarem saudáveis
Write-ColorOutput "[WAIT] Aguardando containers ficarem saudáveis..." $Yellow
Start-Sleep -Seconds 5

# Verificar status dos containers
Write-ColorOutput "📊 Status dos containers:" $Cyan
docker compose ps

# Iniciar captura de logs
Write-ColorOutput "📝 Iniciando captura de logs..." $Green

$logsDir = Join-Path $repoRoot 'logs'
if (-Not (Test-Path $logsDir)) {
    New-Item -Path $logsDir -ItemType Directory | Out-Null
}

# Parar jobs de log existentes
$existingJobs = Get-Job -Name 'log_*' -ErrorAction SilentlyContinue
if ($existingJobs) {
    Write-ColorOutput "🛑 Parando jobs de log existentes..." $Yellow
    $existingJobs | Stop-Job -ErrorAction SilentlyContinue
    $existingJobs | Remove-Job -ErrorAction SilentlyContinue
}

# Get list of services from docker compose
$services = docker compose ps --services
if (-not $services) {
    Write-ColorOutput "⚠️ Nenhum serviço encontrado!" $Red
    exit 1
}

$jobCount = 0
foreach ($s in $services) {
    $jobName = "log_$s"
    $file = Join-Path $logsDir "$s.log"

    Write-ColorOutput "📄 Iniciando captura: $s → $file" $Cyan

    Start-Job -Name $jobName -ScriptBlock {
        param($service, $filePath, $workDir)

        try {
            Set-Location -Path $workDir
        } catch {
            Write-Warning "Could not Set-Location to $workDir inside job: $_"
        }

        $composeFile = Join-Path $workDir 'docker-compose.yml'
        try {
            docker compose -f $composeFile logs --no-color -f $service 2>&1 | Tee-Object -FilePath $filePath
        } catch {
            Write-Warning "Erro ao capturar logs de ${service}: $($_.Exception.Message)"
        }
    } -ArgumentList $s, $file, $repoRoot | Out-Null

    $jobCount++
}

Write-ColorOutput "[OK] $jobCount jobs de captura de logs iniciados!" $Green
Write-ColorOutput "[LOGS] Logs sendo salvos em: $logsDir" $Cyan

# Mostrar comandos úteis
Write-ColorOutput "`n[INFO] Comandos uteis:" $Yellow
Write-ColorOutput "  • Ver jobs ativos: Get-Job -Name 'log_*'" $White
Write-ColorOutput "  • Parar logs: .\scripts\stop-logs.ps1" $White
Write-ColorOutput "  • Ver logs: Get-Content .\logs\<servico>.log -Tail 50" $White
Write-ColorOutput "  • Parar containers: docker compose down" $White

Write-ColorOutput "`n[SUCCESS] Setup completo! Containers rodando com logs sendo capturados." $Green