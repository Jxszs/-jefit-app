const express = require('express');
const router = express.Router();
const { createTrainingLog, getTrainingLogs } = require('../controllers/trainingController');
const { protect } = require('../middleware/authMiddleware');

router.route('/')
  .post(protect, createTrainingLog)      // POST /api/tracking/log
  .get(protect, getTrainingLogs);        // GET  /api/tracking/logs

module.exports = router;
