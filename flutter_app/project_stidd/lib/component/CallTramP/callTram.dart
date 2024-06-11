import 'package:flutter/material.dart';
import 'dart:core';

import 'package:project_stidd/component/CallTramP/callTramFunction.dart';

class callTRAM_Template extends StatefulWidget {
  const callTRAM_Template({Key? key}) : super(key: key);

  @override
  _callTRAM_Template createState() => _callTRAM_Template();
}

class _callTRAM_Template extends State<callTRAM_Template> {
  String? _selectGARE = 'Selectionner une station';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      margin: EdgeInsets.all(50),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Ou je suis !',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: _selectGARE,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectGARE = newValue;
                      });
                    },
                    items: <String>[
                      'Selectionner une station',
                      'Gare 1',
                      'Gare 2',
                      'Gare 3',
                      'Gare 4'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_selectGARE != "Selectionner une station") {
                  callTramFuntion(context, _selectGARE);
                  setState(() {
                    _selectGARE = "Selectionner une station";
                  });
                } else {
                  print("Vous ne pouvez pas appeler le tramway");
                }
              },
              child: const Text('Appeler le Tramway !'),
            ),
          ),
        ],
      ),
    );
  }
}
