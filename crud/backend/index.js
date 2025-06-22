const express = require('express');
const cors = require('cors');
const { connectDB } = require('./db');
const classRoutes = require('./routes/classes');

const app = express();
app.use(cors());
app.use(express.json());

connectDB();

app.use('/classes', classRoutes);

const PORT = process.env.PORT || 3002;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`🚀 API rodando em http://localhost:${PORT}`);
});

