import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_stidd/asset/other/mount.dart';
import 'package:project_stidd/component/reserverBilletP/newTickets.dart';
import 'package:project_stidd/page/reservation.dart';
import 'dart:core';

class TemplateBillets extends StatefulWidget {
  const TemplateBillets({Key? key}) : super(key: key);

  @override
  _TemplateBilletsState createState() => _TemplateBilletsState();
}

class _TemplateBilletsState extends State<TemplateBillets> {
  String? _selectedItemsOne = 'Selectionner une station';
  String? _selectedItemsTwo = 'Selectionner une station';
  DateTime? _DateDepart = DateTime.now();
  late String? _HeureDepart = 'no select';

  void _ShowDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2099, 12, 31),
      initialDate: DateTime.now(),
    ).then((value) {
      setState(() {
        _DateDepart = value!;
      });
    });
  }

  void _showTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500.0,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Choisir l\'heure',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 24 - 6,
                  itemBuilder: (BuildContext context, int index) {
                    final hour = index + 6;

                    if (hour >= 23) {
                      return Container();
                    }

                    List<int> minutes = [0, 10, 20, 30, 40, 50];
                    return Column(
                      children: minutes.map((min) {
                        return ListTile(
                          title: min == 0
                              ? Text('${hour}h${min}0')
                              : Text('${hour}h$min'),
                          onTap: () {
                            final selectedTime =
                                TimeOfDay(hour: hour, minute: min);
                            setState(() {
                              _HeureDepart = selectedTime.format(context);
                            });
                            Navigator.of(context).pop();
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      margin: EdgeInsets.all(50),
      child: Column(
        children: [
          const Text(
            'Date de départ',
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_DateDepart == null)
                    const Text('Date de départ non sélectionnée'),
                  if (_DateDepart != null)
                    Text(
                      'Date de départ : ${_DateDepart!.day.toString()} ${moisEnLettre(_DateDepart!.month)} ${_DateDepart!.year.toString()}',
                    ),
                  IconButton(
                    onPressed: () {
                      _ShowDatePicker(context);
                    },
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              ),
            ),
          ),
          const Text(
            'Heure de départ',
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
              child: _HeureDepart == 'no select'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Heure de départ non sélectionné'),
                        IconButton(
                          onPressed: () {
                            _showTimePicker(context);
                          },
                          icon: const Icon(Icons.access_time),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vous partez à $_HeureDepart"),
                        IconButton(
                          onPressed: () {
                            _showTimePicker(context);
                          },
                          icon: Icon(Icons.access_time),
                        )
                      ],
                    ),
            ),
          ),
          const Text(
            'Station de départ',
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
                    value: _selectedItemsOne,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItemsOne = newValue;
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
          const Text(
            'Station d\'arriver',
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
                    value: _selectedItemsTwo,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItemsTwo = newValue;
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
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Prix : 1€50',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
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
                newTicket(
                  context,
                  _HeureDepart,
                  _selectedItemsOne,
                  _selectedItemsTwo,
                  _DateDepart,
                  "1h",
                );
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reservation(),
                  ),
                );
              },
              child: const Text('Réserver votre billet !'),
            ),
          ),
        ],
      ),
    );
  }
}
