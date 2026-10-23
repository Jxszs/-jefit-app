import 'package:flutter/material.dart';
import 'package:jefit_app/src/theme/app_colors.dart';
import 'package:jefit_app/src/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  late AuthService auth;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    auth = AuthService(Supabase.instance.client);
  }

  void _login() async {
    setState(() => loading = true);
    final result = await auth.login(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
    );
    setState(() => loading = false);
    if (result['success']) {
      // Navegar al dashboard (el AuthGate lo detecta automáticamente)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login OK ✅'), backgroundColor: AppColors.success),
      );
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            // Logo / Título
            Text(
              'JEFIT APP',
              style: TextStyle(
                color: AppColors.success,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 8),
            Text('Tu gym, gamificado',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 40),
            // Email
            TextField(
              controller: _emailCtrl,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: AppColors.textSecondary),
                enabledBorder: UnderlineBorder(borderSide: BorderSide(color: AppColors.borderDark)),
                focusedBorder: UnderlineBorder(borderSide: BorderSide(color: AppColors.success)),
              ),
              style: TextStyle(color: AppColors.textPrimary),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // Password
            TextField(
              controller: _passCtrl,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: AppColors.textSecondary),
                enabledBorder: UnderlineBorder(borderSide: BorderSide(color: AppColors.borderDark)),
                focusedBorder: UnderlineBorder(borderSide: BorderSide(color: AppColors.success)),
              ),
              style: TextStyle(color: AppColors.textPrimary),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            // Login button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                      )
                    : Text('ENTRAR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            // Register link
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
              child: Text('¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: AppColors.textSecondary)),
            ),
          ],
        ),
      ),
    );
  }
}

// Import for register screen
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(backgroundColor: AppColors.primaryBg, foregroundColor: AppColors.textPrimary),
      body: const Center(child: Text('Register Screen - TODO', style: TextStyle(color: Colors.white))),
    );
  }
}
