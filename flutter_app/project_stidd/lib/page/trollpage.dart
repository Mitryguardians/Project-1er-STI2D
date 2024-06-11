import 'package:flutter/material.dart';

class trollface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 1000,
          width: 1000,
          color: Colors.green,
          child: Center(
            child: Text(
              "Bien jouée tu a trouver l'Easter eagg",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
