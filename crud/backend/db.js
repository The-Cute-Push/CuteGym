const sql = require('mssql/msnodesqlv8');

const config = {
  server: 'WIN-GG66KL1BPKP\\SQL2017',
  database: 'BD_teste',
  driver: 'msnodesqlv8',
  options: {
    trustedConnection: true
  }
};

async function connectDB() {
  try {
    await sql.connect(config);
    console.log('✅ Conectado ao SQL Server via msnodesqlv8');
  } catch (error) {
    console.error('Erro ao conectar:', error);
  }
}

module.exports = { sql, connectDB };
