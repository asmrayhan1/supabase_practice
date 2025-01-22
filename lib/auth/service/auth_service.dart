


import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signInWIthEmailPassword (String email, String password) async {
    return await _supabase.auth.signInWithPassword(
        password: password,
        email: email
    );
  }

  Future<AuthResponse> signUpWIthEmailPassword (String email, String password) async {
    return await _supabase.auth.signUp(
      data: {
        'name' : 'user1',
        'phone' : '12342342',
        'pass' : 'abcdefg'
      },
      email: email,
      password: password
    );
  }

  Future<void> signOUt() async {
    await _supabase.auth.signOut();
  }

  String? getCurrentUserEmail(){
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  // String? getCurrentUserName(){
  //   final session = _supabase.auth.currentSession;
  //   final user = session?.user;
  //   return user?.phone;
  // }
}