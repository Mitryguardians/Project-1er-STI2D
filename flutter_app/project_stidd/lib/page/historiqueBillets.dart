import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project_stidd/asset/other/mount.dart';
import 'package:project_stidd/component/homeP/infoBillets/plusInfo.dart';
import 'package:project_stidd/page/home.dart';

class HistoriqueTicket extends StatefulWidget {
  const HistoriqueTicket({Key? key}) : super(key: key);

  @override
  _HistoriqueTicketState createState() => _HistoriqueTicketState();
}

class _HistoriqueTicketState extends State<HistoriqueTicket> {
  late User? user;
  List<Map<String, dynamic>> allTickets = [];
  final DateTime _maintenant = DateTime.now();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    initializeDateFormatting('fr_FR', null);
    getData();
  }

  Future<void> getData() async {
    List<Map<String, dynamic>> userTickets = await fetchUserTickets();
    setState(() {
      allTickets = userTickets;
    });
  }

  Future<List<Map<String, dynamic>>> fetchUserTickets() async {
    List<Map<String, dynamic>> userTickets = [];

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('Users').doc(user.uid);

        DocumentSnapshot<Map<String, dynamic>> userDocSnapshot =
            await userDocRef.get() as DocumentSnapshot<Map<String, dynamic>>;

        if (userDocSnapshot.exists) {
          Map<String, dynamic>? userData = userDocSnapshot.data();
          if (userData != null) {
            List<dynamic>? tickets = userData['Tickets_Invalide'];

            if (tickets != null) {
              for (var ticket in tickets) {
                if (ticket is Map<String, dynamic>) {
                  userTickets.add(ticket);
                }
              }
            }
          }
        }
      }
    } catch (error) {
      print(
          "Erreur lors de la récupération de l'historique de l'utilisateur : $error");
    }

    return userTickets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Historique",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 20,
            width: 1000,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                (allTickets.length == 1)
                    ? "Vous avez ${allTickets.length} ticket"
                    : "Vous avez ${allTickets.length} tickets",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (allTickets.isEmpty)
            Container(
              height: 299,
              child: const Center(
                child: Text(
                  'Vous n\'avez pas de ticket !!',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          else ...[
            Expanded(
              child: ListView.builder(
                itemCount: allTickets.length,
                itemBuilder: (context, index) {
                  allTickets.sort(
                      (a, b) => b['DateDepart'].compareTo(a['DateDepart']));
                  Map<String, dynamic> ticket = allTickets[index];
                  String formattedDate =
                      DateFormat.yMMMMd('fr_FR').format(_maintenant);
                  DateTime departDate = ticket['DateDepart'].toDate();
                  DateTime lapsDeTempsAvantSupression =
                      _maintenant.subtract(Duration(days: 10));
                  return buildTicketContainer(
                    index,
                    formattedDate,
                    const Color.fromARGB(255, 116, 115, 115),
                    context,
                    ticket,
                    departDate,
                    ticket['HeureDepart'],
                    onPressed: () {
                      PlusInfoTicket(
                        context,
                        ticket['HeureDepart'],
                        ticket['StationDepart'],
                        ticket['StationArriver'],
                        ticket['DateDepart'],
                        ticket['temps de trajets'],
                        index + 1,
                        ticket['DateAchat'],
                        ticket['prix'],
                        ticket['valable'],
                        ticket['fin de validiter'],
                      );
                    },
                  );
                },
              ),
            )
          ]
        ],
      ),
    );
  }
}

Widget buildTicketContainer(
  int index,
  String formattedDate,
  Color color,
  BuildContext context,
  Map<String, dynamic> ticket,
  DateTime departDate,
  String heureDEdepart, {
  Function()? onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(5),
    child: ListTile(
      title: Text(
        "Ticket ${index + 1}, Était valable le ${departDate.day} ${moisEnLettre(departDate.month)} ${departDate.year} à $heureDEdepart",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      subtitle: const Text(
        "Pour plus d'informations sur le ticket appuyer sur l'icon",
        style: TextStyle(
          fontSize: 12,
          color: Colors.white54,
        ),
      ),
      leading: Image.asset(
        './lib/asset/images/ticket.png',
        height: 20,
        width: 20,
        color: Colors.white,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.info,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    ),
  );
}
