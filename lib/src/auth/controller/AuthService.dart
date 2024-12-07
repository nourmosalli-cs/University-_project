import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<AuthResponse?> signIn(String email, String password) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response.session == null ? response : null;
    } on AuthException catch (e) {
      rethrow;
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  final SupabaseClient _supabaseClientt = Supabase.instance.client;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    final response =
        await _supabaseClientt.auth.signUp(email: email, password: password);

    if (response.user == null) {
      return response.user;
    } else {
      return null;
    }
  }
}
