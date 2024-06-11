import 'package:flutter/material.dart';
import 'package:project_stidd/component/authP/Textfield.dart';
import 'package:project_stidd/page/trollpage.dart';
import 'package:project_stidd/services/auth.dart';

class Login extends StatelessWidget {
  Login({super.key, required this.onTapregister});

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final void Function()? onTapregister;

  void Loginf(BuildContext context) async {
    final authsys = Authsys();
    try {
      await authsys.signInWithEmailAndPassword(
          _emailcontroller.text, _passwordcontroller.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Projet tramway 1STI2D1",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bienvenue !!",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFieldLogin(
              hinttext: 'Email',
              private: false,
              controller: _emailcontroller,
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldLogin(
              hinttext: 'Password',
              private: true,
              controller: _passwordcontroller,
            ),
            const SizedBox(
              height: 5,
            ),
            MaterialButton(
              onPressed: () async {
                if (_emailcontroller.text == "1234" &&
                    _passwordcontroller.text == "1234") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => trollface()),
                  );
                } else {
                  Loginf(context);
                }
              },
              child: Text(
                "Connection",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              height: 35,
              minWidth: 150,
              color: Colors.green.shade600,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pas de compte?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: onTapregister,
                  child: Text(
                    "Inscris toi !",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
