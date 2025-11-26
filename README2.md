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

# Subir todos os serviços
docker compose up --build -d

# Verificar status
docker compose ps

# Ver logs
docker compose logs -f
```

### Endpoints locais
- Frontend: http://localhost:3000
- Backend API: http://localhost:8000
- Auth Service: http://localhost:8001
- Database: localhost:3306

## 📁 Estrutura do Projeto

```
├───autenticacao            # Serviço de autenticação
│   ├───auth
│   └───config
├───backend                 # API FastAPI
│   ├───config
│   ├───mysql-init
│   └───source
│       ├───episodio
│       ├───gatilho
│       ├───medicacao
│       └───usuario
├───documentacao            # Documentação
│   ├───assets
│   ├───docs
|   ├───logs
|   └───scripts
└───frontend                # Interface React/Vite
    ├───build
    ├───node_modules
    ├───src
    └───tests-selenium
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

# Lint
docker compose run --rm lint
```

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