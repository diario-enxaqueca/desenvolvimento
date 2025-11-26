# Script para executar todos os testes do projeto
Write-Host "=== Executando testes do Backend ===" -ForegroundColor Cyan
docker compose up --build tests

Write-Host "`n=== Executando testes de Autenticação ===" -ForegroundColor Cyan
docker compose up --build tests-auth

Write-Host "`n=== Executando testes E2E com Selenium ===" -ForegroundColor Cyan
Write-Host "Nota: Certifique-se de que todos os serviços estão rodando com 'docker compose up -d'" -ForegroundColor Yellow
docker compose --profile tests run --rm selenium-tests

Write-Host "`n=== Todos os testes concluídos ===" -ForegroundColor Green
