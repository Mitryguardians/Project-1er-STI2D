import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project_stidd/component/homeP/infoBillets/gestion_tickets_passer.dart';
import 'package:project_stidd/component/homeP/infoBillets/plusInfo.dart';

class MesTickets extends StatefulWidget {
  final void Function(List<dynamic>)? onTicketsLoaded;

  const MesTickets({Key? key, this.onTicketsLoaded}) : super(key: key);

  @override
  _MesTicketsState createState() => _MesTicketsState();
}

class _MesTicketsState extends State<MesTickets> {
  late User? user;
  List<Map<String, dynamic>> allTickets = [];
  final DateTime _maintenant = DateTime.now();
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    initializeDateFormatting('fr', null);
    getData();
  }

  void getData() async {
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
            List<dynamic>? tickets = userData['tickets'];

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
          "Erreur lors de la récupération des tickets de l'utilisateur : $error");
    }

    return userTickets;
  }

  @override
  Widget build(BuildContext context) {
    if (allTickets.isEmpty) {
      return Container(
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
      );
    } else {
      allTickets.sort((a, b) => a['DateDepart'].compareTo(b['DateDepart']));

      return Expanded(
        child: ListView.builder(
          itemCount: allTickets.length,
          itemBuilder: (BuildContext context, int index) {
            final ticket = allTickets[index];
            String formattedDate =
                DateFormat.yMMMMd('fr').format(ticket['DateDepart'].toDate());
            DateTime departDate = ticket['DateDepart'].toDate();
            String heure_de_depart = ticket['HeureDepart'];

            DateTime lapsDeTempsAvantSupression =
                _maintenant.subtract(Duration(days: 2));
            if (departDate.isBefore(lapsDeTempsAvantSupression)) {
              deleteANDmoveTickets(
                context,
                ticket['HeureDepart'],
                ticket['StationDepart'],
                ticket['StationArriver'],
                ticket['DateDepart'],
                ticket['temps de trajets'],
                index + 1,
                ticket['DateAchat'],
                ticket['prix'],
                ticket['fin de validiter'],
              );
              return buildTicketContainer(
                index,
                formattedDate,
                const Color.fromARGB(255, 116, 115, 115),
                context,
                ticket,
                departDate,
                heure_de_depart,
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
            } else {
              if (departDate.year == _maintenant.year &&
                  departDate.month == _maintenant.month &&
                  departDate.day == _maintenant.day) {
                return buildTicketContainer(
                  index,
                  formattedDate,
                  Colors.green,
                  context,
                  ticket,
                  departDate,
                  heure_de_depart,
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
              } else if (departDate.isBefore(_maintenant)) {
                return buildTicketContainer(
                  index,
                  formattedDate,
                  Colors.red,
                  context,
                  ticket,
                  departDate,
                  heure_de_depart,
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
              } else {
                return buildTicketContainer(
                  index,
                  formattedDate,
                  const Color.fromARGB(255, 116, 115, 115),
                  context,
                  ticket,
                  departDate,
                  heure_de_depart,
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
              }
            }
          },
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
    DateTime tomorrow = _maintenant.add(const Duration(days: 1));

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(5),
      child: ListTile(
        title: Text(
          (departDate.year == _maintenant.year &&
                  departDate.month == _maintenant.month &&
                  departDate.day == _maintenant.day)
              ? (departDate.isBefore(_maintenant) &&
                      departDate.hour < _maintenant.hour)
                  ? "Ticket ${index + 1}, Était valable aujourd'hui à $heureDEdepart"
                  : "Ticket ${index + 1}, Valable aujourd'hui à $heureDEdepart"
              : (departDate.isBefore(_maintenant))
                  ? "Ticket ${index + 1}, Était valable le : $formattedDate"
                  : (departDate.year == tomorrow.year &&
                          departDate.month == tomorrow.month &&
                          departDate.day == tomorrow.day)
                      ? "Ticket ${index + 1}, Valable demain à $heureDEdepart"
                      : "Ticket ${index + 1}, Valable le : $formattedDate",
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
}
