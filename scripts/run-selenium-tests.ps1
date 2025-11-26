# Script para executar testes Selenium E2E
# Uso: .\run-selenium-tests.ps1

Write-Host "🚀 Executando testes Selenium E2E..." -ForegroundColor Green
Write-Host "Pré-requisitos:" -ForegroundColor Yellow
Write-Host "  - Todos os serviços devem estar rodando (docker compose up -d)" -ForegroundColor Yellow
Write-Host "  - Frontend deve estar acessível em http://localhost:3000" -ForegroundColor Yellow
Write-Host ""

# Verificar se os serviços estão rodando
Write-Host "📋 Verificando status dos serviços..." -ForegroundColor Blue
docker compose ps

Write-Host ""
Write-Host "🧪 Executando testes Selenium..." -ForegroundColor Green
docker compose --profile tests run --rm selenium-tests

Write-Host ""
Write-Host "✅ Testes finalizados!" -ForegroundColor Green