import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jefit_app/src/theme/app_colors.dart';
import 'package:jefit_app/src/screens/login_screen.dart';
import 'package:jefit_app/src/screens/dashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  runApp(const JefitApp());
}

final supabase = Supabase.instance.client;

class JefitApp extends StatelessWidget {
  const JefitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JEFIT APP',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.success,
        scaffoldBackgroundColor: AppColors.primaryBg,
        textTheme: GoogleFonts.interTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        useMaterial3: true,
      ),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Auto-redirect según estado de auth (robado de apps modernas)
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;
        if (session != null) {
          return const DashboardScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
