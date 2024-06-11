import 'package:flutter/material.dart';

class Tram_affichage extends StatefulWidget {
  final String gareDepart;
  final String gareArrvier;

  const Tram_affichage({
    Key? key,
    required this.gareDepart,
    required this.gareArrvier,
  }) : super(key: key);

  @override
  _Tram_affichageState createState() => _Tram_affichageState();
}

class _Tram_affichageState extends State<Tram_affichage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 71, 71, 71),
        borderRadius: BorderRadius.circular(50),
      ),
      height: 200,
      width: 400,
      child: Column(
        children: [
          Image.asset(
            './lib/asset/images/tram.jpeg',
            height: 150,
            width: 300,
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              const SizedBox(
                width: 4,
              ),
              Text(
                widget.gareDepart,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Container(
                width: 250,
                height: 2,
                color: Colors.white,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                widget.gareArrvier,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
