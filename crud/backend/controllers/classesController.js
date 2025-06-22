
const { sql } = require('../db');

// Buscar todas as aulas
async function getAllClasses(req, res) {
  try {
    const result = await sql.query('SELECT * FROM Classes');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).send(err.message);
  }
}

// Cadastrar nova aula
async function createClass(req, res) {
  const { modality, instructor, duration } = req.body;
  try {
    await sql.query`
      INSERT INTO Classes (modality, instructor, duration)
      VALUES (${modality}, ${instructor}, ${duration})`;
    res.status(201).send('Aula cadastrada!');
  } catch (err) {
    res.status(500).send(err.message);
  }
}

module.exports = {
  getAllClasses,
  createClass
};
