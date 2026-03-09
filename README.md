# PROMEC

Sistema **White Label para pequenas oficinas mecânicas**, permitindo que diferentes oficinas utilizem a mesma base de software com personalização de marca e identidade.

O sistema é composto por três partes principais:

- **Backend:** API em Node.js
- **Banco de dados:** PostgreSQL
- **Aplicação Mobile:** Flutter

---

# Arquitetura do Projeto

O projeto está dividido em duas partes principais:

```
promec/
│
├── backend/      → API e regras de negócio (Node.js)
│
└── mobile/       → Aplicativo mobile (Flutter)
```

### Backend

Responsável por:

- Regras de negócio
- Autenticação de usuários
- Comunicação com banco de dados
- APIs utilizadas pelo aplicativo mobile

Tecnologias utilizadas:

- Node.js
- Express
- PostgreSQL

### Mobile

Aplicativo utilizado pelos usuários finais (oficinas).

Tecnologias utilizadas:

- Flutter
- Dart

---

# Pré-requisitos

Antes de iniciar o projeto, instale os seguintes softwares:

- Node.js (versão 18 ou superior)
- PostgreSQL
- Flutter SDK
- Git

---

# 1 - Clonar o repositório

```bash
git clone https://github.com/Dev-Rodrigo-Marins/promec_gti.git
```

Entre na pasta do projeto:

```bash
cd promec_gti
```

---

# 2 - Configurar o Backend

Entre na pasta do backend:

```bash
cd backend
```

Instale as dependências do Node.js:

```bash
npm install
```

Configure as variáveis de ambiente (caso exista arquivo `.env.example`):

```
DB_HOST=
DB_PORT=
DB_USER=
DB_PASSWORD=
DB_DATABASE=
```

Certifique-se de que o **PostgreSQL está rodando** e que o banco de dados foi criado.

---

# 3 - Iniciar o servidor de aplicação

Ainda dentro da pasta **backend**, execute:

```bash
npm run dev
```

Esse comando irá:

- iniciar o servidor Node.js
- ativar o modo de desenvolvimento
- recarregar automaticamente quando houver alterações no código

Se tudo estiver correto, a API estará disponível em algo como:

```
http://localhost:3000
```

---

# 4 - Executar o aplicativo mobile

Abra **outro terminal**.

Entre na pasta do aplicativo mobile:

```bash
cd mobile
```

Instale as dependências do Flutter:

```bash
flutter pub get
```

Conecte um dispositivo ou inicie um emulador.

Depois execute:

```bash
flutter run
```

O Flutter irá:

- compilar o aplicativo
- instalar no dispositivo/emulador
- iniciar o app conectado à API

---

# Fluxo de funcionamento

```
Flutter App
     │
     │ HTTP / JSON
     ▼
Node.js API
     │
     │ SQL Queries
     ▼
PostgreSQL Database
```

---

# Objetivo do Projeto

O **PROMEC** foi criado para atender **pequenas oficinas mecânicas**, oferecendo funcionalidades como:

- cadastro de clientes
- cadastro de veículos
- criação de orçamentos
- controle de serviços
- gestão básica da oficina

Por ser um **sistema White Label**, a mesma base pode ser utilizada por diferentes oficinas com personalizações de:

- nome
- logotipo
- cores
- identidade visual

---

# Contribuição

1. Faça um fork do projeto

2. Crie uma branch para sua feature

```bash
git checkout -b minha-feature
```

3. Commit suas alterações

```bash
git commit -m "minha nova feature"
```

4. Envie para o repositório

```bash
git push origin minha-feature
```

5. Abra um Pull Request
