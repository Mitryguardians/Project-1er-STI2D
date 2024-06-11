import 'package:flutter/material.dart';
import 'package:project_stidd/page/auth/login.dart';
import 'package:project_stidd/page/auth/signup.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({Key? key});

  @override
  _LoginOrSignupState createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool showLoginPage = true;

  void changingPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(
        onTapregister: changingPage,
      );
    } else {
      return Signup(
        onTapLogin: changingPage,
      );
    }
  }
}
