
const express = require('express');
const cors = require('cors');
const { connectDB } = require('./db');
const classRoutes = require('./routes/classes');

const app = express();
app.use(cors());
app.use(express.json());

// Conectar ao banco
connectDB();

// Rotas da aplicação
app.use('/classes', classRoutes);

// Iniciar servidor
const PORT = 3001;
app.listen(PORT, () => {
  console.log(`🚀 API rodando em http://localhost:${PORT}`);
});
