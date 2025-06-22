
const express = require('express');
const router = express.Router();
const controller = require('../controllers/classesController');

// Rota para listar todas as aulas
router.get('/', controller.getAllClasses);

// Rota para cadastrar uma nova aula
router.post('/', controller.createClass);

router.get('/modalities', controller.getAllModalities);
router.get('/instructors', controller.getAllInstructors);


module.exports = router;
