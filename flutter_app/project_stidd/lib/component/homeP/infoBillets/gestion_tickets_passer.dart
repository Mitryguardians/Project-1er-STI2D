import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

Future<Map<String, dynamic>?> deleteANDmoveTickets(
  BuildContext context,
  dynamic HeureDepart,
  dynamic StationDepart,
  dynamic StationArriver,
  dynamic DateDepart,
  dynamic TempsTrajet,
  dynamic numeroTickets,
  dynamic dateachat,
  dynamic prix,
  dynamic tempsValiditer,
) async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(user!.uid);

    DocumentSnapshot<Map<String, dynamic>> userDocSnapshot =
        await userDocRef.get() as DocumentSnapshot<Map<String, dynamic>>;

    List<Map<String, dynamic>> tickets =
        List.from(userDocSnapshot.data()?['tickets'] ?? []);

    Map<String, dynamic>? ticketToDelete = tickets.firstWhere(
      (ticket) =>
          ticket['DateDepart'] == DateDepart &&
          ticket['HeureDepart'] == HeureDepart,
      orElse: () => Map<String, dynamic>(),
    );

    if (ticketToDelete != null) {
      tickets.remove(ticketToDelete);

      await userDocRef.update({'tickets': tickets});

      print("Ticket supprimé avec succès !");
      if (user != null) {
        DocumentReference userDoc =
            FirebaseFirestore.instance.collection("Users").doc(user.uid);

        userDoc.update({
          'Tickets_Invalide': FieldValue.arrayUnion([
            {
              'HeureDepart': HeureDepart,
              'StationDepart': StationDepart,
              'StationArriver': StationArriver,
              'DateDepart': DateDepart,
              'temps de trajets': TempsTrajet,
              'prix': "1,50€",
              'DateAchat': dateachat,
            }
          ]),
        });
      }
      return ticketToDelete;
    } else {
      print("Ticket non trouvé !");
      return null;
    }
  } catch (error) {
    print("Erreur lors de la suppression du ticket: $error");
    return null;
  }
}
