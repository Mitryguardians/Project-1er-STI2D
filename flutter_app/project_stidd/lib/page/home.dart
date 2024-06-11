import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_stidd/component/drawMenu.dart';
import 'package:project_stidd/component/homeP/afficherBillets.dart';
import 'package:project_stidd/component/homeP/reservBilletsBTN.dart';
import 'package:project_stidd/component/homeP/tram_affichage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late DateTime _maintenant;

  late Timer _timer;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  late List<dynamic> tickets = [];

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    _maintenant = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _maintenant = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      drawerScrimColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Tram_affichage(
            gareArrvier: "Gare 1",
            gareDepart: "Gare 2",
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  height: 1,
                  width: 300,
                ),
                const SizedBox(height: 5),
                const Text(
                  "Vos billets",
                  style: TextStyle(
                    backgroundColor: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  height: 1,
                  width: 300,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const MesTickets(),
          const SizedBox(
            height: 2,
          ),
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(15),
            child: ElevatedBtnToGoNewTicketPage(),
          ),
        ],
      ),
    );
  }
}
