// Cupo controller - sistema de cupos (robado de Smart Fit)
// Entrenador tiene N cupos, alumnos los ocupan

const cuposPorPlan = {
  TRIAL: 0,
  PRO: 10,
};

// Estado de cupos (mock - reemplazar con Supabase)
const cuposMock = {
  trainer_1: {
    id: 'cupo_1',
    entrenador_id: 'trainer_1',
    cupos_total: 10,
    cupos_used: 3,
    cupos_disponibles: 7,
    alumnos: [
      { id: 'alumno_1', name: 'Carlos', rank_total: 210, badge: 'Héroe 🥉', progreso: 75 },
      { id: 'alumno_2', name: 'Ana', rank_total: 320, badge: 'Guerrero 🥈', progreso: 90 },
      { id: 'alumno_3', name: 'Luis', rank_total: 150, badge: 'Novato 🪙', progreso: 40 },
    ],
  },
};

// GET /api/cupos (entrenador)
const getCupos = async (req, res) => {
  try {
    const trainerId = req.user.id;
    // TODO: Reemplazar con Supabase: SELECT * FROM cupos WHERE entrenador_id = trainerId
    const mockCupo = cuposMock[`trainer_${trainerId?.substring(0, 1)}`] || cuposMock['trainer_1'];
    res.json(mockCupo);
  } catch (err) {
    res.status(500).json({ message: 'Error al obtener cupos' });
  }
};

// POST /api/cupos/assign
const assignCupo = async (req, res) => {
  const { alumno_id, start_date, end_date } = req.body;
  try {
    // TODO: Supabase insert
    res.status(201).json({
      message: 'Cupo asignado',
      entrenador_id: req.user.id,
      alumno_id,
      start_date,
      end_date,
      estado: 'ACTIVO',
    });
  } catch (err) {
    res.status(500).json({ message: 'Error al asignar cupo' });
  }
};

module.exports = { getCupos, assignCupo, cuposPorPlan };
