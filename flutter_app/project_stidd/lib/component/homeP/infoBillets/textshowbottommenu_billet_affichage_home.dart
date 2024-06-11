import 'package:flutter/material.dart';

class MyRowInfo extends StatelessWidget {
  final String text2;
  final String text1;

  const MyRowInfo({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1),
            ),
          ),
          child: Text(
            text1,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text2,
        ),
      ],
    );
  }
}

class MyRowInfoTitleMidlePage extends StatelessWidget {
  final String text1;

  const MyRowInfoTitleMidlePage({Key? key, required this.text1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Text(
          text1,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class TitreShowmenu extends StatelessWidget {
  final String text;
  const TitreShowmenu({Key? key, required this.text}) : super(key: key);

  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 80,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 80,
        ),
      ],
    );
  }
}
