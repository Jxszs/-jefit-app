// Rank Screen - Body Map interactivo (robado de Symmetry)
// Toca el músculo → ves tu rank en ese ejercicio

import 'package:flutter/material.dart';
import 'package:jefit_app/src/theme/app_colors.dart';
import 'package:jefit_app/src/services/rank_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  late RankService rankService;
  List<Map<String, dynamic>> ranks = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    rankService = RankService(Supabase.instance.client);
    _loadRanks();
  }

  Future<void> _loadRanks() async {
    final data = await rankService.getUserRanks();
    setState(() {
      ranks = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rankTotal = rankService.calcularRankTotal(ranks);
    final badge = rankService.getBadgeByTotal(rankTotal);

    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBg,
        foregroundColor: AppColors.textPrimary,
        title: const Text('Mi fuerza'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator(color: AppColors.success))
          : CustomScrollView(
              slivers: [
                // Header: rank total + badge
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderDark, width: 1),
                      gradient: LinearGradient(
                        colors: [AppColors.cardBg, Color(0xFF2A2A32)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rank total', style: TextStyle(color: AppColors.textSecondary)),
                            Text('$rankTotal',
                                style: TextStyle(color: AppColors.trophy, fontSize: 28, fontWeight: FontWeight.bold)),
                            Text(badge, style: TextStyle(color: AppColors.trophy, fontSize: 16)),
                          ],
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.trophy,
                          ),
                          child: Icon(Icons.emoji_trophy, color: Colors.black, size: 48),
                        ),
                      ],
                    ),
                  ),
                ),
                // Body Map (grilla de músculos con ranks)
                SliverToBoxAdapter(child: _buildBodyMap()),
                // Lista de ejercicios con ranks
                SliverToBoxAdapter(child: _buildRankList()),
              ],
            ),
    );
  }

  Widget _buildBodyMap() {
    // Mapa de cuerpo: cada músculo es un botón con color según rank (robado de Symmetry)
    final muscleRanks = <String, Map<String, dynamic>>{};
    for (var r in ranks) {
      final m = r['muscle'] ?? r['ejercicios']?['muscle_grupo'] ?? 'unknown';
      if (!muscleRanks.containsKey(m)) muscleRanks[m] = r;
    }

    final muscleColors = {
      "pecho": AppColors.success,
      "piernas": AppColors.progress,
      "espalda": AppColors.trophy,
      "hombros": AppColors.success,
      "brazos": AppColors.textSecondary,
      "core": AppColors.progress,
    };

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mapa de fuerza',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
        SizedBox(height: 12),
        Wrap(
          spacing: 10,
          children: muscleRanks.entries.map((entry) {
            final rank = entry.value['rank'] ?? 0;
            final color = muscleColors[entry.key] ?? AppColors.textSecondary;
            // Color según rank: si rank < 30 = gris, 30-70 = color, 70+ = brillante
            final displayColor = rank < 30
                ? AppColors.textSecondary
                : rank < 70
                    ? color
                    : color.withOpacity(0.8);

            return GestureDetector(
              onTap: () {
                // TODO: Mostrar detalle del ejercicio del músculo
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: displayColor.withOpacity(0.3),
                  border: Border.all(color: displayColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${entry.key[0].toUpperCase()}${entry.key.substring(1)}',
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 11)),
                    Text('$rank', style: TextStyle(color: displayColor, fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
      ),
    );
  }

  Widget _buildRankList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ranks por ejercicio',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: ranks.length,
            itemBuilder: (_, i) {
              final r = ranks[i];
              final rank = r['rank'] ?? 0;
              final color = rank >= 70
                  ? AppColors.trophy
                  : rank >= 50
                      ? AppColors.success
                      : AppColors.textSecondary;
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderDark, width: 1),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: color.withOpacity(0.2),
                      child: Text('$rank', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r['ejercicio'] ?? r['ejercicios']?['name'] ?? 'Ejercicio',
                              style: TextStyle(color: AppColors.textPrimary)),
                          Text(r['badge'] ?? rankService.getBadgeByTotal(rank),
                              style: TextStyle(color: color, fontSize: 12)),
                        ],
                      ),
                    ),
                    Icon(Icons.trending_up, color: color),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
