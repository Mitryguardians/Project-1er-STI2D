import 'package:flutter/material.dart';
import 'package:project_stidd/component/CallTramP/callTram.dart';
import 'package:project_stidd/page/home.dart';

class call_TRAM extends StatefulWidget {
  const call_TRAM({Key? key}) : super(key: key);

  @override
  _call_TRAM createState() => _call_TRAM();
}

class _call_TRAM extends State<call_TRAM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Appeler le Tramway",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: Container(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            callTRAM_Template(),
          ],
        ),
      ),
    );
  }
}
