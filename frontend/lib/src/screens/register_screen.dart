import 'package:flutter/material.dart';
import 'package:jefit_app/src/theme/app_colors.dart';
import 'package:jefit_app/src/services/auth_service.dart';
import 'package:jefit_app/src/screens/dashboard_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _role = 'USER';
  bool loading = false;
  late AuthService auth;

  @override
  void initState() {
    super.initState();
    auth = AuthService(Supabase.instance.client);
  }

  void _register() async {
    setState(() => loading = true);
    final result = await auth.register(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
      role: _role,
    );
    setState(() => loading = false);
    if (result['success']) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${result['error']}'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBg,
        foregroundColor: AppColors.textPrimary,
        title: const Text('Crear cuenta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Role selector (robado de Smart Fit)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Usuario'),
                  selected: _role == 'USER',
                  onSelected: (_) => setState(() => _role = 'USER'),
                  backgroundColor: AppColors.cardBg,
                  selectedColor: AppColors.success,
                  labelStyle: TextStyle(color: _role == 'USER' ? Colors.black : AppColors.textSecondary),
                ),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text('Entrenador'),
                  selected: _role == 'ENTRENADOR',
                  onSelected: (_) => setState(() => _role = 'ENTRENADOR'),
                  backgroundColor: AppColors.cardBg,
                  selectedColor: AppColors.trophy,
                  labelStyle: TextStyle(color: _role == 'ENTRENADOR' ? Colors.black : AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Form fields
            _buildField(_nameCtrl, 'Nombre', false),
            const SizedBox(height: 20),
            _buildField(_emailCtrl, 'Email', false),
            const SizedBox(height: 20),
            _buildField(_passCtrl, 'Password', true),
            const SizedBox(height: 30),
            // Register button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _role == 'ENTRENADOR' ? AppColors.trophy : AppColors.success,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: loading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                    : const Text('CREAR CUENTA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, bool obscure) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSecondary),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.borderDark), borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.success), borderRadius: BorderRadius.circular(8)),
      ),
      style: TextStyle(color: AppColors.textPrimary),
      obscureText: obscure,
    );
  }
}
