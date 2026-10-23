const express = require('express');
const router = express.Router();
const { getEjercicios, getEjercicioById } = require('../controllers/exerciseController');
const { protect } = require('../middleware/authMiddleware');

// GET /api/ejercicios - List all exercises
router.route('/').get(protect, getEjercicios);

// GET /api/ejercicios/:id - Get single exercise
router.route('/:id').get(protect, getEjercicioById);

module.exports = router;
