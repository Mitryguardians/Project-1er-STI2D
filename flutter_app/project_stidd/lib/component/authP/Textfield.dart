import 'package:flutter/material.dart';

class TextFieldLogin extends StatelessWidget {
  final String hinttext;
  final bool private;
  final TextEditingController controller;

  const TextFieldLogin({
    Key? key,
    required this.hinttext,
    required this.private,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Material(
        child: TextField(
          obscureText: private,
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            fillColor: Color.fromARGB(255, 168, 165, 165),
            filled: true,
            hintText: hinttext,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }
}
