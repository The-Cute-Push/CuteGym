# 🏋️‍♂️ CUTEGYM — Projeto Fullstack com React, Node.js e SQL Server

Este é um projeto fullstack de cadastro de aulas de academia, utilizando:

- **Frontend**: React com Vite
- **Backend**: Node.js com Express
- **Banco de dados**: SQL Server (usando o driver `msnodesqlv8`)
- **Banco de teste**: `DB_teste`

---

## 🗃️ Estrutura do Projeto

```
/
├── backend/        # API Express conectando ao SQL Server
│   ├── index.js
│   ├── db.js
│   ├── routes/
│   ├── controllers/
│   └── package.json
├── front/          # Aplicação React com Vite
│   ├── src/
│   ├── App.jsx
│   └── package.json
└── README.md
```

---

## 🧱 Banco de Dados

O projeto utiliza um banco de teste chamado `DB_teste`. A tabela usada é:

```sql
CREATE TABLE Classes (
  id INT IDENTITY(1,1) PRIMARY KEY,
  modality NVARCHAR(100),
  instructor NVARCHAR(100),
  duration NVARCHAR(50)
);
```

Certifique-se de que o SQL Server esteja **executando localmente** e que o nome da instância no `db.js` esteja correto (exemplo: `WIN-GG66KL1BPKP\SQL2017`).

---

## ▶️ Como rodar o projeto

### 🔧 Backend (API)

1. Navegue até a pasta `backend`:
   ```bash
   cd backend
   ```

2. Instale as dependências:
   ```bash
   npm install
   ```

3. Inicie a API:
   ```bash
   npm start
   ```

A API rodará em: [http://localhost:3001](http://localhost:3001)

---

### 💻 Frontend (React + Vite)

1. Navegue até a pasta `front`:
   ```bash
   cd front
   ```

2. Instale as dependências:
   ```bash
   npm install
   ```

3. Inicie o servidor de desenvolvimento:
   ```bash
   npm run dev
   ```

A aplicação React abrirá normalmente no navegador (geralmente em [http://localhost:5173](http://localhost:5173)).

---

## 📌 Observações

- O backend conecta ao banco SQL Server usando autenticação Windows (`trustedConnection: true`).
- Verifique se o servidor SQL está aceitando conexões locais via `msnodesqlv8`.
- Caso use `.env` para configurações, **não esqueça de adicioná-lo ao `.gitignore`**.

---

## 🛠️ Tecnologias Utilizadas

- Node.js
- Express
- MSSQL (`msnodesqlv8`)
- React
- Vite
- Axios
- CSS moderno com modo escuro (Dark Theme)

---

## 👨‍💻 Desenvolvedor

**Brendon Córdova**