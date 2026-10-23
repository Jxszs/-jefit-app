import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds (dark aesthetic - Symmetry + Cbum style)
  static const primaryBg = Color(0xFF0A0A0B);     // negro profundo
  static const cardBg = Color(0xFF1A1A1D);        // gris oscuro con borde

  // Accents
  static const success = Color(0xFF10B981);       // verde Symmetry (progresos)
  static const trophy = Color(0xFFD4AF37);        // oro Cbum (ranking/trofeos)
  static const progress = Color(0xFF3B82F6);       // azul (ejercicios)

  // Texto
  static const textPrimary = Color(0xFFF8FAFC);
  static const textSecondary = Color(0xFF9CA3AF);

  // Heatmap check-ins
  static const heatmapNone = Color(0xFF0A0A0B);
  static const heatmapLow = Color(0xFF10B981);     // 1 día
  static const heatmapMid = Color(0xFF059669);    // streak
  static const heatmapHigh = Color(0xFF047857);    // 7+ días

  // UI Borders
  static const borderDark = Color(0xFF2D2D33);
}
