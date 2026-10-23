// Exercise controller - mock data (reemplazar con Supabase)
// Robado de la base de datos de ejercicios de Jefit

let ejercicios = [
  { id: 1, name: "Press de banca", muscle_grupo: "pecho", dificultad: 3, category: "Empuje" },
  { id: 2, name: "Sentadilla", muscle_grupo: "piernas", dificultad: 3, category: "Piernas" },
  { id: 3, name: "Peso muerto", muscle_grupo: "espalda", dificultad: 5, category: "Tirón" },
  { id: 4, name: "Remo con barra", muscle_grupo: "espalda", dificultad: 3, category: "Tirón" },
  { id: 5, name: "Press militar", muscle_grupo: "hombros", dificultad: 4, category: "Empuje" },
  { id: 6, name: "Curl de bíceps", muscle_grupo: "brazos", dificultad: 1, category: "Aislamiento" },
  { id: 7, name: "Extensión de tríceps", muscle_grupo: "brazos", dificultad: 2, category: "Aislamiento" },
  { id: 8, name: "Plancha", muscle_grupo: "core", dificultad: 1, category: "Core" },
  { id: 9, name: "Dominadas", muscle_grupo: "espalda", dificultad: 3, category: "Tirón" },
  { id: 10, name: "Gemelos de pie", muscle_grupo: "piernas", dificultad: 1, category: "Piernas" },
];

// GET /api/ejercicios
const getEjercicios = async (req, res) => {
  // TODO: Reemplazar con Supabase cuando esté configurado
  try {
    res.json(ejercicios);
  } catch (err) {
    res.status(500).json({ message: 'Error al obtener ejercicios' });
  }
};

// GET /api/ejercicios/:id
const getEjercicioById = async (req, res) => {
  const ej = ejercicios.find(e => e.id === parseInt(req.params.id));
  if (!ej) return res.status(404).json({ message: 'Ejercicio no encontrado' });
  res.json(ejercicios);
};

module.exports = { getEjercicios, getEjercicioById };
