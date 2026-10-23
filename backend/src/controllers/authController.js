const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const { v4: uuidv4 } = require('uuid');
const User = require('../models/User');

// Generar JWT
const generarToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, { expiresIn: '30d' });
};

// POST /api/auth/register
const registerUser = async (req, res) => {
  const { name, email, password, role } = req.body;

  try {
    // Verificar si usuario existe
    let user = await User.findOne({ email });
    if (user) return res.status(400).json({ message: 'Usuario ya existe' });

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    user = await User.create({
      uid: uuidv4(),
      name,
      email,
      password_hash: hashedPassword,
      role: role || 'USER',
      cupos_total: role === 'ENTRENADOR' ? 10 : 0,
    });

    res.status(201).json({
      _id: user._id,
      uid: user.uid,
      name: user.name,
      email: user.email,
      role: user.role,
      plan: user.plan,
      token: generarToken(user._id),
    });
  } catch (error) {
    res.status(500).json({ message: 'Error en el servidor', error: error.message });
  }
};

// POST /api/auth/login
const loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ message: 'Credenciales inválidas' });

    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) return res.status(400).json({ message: 'Credenciales inválidas' });

    res.json({
      _id: user._id,
      uid: user.uid,
      name: user.name,
      email: user.email,
      role: user.role,
      plan: user.plan,
      token: generarToken(user._id),
    });
  } catch (error) {
    res.status(500).json({ message: 'Error en el servidor' });
  }
};

// GET /api/auth/me
const getUserProfile = async (req, res) => {
  const user = req.user;
  res.json({
    _id: user._id,
    uid: user.uid,
    name: user.name,
    email: user.email,
    role: user.role,
    plan: user.plan,
    body_weight: user.body_weight,
    cupos_used: user.cupos_used,
    cupos_total: user.cupos_total,
    streak_count: user.streak_count,
  });
};

module.exports = { registerUser, loginUser, getUserProfile };
