require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
const PORT = process.env.PORT || 5000;

// Middlewares
app.use(cors());
app.use(express.json());

// Routes
app.get('/', (req, res) => {
  res.json({ message: 'JEFIT APP API - Ready' });
});

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/jefit_app')
  .then(() => console.log('MongoDB conectado'))
  .catch(err => console.error('MongoDB error:', err));

app.listen(PORT, () => {
  console.log(`Server corriendo en puerto ${PORT}`);
});
