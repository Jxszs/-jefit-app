import 'package:flutter/material.dart';
import 'package:jefit_app/src/theme/app_colors.dart';
import 'package:jefit_app/src/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late AuthService auth;
  Map<String, dynamic>? userProfile;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    auth = AuthService(Supabase.instance.client);
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user != null) {
      final res = await client.from('profiles').select().eq('id', user.id).single();
      setState(() {
        userProfile = res;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        backgroundColor: AppColors.primaryBg,
        body: Center(child: CircularProgressIndicator(color: AppColors.success)),
      );
    }

    final role = userProfile?['role'] ?? 'USER';

    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: CustomScrollView(
        slivers: [
          // App bar con nombre + rol
          SliverAppBar(
            backgroundColor: AppColors.primaryBg,
            foregroundColor: AppColors.textPrimary,
            title: Text(
              'JEFIT APP',
              style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications, color: AppColors.textPrimary),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: nombre + streak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, ${userProfile?['name'] ?? 'Jesús'}',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            role == 'ENTRENADOR' ? 'Entrenador • Plan PRO' : 'Plan gratuito',
                            style: TextStyle(color: role == 'ENTRENADOR' ? AppColors.trophy : AppColors.textSecondary),
                          ),
                        ],
                      ),
                      // Streak counter (Symmetry style)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.local_fire_department, color: AppColors.trophy, size: 20),
                            SizedBox(width: 6),
                            Text(
                              '${userProfile?['streak_count'] ?? 0}',
                              style: TextStyle(color: AppColors.trophy, fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Stats cards
                  _buildStatsCards(),
                  SizedBox(height: 24),
                  // Quick actions
                  Text('Acciones rápidas',
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  _buildQuickActions(),
                  SizedBox(height: 24),
                  // Recent workouts (empty state)
                  _buildRecentWorkouts(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.success,
        foregroundColor: Colors.black,
        onPressed: () {
          // TODO: Navigator a TrainingWizardScreen (feature/tracking)
        },
        child: Icon(Icons.add, size: 28),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(child: _statCard('Ranks', '24/30', Icons.bar_chart_rounded)),
        SizedBox(width: 12),
        Expanded(child: _statCard('Check-ins', '12d', Icons.calendar_today)),
        SizedBox(width: 12),
        Expanded(child: _statCard('Cupos', roleHint(), Icons.workspace_premium)),
      ],
    );
  }

  String roleHint() {
    final role = userProfile?['role'] ?? 'USER';
    if (role == 'ENTRENADOR') {
      final used = userProfile?['cupos_used'] ?? 0;
      final total = userProfile?['cupos_total'] ?? 0;
      return '$used/$total';
    }
    return '0/1';
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderDark, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.success, size: 20),
          SizedBox(height: 8),
          Text(value, style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionBtn(Icons.fitness_center, 'Entrenar', AppColors.success),
        _actionBtn(Icons.check_circle, 'Check-in', AppColors.success),
        _actionBtn(Icons.leaderboard, 'Ranking', AppColors.trophy),
        _actionBtn(Icons.person, 'Perfil', AppColors.textSecondary),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderDark, width: 1),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 6),
        Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildRecentWorkouts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Últimos entrenamientos',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
        SizedBox(height: 12),
        // Empty state (robado del estilo de Symmetry)
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderDark, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_ic_call, color: AppColors.textSecondary, size: 32),
              SizedBox(height: 8),
              Text('Presiona + para tu primer entrenamiento',
                  style: TextStyle(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}
