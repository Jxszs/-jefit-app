// Training log controller - robado del wizard de Strong
const { supabase } = require('../utils/supabaseClient');

// POST /api/tracking/log
const createTrainingLog = async (req, res) => {
  const { ejercicios, meta_gym, notas } = req.body;

  try {
    const { data, error } = await supabase.from('training_logs').insert({
      user_id: req.user.id,
      date: new Date().toISOString().split('T')[0],
      ejercicios,
      meta_gym,
      notas,
    }).select();

    if (error) return res.status(400).json({ message: error.message });

    // Trigger rank calculation (calls Python via RPC)
    await supabase.rpc('calculate_user_ranks', { target_user_id: req.user.id });

    res.status(201).json(data[0]);
  } catch (err) {
    res.status(500).json({ message: 'Error al guardar entrenamiento' });
  }
};

// GET /api/tracking/logs
const getTrainingLogs = async (req, res) => {
  const { data, error } = await supabase
    .from('training_logs')
    .select('*')
    .eq('user_id', req.user.id)
    .order('date', { ascending: false });

  if (error) return res.status(400).json({ message: error.message });
  res.json(data);
};

module.exports = { createTrainingLog, getTrainingLogs };
