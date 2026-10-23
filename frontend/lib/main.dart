import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jefit_app/src/theme/app_colors.dart';

void main() {
  runApp(const JefitApp());
}

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
      ),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: Center(
        child: Text(
          'JEFIT APP',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
