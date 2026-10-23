const express = require('express');
const router = express.Router();
const { toggleCheckin, getCheckinHistory } = require('../controllers/checkinController');
const { protect } = require('../middleware/authMiddleware');

router.route('/')
  .post(protect, toggleCheckin);                    // POST /api/checkin

router.route('/history')
  .get(protect, getCheckinHistory);                // GET  /api/checkin/history

module.exports = router;
