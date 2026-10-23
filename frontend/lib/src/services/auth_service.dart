import 'package:flutter/material.dart';
import 'package:jefit_app/src/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient client;

  AuthService(this.client);

  // Register (robado del flujo de Smart Fit)
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String role, // 'USER' or 'ENTRENADOR'
  }) async {
    try {
      final res = await client.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'role': role,
        },
      );
      if (res.user != null) {
        // Insert profile
        final profileRes = await client.from('profiles').insert({
          'id': res.user!.id,
          'name': name,
          'role': role,
          'cupos_total': role == 'ENTRENADOR' ? 10 : 0,
        }).select();
        return {'success': true, 'data': profileRes.first};
      }
      return {'success': false, 'error': 'No se pudo crear la cuenta'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // Login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user != null) {
        final profile = await client
            .from('profiles')
            .select()
            .eq('id', res.user!.id)
            .single();
        return {'success': true, 'data': profile};
      }
      return {'success': false, 'error': 'Credenciales inválidas'};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // Logout
  Future<void> logout() async {
    await client.auth.signOut();
  }

  // Get current session
  Stream<AuthState> get authState => client.auth.onAuthStateChange;
}
