const express = require('express');
const router = express.Router();
const { getCupos, assignCupo } = require('../controllers/cupoController');
const { protect, entrenador } = require('../middleware/authMiddleware');

// GET /api/cupos - List trainer's cupos + alumnos
router.route('/').get(protect, entrenador, getCupos);

// POST /api/cupos/assign - Assign alumno to cupo
router.route('/assign').post(protect, entrenador, assignCupo);

module.exports = router;
