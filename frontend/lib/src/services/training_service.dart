// Training service - tracking de fuerza (mock data + Supabase-ready)
// Robado del wizard de Strong + sistema de ejercicios de Jefit

import 'package:jefit_app/src/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TrainingService {
  final SupabaseClient client;

  TrainingService(this.client);

  // --- EJERCICIOS MOCK (reemplazar con Supabase cuando tengas credenciales) ---
  static final List<Map<String, dynamic>> ejerciciosMock = [
    {"eid": "1", "name": "Press de banca", "muscle_grupo": "pecho", "dificultad": 3, "category": "Empuje"},
    {"eid": "2", "name": "Sentadilla", "muscle_grupo": "piernas", "dificultad": 3, "category": "Piernas"},
    {"eid": "3", "name": "Peso muerto", "muscle_grupo": "espalda", "dificultad": 5, "category": "Tirón"},
    {"eid": "4", "name": "Remo con barra", "muscle_grupo": "espalda", "dificultad": 3, "category": "Tirón"},
    {"eid": "5", "name": "Press militar", "muscle_grupo": "hombros", "dificultad": 4, "category": "Empuje"},
    {"eid": "6", "name": "Curl de bíceps", "muscle_grupo": "brazos", "dificultad": 1, "category": "Aislamiento"},
    {"eid": "7", "name": "Extensión de tríceps", "muscle_grupo": "brazos", "dificultad": 2, "category": "Aislamiento"},
    {"eid": "8", "name": "Plancha", "muscle_grupo": "core", "dificultad": 1, "category": "Core"},
    {"eid": "9", "name": "Dominadas", "muscle_grupo": "espalda", "dificultad": 3, "category": "Tirón"},
    {"eid": "10", "name": "Gemelos de pie", "muscle_grupo": "piernas", "dificultad": 1, "category": "Piernas"},
  ];

  // --- TEMPLATES MOCK (planes de entrenamiento) ---
  static final Map<String, List<Map<String, String>>> templatesMock = {
    "Full Body": [
      {"eid": "2", "name": "Sentadilla"},
      {"eid": "1", "name": "Press de banca"},
      {"eid": "3", "name": "Peso muerto"},
      {"eid": "9", "name": "Dominadas"},
    ],
    "Push Pull Legs": [
      {"eid": "1", "name": "Press de banca"},
      {"eid": "5", "name": "Press militar"},
      {"eid": "7", "name": "Extensión tríceps"},
      {"eid": "4", "name": "Remo"},
      {"eid": "9", "name": "Dominadas"},
      {"eid": "6", "name": "Curl bíceps"},
      {"eid": "2", "name": "Sentadilla"},
      {"eid": "10", "name": "Gemelos"},
    ],
  };

  // --- GET ejercicios ---
  Future<List<Map<String, dynamic>>> getEjercicios() async {
    try {
      final res = await client.from('ejercicios').select();
      return res;
    } catch (e) {
      // Fallback a mock data
      return ejerciciosMock;
    }
  }

  // --- CREATE training log ---
  Future<Map<String, dynamic>> saveTrainingLog({
    required List<Map<String, dynamic>> ejercicios,
    int? metaGym,
    String? notas,
  }) async {
    try {
      final res = await client.from('training_logs').insert({
        'ejercicios': ejercicios,
        'meta_gym': metaGym,
        'notas': notas,
      }).select();
      return {'success': true, 'data': res.first};
    } catch (e) {
      // Mock: guardar en memoria (para testing)
      return {'success': true, 'data': {'message': 'Mock: log guardado (no conectado a Supabase)'}};
    }
  }

  // --- GET logs (historial) ---
  Future<List<Map<String, dynamic>>> getTrainingLogs() async {
    try {
      final res = await client
          .from('training_logs')
          .select()
          .order('date', ascending: false);
      return res;
    } catch (e) {
      return []; // mock
    }
  }

  // --- GET templates ---
  List<Map<String, String>> getTemplates() {
    return templatesMock.entries.map((e) => {
      'name': e.key,
      'ejercicios': e.value,
    }).toList();
  }
}
