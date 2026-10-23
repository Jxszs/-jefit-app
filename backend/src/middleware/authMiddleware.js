const jwt = require('jsonwebtoken');
const User = require('../models/User');

// Verificar JWT token
const protect = async (req, res, next) => {
  let token;

  if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
    try {
      token = req.headers.authorization.split(' ')[1];
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      req.user = await User.findById(decoded.id).select('-password_hash');
      next();
    } catch (error) {
      res.status(401).json({ message: 'Token inválido' });
    }
  }

  if (!token) {
    res.status(401).json({ message: 'Sin autorización, token faltante' });
  }
};

// Verificar rol de ENTRENADOR
const entrenador = (req, res, next) => {
  if (req.user && req.user.role === 'ENTRENADOR') {
    next();
  } else {
    res.status(403).json({ message: 'Acceso restringido a entrenadores' });
  }
};

module.exports = { protect, entrenador };
