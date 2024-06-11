import 'package:flutter/material.dart';
import 'package:project_stidd/page/appelerTRAM.dart';
import 'package:project_stidd/page/historiqueBillets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Projet Trottinette 1er STI2D1",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text("Historique"),
                leading: Icon(Icons.history),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoriqueTicket(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Appeler le Tramway"),
                leading: Icon(Icons.call),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => call_TRAM(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
