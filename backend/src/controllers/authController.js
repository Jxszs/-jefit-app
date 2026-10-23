// Auth controller - robado del flujo de Smart Fit + JWT
const bcrypt = require('bcryptjs');
const { v4: uuidv4 } = require('uuid');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const { supabase } = require('../utils/supabaseClient');

const generarToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, { expiresIn: '30d' });
};

// Register (User o Entrenador) — Smart Fit style role selector
const registerUser = async (req, res) => {
  const { name, email, password, role } = req.body;

  try {
    let existing = await supabase.from('profiles').select('id').eq('email', email).single();
    if (existing.data) return res.status(400).json({ message: 'Usuario ya existe' });

    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: { data: { name, role: role || 'USER', cupos_total: role === 'ENTRENADOR' ? 10 : 0 } }
    });

    if (error) return res.status(400).json({ message: error.message });

    res.status(201).json({
      uid: data.user?.id,
      name,
      email,
      role: role || 'USER',
      token: generarToken(data.user?.id),
    });
  } catch (err) {
    res.status(500).json({ message: 'Error en el servidor' });
  }
};

// Login
const loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    const { data, error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) return res.status(400).json({ message: 'Credenciales inválidas' });

    const profile = await supabase.from('profiles').select().eq('id', data.user?.id).single();

    res.json({
      uid: data.user?.id,
      ...profile.data,
      token: generarToken(data.user?.id),
    });
  } catch (err) {
    res.status(500).json({ message: 'Error en el servidor' });
  }
};

// Perfil
const getUserProfile = async (req, res) => {
  const { data, error } = await supabase.from('profiles')
    .select('name, role, plan, body_weight, cupos_used, cupos_total, streak_count')
    .eq('id', req.user.id)
    .single();

  if (error) return res.status(400).json({ message: error.message });
  res.json({ uid: req.user.id, ...data });
};

module.exports = { registerUser, loginUser, getUserProfile };
