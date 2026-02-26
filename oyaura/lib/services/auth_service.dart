import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // 1. Sign Up a new user directly to Supabase AND your public table
  Future<void> signup(String username, String email, String password) async {
    try {
      // Step A: Create the secure auth user
      final res = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );

      // Step B: Automatically copy their new ID into your public 'users' table!
      if (res.user != null) {
        await supabase.from('users').insert({
          'user_id': res.user!.id, // This fixes your exact error!
          'username': username,
          'email': email,
        });
      }
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  // 2. Log in an existing user directly to Supabase
  Future<void> login(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // 3. Log out
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  // 4. Check who is logged in
  String? getCurrentUserId() {
    return supabase.auth.currentUser?.id;
  }
}
