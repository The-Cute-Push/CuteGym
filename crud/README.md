# 🏋️‍♂️ CUTEGYM — Projeto Fullstack com React, Node.js e SQL Server

Este é um projeto fullstack para cadastro e visualização de **aulas de academia**, utilizando:

- **Frontend**: React com Vite
- **Backend**: Node.js com Express
- **Banco de Dados**: SQL Server (via driver `msnodesqlv8`)
- **Banco de teste utilizado**: `DB_teste`

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
│   ├── components/
│   └── package.json
└── README.md
```

---

## 🧱 Banco de Dados

O projeto utiliza a tabela relacional `classes`, que se conecta às tabelas `users` (instrutores) e `modalities` por meio de **chaves estrangeiras**:

```sql
CREATE TABLE [classes] (
  [id_class] INT PRIMARY KEY IDENTITY(1,1) CHECK ([id_class] > 0),
  [id_modalities] TINYINT NOT NULL CHECK ([id_modalities] > 0),
  [id_instructor] INT NOT NULL CHECK ([id_instructor] > 0),
  [dt_hour_class] DATETIME NOT NULL,
  CONSTRAINT FK_Classes_Modalities FOREIGN KEY ([id_modalities]) REFERENCES [modalities] ([id_modalities]),
  CONSTRAINT FK_Classes_Instructor FOREIGN KEY ([id_instructor]) REFERENCES [users] ([id_user])
);
```

Além disso, o banco `DB_teste` já possui tabelas auxiliares como `modalities`, `users`, `address`, `phone`, `user_types`, entre outras.

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

A API estará disponível em: [http://localhost:3001](http://localhost:3001)

---

### 💻 Frontend (React + Vite)

1. Acesse a pasta `front`:

   ```bash
   cd front
   ```

2. Instale as dependências:

   ```bash
   npm install
   ```

3. Execute o servidor de desenvolvimento:

   ```bash
   npm run dev
   ```

Abra no navegador: [http://localhost:5173](http://localhost:5173)

---

## 📌 Observações

- O backend usa **autenticação Windows** com `trustedConnection: true`.
- O driver utilizado é `msnodesqlv8`, portanto o **SQL Server deve estar local e com o nome da instância correto**.
- A tabela `classes` foi atualizada para trabalhar com **id_modalities**, **id_instructor** e **dt_hour_class**, que são ligados a entidades reais do banco.
- A interface web permite **cadastro de aulas via formulário**, e exibe os dados com paginação.

---

## 🎨 Estilo

O front utiliza **CSS moderno com tema escuro** (Dark Theme), responsivo para telas menores e com efeitos de hover e destaque para melhor UX.

---

## 🛠️ Tecnologias Utilizadas

- Node.js
- Express
- React + Vite
- Axios
- SQL Server (T-SQL)
- msnodesqlv8
- CSS puro com estilo escuro

---

## 👨‍💻 Desenvolvedor

**Brendon Córdova**
