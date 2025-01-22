import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_project/auth/login/login_screen.dart';

import '../../screen/profile/profile_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // check if there is a valid session currently
          final session = snapshot.hasData? snapshot.data!.session : null;
          if (session != null){
            return ProfileScreen();
          } else {
            return LoginScreen();
          }
        }
    );
  }
}
