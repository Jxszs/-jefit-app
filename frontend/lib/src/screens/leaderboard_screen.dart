// Leaderboard Screen - competencias entre amigos (robado de Strava)
import 'package:flutter/material.dart';
import 'package:jefit_app/src/theme/app_colors.dart';
import 'package:jefit_app/src/services/rank_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late RankService rankService;
  List<Map<String, dynamic>> leaderboard = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    rankService = RankService(Supabase.instance.client);
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    final data = await rankService.getLeaderboard();
    setState(() {
      leaderboard = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBg,
        foregroundColor: AppColors.textPrimary,
        title: const Text('Leaderboard'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator(color: AppColors.success))
          : ListView.builder(
              itemCount: leaderboard.length,
              itemBuilder: (_, i) {
                final user = leaderboard[i];
                final rankTotal = user['rank_total'] ?? 0;
                final badge = user['badge'] ?? '';
                final isTop3 = i < 3;
                final avatarColor = isTop3
                    ? [AppColors.trophy, AppColors.success, AppColors.progress][i]
                    : AppColors.borderDark;

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderDark, width: 1),
                    gradient: isTop3
                        ? LinearGradient(colors: [Color(0xFF2A2A32), AppColors.cardBg])
                        : null,
                  ),
                  child: Row(
                    children: [
                      // Posición
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: avatarColor.withOpacity(0.3),
                          shape: BoxShape.circle,
                          border: Border.all(color: avatarColor, width: 1.5),
                        ),
                        child: Center(
                          child: Text('#${i + 1}',
                              style: TextStyle(color: avatarColor, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 12),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: avatarColor,
                        child: Text('${user['name']?.substring(0, 1) ?? '?'}',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user['name'] ?? 'Anónimo',
                                style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                            Text(badge, style: TextStyle(color: AppColors.trophy, fontSize: 12)),
                          ],
                        ),
                      ),
                      Text('$rankTotal',
                          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
