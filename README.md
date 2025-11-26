# Diário de Enxaqueca

Sistema de gerenciamento de crises de enxaqueca com backend FastAPI, autenticação JWT e frontend React.

## 🚀 Deploy no Railway

### Pré-requisitos
- Conta no [Railway](https://railway.app)
- Projeto GitHub conectado

### Passos para Deploy

1. **Criar projeto no Railway**
   - Conecte seu repositório GitHub
   - Railway detectará automaticamente os serviços

2. **Configurar variáveis de ambiente**

   Para cada serviço, configure as seguintes variáveis:

   #### Backend Service:
   ```
   MYSQL_HOST=containers-us-west-XXX.railway.app
   MYSQL_PORT=XXXX
   MYSQL_USER=root
   MYSQL_PASSWORD=********
   MYSQL_DB=diario_enxaqueca
   MYSQL_SSL_CA=/app/ca.pem
   MYSQL_USE_SSL=true
   SECRET_KEY=your-secret-key-here
   ENVIRONMENT=production
   ```

   #### Auth Service:
   ```
   MYSQL_HOST=containers-us-west-XXX.railway.app
   MYSQL_PORT=XXXX
   MYSQL_USER=root
   MYSQL_PASSWORD=********
   MYSQL_DB=diario_enxaqueca
   MYSQL_SSL_CA=/app/ca.pem
   MYSQL_USE_SSL=true
   SECRET_KEY=your-secret-key-here
   ENVIRONMENT=production
   ```

   #### Frontend Service:
   ```
   BACKEND_URL=https://your-backend-service-url.railway.app
   AUTH_URL=https://your-auth-service-url.railway.app
   BACKEND_SSL_VERIFY=on
   AUTH_SSL_VERIFY=on
   ```

3. **Configurar domínio (opcional)**
   - Vá para Settings > Domains
   - Adicione seu domínio customizado

4. **Verificar deploy**
   - Acesse a URL do frontend
   - Teste login/cadastro
   - Verifique se as APIs estão respondendo

## 🐳 Desenvolvimento Local

### Pré-requisitos
- Docker e Docker Compose
- Node.js 18+ (para desenvolvimento frontend)
- Python 3.11+ (para desenvolvimento backend)

### Executar localmente

```bash
# Clonar repositório
git clone <repository-url>
cd diario-enxaqueca

# 🚀 Opção 1: Iniciar com captura automática de logs (recomendado)
.\scripts\start-with-logs.ps1

# Opção 2: Iniciar sem logs automáticos
docker compose up --build -d

# Verificar status
docker compose ps

# Ver logs (se não estiver usando captura automática)
docker compose logs -f
```

#### Scripts de Gerenciamento

```bash
# Iniciar containers + captura de logs automática
.\scripts\start-with-logs.ps1

# Iniciar sem rebuild (mais rápido)
.\scripts\start-with-logs.ps1 -NoBuild

# Limpar tudo e reiniciar
.\scripts\start-with-logs.ps1 -Clean

# Parar captura de logs
.\scripts\stop-logs.ps1

# Capturar logs atuais (snapshot)
.\scripts\capture-logs.ps1

# Executar todos os testes
.\scripts\run-all-tests.ps1
```

### Endpoints locais
- Frontend: http://localhost:3000
- Backend API: http://localhost:8000
- Auth Service: http://localhost:8001
- Database: localhost:3306

## 📁 Estrutura do Projeto

```
├── backend/          # API FastAPI
├── autenticacao/     # Serviço de autenticação
├── frontend/         # Interface React/Vite
├── documentacao/     # Documentação
├── docker-compose.yml
└── .env.example      # Exemplo de variáveis
```

## 🔧 Configuração de Ambiente

### Produção vs Desenvolvimento

| Variável | Desenvolvimento | Produção |
|----------|----------------|----------|
| BACKEND_URL | http://backend:8000 | https://your-backend.railway.app |
| AUTH_URL | http://auth:8001 | https://your-auth.railway.app |
| SSL_VERIFY | off | on |

### Arquivos de Configuração
- `.env.example` - Exemplo para desenvolvimento
- `.env.production.example` - Exemplo para produção
- `.env.prod` - Configurações de produção

## 🧪 Testes

```bash
# Testes do backend
docker compose run --rm tests

# Testes do auth
docker compose run --rm tests-auth

# Testes E2E com Selenium (interface completa)
docker compose --profile tests run --rm selenium-tests

# Lint
docker compose run --rm lint
```

### Testes Selenium

Os testes E2E (end-to-end) com Selenium testam a interface completa do usuário:

- **test_diariodeenxaquecaloginlogout.py** - Login e logout
- **test_diariodeenxaquecaCRUDusuario.py** - CRUD de usuários
- **test_diariodeenxaquecaCRUDgatilho.py** - CRUD de gatilhos
- **test_diariodeenxaquecaCRUDmedicacao.py** - CRUD de medicações
- **test_diariodeenxaquecaCRUDepisodio.py** - CRUD de episódios

**Pré-requisitos para execução:**
1. Todos os serviços devem estar rodando (`docker compose up -d`)
2. Frontend acessível em `http://localhost:3000`
3. Banco de dados populado com dados de teste

## 📚 Documentação

Consulte a pasta `documentacao/` para:
- Diagramas UML
- Documentação da API
- Guias de usuário

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT.