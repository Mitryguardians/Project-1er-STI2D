import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_stidd/page/auth/loginORsignup.dart';
import 'package:project_stidd/page/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginOrSignup();
          }
        },
      ),
    );
  }
}
