const { sql } = require('../db');

// 🎓 Classes
async function getAllClasses(req, res) {
  try {
    const result = await sql.query(`
      SELECT 
        c.id_class AS id,
        m.name AS modality,
        u.nm_user AS instructor,
        FORMAT(c.dt_hour_class, 'yyyy-MM-dd HH:mm') AS datetime
      FROM classes c
      INNER JOIN modalities m ON c.id_modalities = m.id_modalities
      INNER JOIN users u ON c.id_instructor = u.id_user
    `);
    res.json(result.recordset);
  } catch (err) {
    res.status(500).send(err.message);
  }
}

async function createClass(req, res) {
  const { id_modalities, id_instructor, dt_hour_class } = req.body;
  try {
    await sql.query`
      INSERT INTO classes (id_modalities, id_instructor, dt_hour_class)
      VALUES (${id_modalities}, ${id_instructor}, ${dt_hour_class})
    `;
    res.status(201).send('Aula cadastrada com sucesso!');
  } catch (err) {
    res.status(500).send(err.message);
  }
}

// 🏋️ Modalidades
async function getAllModalities(req, res) {
  try {
    const result = await sql.query(`SELECT id_modalities AS id, name FROM modalities`);
    res.json(result.recordset);
  } catch (err) {
    res.status(500).send(err.message);
  }
}

// Instrutores
async function getAllInstructors(req, res) {
  try {
    const result = await sql.query(`
      SELECT id_user AS id, nm_user AS name
      FROM users
      WHERE id_user_type = 2
    `);
    res.json(result.recordset);
  } catch (err) {
    res.status(500).send(err.message);
  }
}


module.exports = {
  getAllClasses,
  createClass,
  getAllModalities,
  getAllInstructors
};
