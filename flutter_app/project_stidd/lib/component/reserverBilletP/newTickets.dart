import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_stidd/asset/other/mount.dart';
import 'package:project_stidd/asset/other/notificationSYS.dart';

final Map<String, Map<String, int>> dureeTrajetsGareGare = {
  'Gare 1': {'Gare 1': 0, 'Gare 2': 10, 'Gare 3': 20, 'Gare 4': 30},
  'Gare 2': {'Gare 1': 10, 'Gare 2': 0, 'Gare 3': 10, 'Gare 4': 20},
  'Gare 3': {'Gare 1': 20, 'Gare 2': 10, 'Gare 3': 0, 'Gare 4': 10},
  'Gare 4': {'Gare 1': 30, 'Gare 2': 20, 'Gare 3': 10, 'Gare 4': 0},
};

void newTicket(
  BuildContext context,
  dynamic HeureDepart,
  dynamic StationDepart,
  dynamic StationArriver,
  dynamic DateDepart,
  dynamic finDeValiditer,
) {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  if (HeureDepart != 'no select' &&
      StationDepart != 'Selectionner une station' &&
      StationArriver != 'Selectionner une station') {
    if (StationDepart == StationDepart) {
      // if (DateDepart.compareTo(DateTime.now()) < -1)
      if (DateDepart.day < DateTime.now().day) {
        showNotification(
          'Erreur',
          'Vous ne pouvez pas partir le ${DateDepart.day.toString()} ${moisEnLettre(DateDepart!.month)} alors que nous somme le ${DateTime.now().day} ${moisEnLettre(DateTime.now().month)}',
          0001,
          'error',
          'error',
        );
      } else {
        if (user != null) {
          int tempsdeTrajet =
              dureeTrajetsGareGare[StationDepart]![StationArriver]!;

          DocumentReference userDoc =
              FirebaseFirestore.instance.collection("Users").doc(user.uid);

          userDoc.update({
            'tickets': FieldValue.arrayUnion([
              {
                'HeureDepart': HeureDepart,
                'StationDepart': StationDepart,
                'StationArriver': StationArriver,
                'DateDepart': DateDepart,
                'temps de trajets': tempsdeTrajet,
                'prix': "1,50€",
                'DateAchat': DateTime.now(),
                'valable': true,
                'temps de validiter': finDeValiditer,
              }
            ])
          }).then((_) {
            showNotification(
              'New ticket',
              "Vous partez le ${DateDepart.day.toString()} ${moisEnLettre(DateDepart!.month)} à $HeureDepart depuis la station $StationDepart pour un trajets de $tempsdeTrajet minutes.",
              1001,
              'newTicket',
              'vous avez un nouveau ticket',
            );
          }).catchError((error) {
            showNotification(
              'Erreur',
              'Erreur lors de l\'ajout du ticket: $error',
              0001,
              'error',
              'error',
            );
          });
        } else {
          showNotification(
            'Erreur',
            'Utilisateur non authentifié',
            0001,
            'error',
            'error',
          );
        }
      }
    } else {
      showNotification(
        'Erreur',
        'Vous ne pouvez pas aller de la $StationDepart pour aller $StationArriver',
        0001,
        'error',
        'error',
      );
    }
  } else {
    showNotification(
      'Erreur',
      'Erreur lors de l\'ajout du ticket, veuillez remplir tous les champs !',
      0001,
      'error',
      'error',
    );
  }
}
