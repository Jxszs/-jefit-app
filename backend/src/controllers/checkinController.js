// Checkin controller - robado del heatmap de Habitica/Symmetry
const { supabase } = require('../utils/supabaseClient');

// POST /api/checkin — Toggle check-in del día
const toggleCheckin = async (req, res) => {
  const today = new Date().toISOString().split('T')[0];

  try {
    // Verificar si ya hay check-in de hoy
    const { data: existing, error: errFind } = await supabase
      .from('checkins')
      .select('*')
      .eq('user_id', req.user.id)
      .eq('date', today)
      .single();

    if (existing) {
      // Si existe, toggle
      const { data, error } = await supabase
        .from('checkins')
        .update({ marcado: !existing.marcado, hora: new Date().toISOString() })
        .eq('id', existing.id)
        .select();

      // Actualizar streak en profiles
      await actualizarStreak(req.user.id);
      return res.json({ marcado: data[0].marcado });
    }

    // Crear nuevo check-in
    const { data, error } = await supabase.from('checkins').insert({
      user_id: req.user.id,
      date: today,
      marcado: true,
      hora: new Date().toISOString()
    }).select();

    await actualizarStreak(req.user.id);
    res.json({ marcado: data[0].marcado });
  } catch (err) {
    res.status(500).json({ message: 'Error al marcar check-in' });
  }
};

// GET /api/checkin/history?dias=30
const getCheckinHistory = async (req, res) => {
  const dias = parseInt(req.query.dias) || 30;
  const fromDate = new Date(Date.now() - dias * 24 * 60 * 60 * 1000);

  const { data, error } = await supabase
    .from('checkins')
    .select('*')
    .eq('user_id', req.user.id)
    .gte('date', fromDate.toISOString().split('T')[0])
    .order('date', { ascending: false });

  if (error) return res.status(400).json({ message: error.message });
  res.json(data);
};

async function actualizarStreak(userId) {
  // Calcular streak basado en check-ins consecutivos
  const { data, error } = await supabase
    .from('checkins')
    .select('date, marcado')
    .eq('user_id', userId)
    .eq('marcado', true)
    .order('date', { ascending: false })
    .limit(30);

  let streak = 0;
  let currentDate = new Date();
  for (const check of data) {
    const checkDate = new Date(check.date);
    const diffDays = Math.floor((currentDate - checkDate) / (1000 * 60 * 60 * 24));
    if (diffDays <= streak + 1 && diffDays >= 0) {
      if (diffDays === streak + 1 || diffDays === 0) streak++;
      currentDate = checkDate;
    }
  }

  await supabase.from('profiles').update({ streak_count: streak }).eq('id', userId);
}

module.exports = { toggleCheckin, getCheckinHistory };
