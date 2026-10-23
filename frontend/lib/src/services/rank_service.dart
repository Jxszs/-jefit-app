// Rank service - robado del sistema de ranks de Symmetry
// Rank 0-100 por ejercicio + badges

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:jefit_app/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RankService {
  final SupabaseClient client;

  RankService(this.client);

  // --- RANKS MOCK (reemplazar con Supabase) ---
  static final Map<String, Map<String, dynamic>> ranksMock = {
    "1": {"ejercicio": "Press de banca", "rank": 78, "badge": "Guerrero 🥈", "muscle": "pecho"},
    "2": {"ejercicio": "Sentadilla", "rank": 92, "badge": "Titán 🥇", "muscle": "piernas"},
    "3": {"ejercicio": "Peso muerto", "rank": 45, "badge": "Héroe 🥉", "muscle": "espalda"},
    "4": {"ejercicio": "Remo", "rank": 30, "badge": "Guerrero Jr. 🛡️", "muscle": "espalda"},
    "5": {"ejercicio": "Press militar", "rank": 65, "badge": "Guerrero 🥈", "muscle": "hombros"},
    "6": {"ejercicio": "Curl bíceps", "rank": 15, "badge": "Novato 🪙", "muscle": "brazos"},
    "7": {"ejercicio": "Plancha", "rank": 80, "badge": "Guerrero 🥈", "muscle": "core"},
  };

  // --- LEADERBOARD MOCK ---
  static final List<Map<String, dynamic>> leaderboardMock = [
    {"name": "Jesús", "rank_total": 405, "badge": "Titán 🥇", "level": "Titán"},
    {"name": "Carlos", "rank_total": 380, "badge": "Guerrero 🥈", "level": "Guerrero"},
    {"name": "Ana", "rank_total": 355, "badge": "Guerrero 🥈", "level": "Guerrero"},
    {"name": "Luis", "rank_total": 320, "badge": "Héroe 🥉", "level": "Héroe"},
    {"name": "Tú", "rank_total": 120, "badge": "Novato 🪙", "level": "Novato"},
  ];

  // GET user ranks (all exercises)
  Future<List<Map<String, dynamic>>> getUserRanks() async {
    try {
      final res = await client.from('ranks').select('*, ejercicios(*)');
      return res;
    } catch (e) {
      return ranksMock.values.map((v) => {"id": "mock_${v["ejercicio"]}", ...v}).toList();
    }
  }

  // GET leaderboard (friends)
  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    try {
      final res = await client.rpc('get_leaderboard');
      return res;
    } catch (e) {
      return leaderboardMock;
    }
  }

  // Calcular rank total (suma de todos)
  int calcularRankTotal(List<Map<String, dynamic>> ranks) {
    return ranks.fold<int>(0, (sum, r) => sum + (r['rank'] ?? 0));
  }

  // Badge según rank total (robado de Symmetry)
  String getBadgeByTotal(int rankTotal) {
    if (rankTotal >= 400) return "Titán 🥇";
    if (rankTotal >= 300) return "Guerrero 🥈";
    if (rankTotal >= 200) return "Héroe 🥉";
    if (rankTotal >= 100) return "Guerrero Jr. 🛡️";
    return "Novato 🪙";
  }
}
