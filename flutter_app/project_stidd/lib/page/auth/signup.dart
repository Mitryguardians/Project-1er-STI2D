import 'package:flutter/material.dart';
import 'package:project_stidd/component/authP/Textfield.dart';
import 'package:project_stidd/services/auth.dart';

class Signup extends StatelessWidget {
  Signup({super.key, required this.onTapLogin});

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _passwordcontrollerVerify = TextEditingController();
  final _UsernameController = TextEditingController();

  final void Function()? onTapLogin;
  @override
  void signup(BuildContext context) {
    final _auth = Authsys();

    if (_passwordcontroller.text == _passwordcontrollerVerify.text) {
      try {
        _auth.signUpWithEmailAndPassword(
          _emailcontroller.text,
          _passwordcontroller.text,
          _UsernameController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Les Deux passwords ne sont pas les mêmes !'),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Crée toi un compte !",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFieldLogin(
              hinttext: 'Nom d\'utilisateur',
              private: false,
              controller: _UsernameController,
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldLogin(
              hinttext: 'Adresse Mail',
              private: false,
              controller: _emailcontroller,
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldLogin(
              hinttext: 'Mots de Passe',
              private: true,
              controller: _passwordcontroller,
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldLogin(
              hinttext: 'Verifier Mots de passe',
              private: true,
              controller: _passwordcontrollerVerify,
            ),
            MaterialButton(
              onPressed: () async {
                signup(context);
              },
              child: Text(
                "S'enregistrer",
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vous avez un compte ?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: onTapLogin,
                  child: Text(
                    "Connecte toi !",
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
