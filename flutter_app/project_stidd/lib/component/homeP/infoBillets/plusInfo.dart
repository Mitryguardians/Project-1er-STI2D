import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:project_stidd/asset/other/mount.dart';
import 'package:project_stidd/component/homeP/infoBillets/textshowbottommenu_billet_affichage_home.dart';

void PlusInfoTicket(
  BuildContext context,
  dynamic HeureDepart,
  dynamic StationDepart,
  dynamic StationArriver,
  dynamic DateDepart,
  dynamic TempsTrajet,
  dynamic numeroTickets,
  dynamic dateachat,
  dynamic prix,
  dynamic valable,
  dynamic tempsValiditer,
) {
  DateTime _maintenant = DateTime.now();
  DateTime dateAchatDateTime = dateachat.toDate();
  //info achat
  String dateAchatFormatedDayAndYear =
      DateFormat.yMMMMd('fr').format(dateAchatDateTime);

  String dateAchatFormatedDayHourMinute =
      '${dateAchatDateTime.hour}h${dateAchatDateTime.minute}';
  //info voyage
  DateTime dateDepartDate = DateDepart.toDate();
  String HeureDeparte = '';

  DateTime heureDepartDateTime = DateFormat.Hm().parse(HeureDepart);
  HeureDeparte =
      '${heureDepartDateTime.hour}h${heureDepartDateTime.minute.toString().padLeft(2, '0')}';

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: 475,
          width: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitreShowmenu(
                text: "Vos informations tickets",
              ),
              const SizedBox(
                height: 25,
              ),
              const MyRowInfoTitleMidlePage(
                text1: "Infomations client",
              ),
              const SizedBox(
                height: 20,
              ),
              MyRowInfo(
                text1: "Numéro du Ticket:",
                text2: numeroTickets.toString(),
              ),
              const SizedBox(
                height: 10,
              ),
              MyRowInfo(
                text1: "Acheté le:",
                text2:
                    "${dateAchatFormatedDayAndYear.toString()} à ${dateAchatFormatedDayHourMinute.toString()}",
              ),
              const SizedBox(
                height: 10,
              ),
              MyRowInfo(
                text1: "Prix:",
                text2: prix,
              ),
              const SizedBox(
                height: 20,
              ),
              const MyRowInfoTitleMidlePage(
                text1: "Informations Voyage",
              ),
              const SizedBox(
                height: 20,
              ),
              MyRowInfo(
                text1: "Date de départ:",
                text2:
                    "${dateDepartDate.day} ${moisEnLettre(dateDepartDate.month)} ${dateDepartDate.year.toString()} à ${HeureDeparte.toString()}",
              ),
              const SizedBox(
                height: 20,
              ),
              MyRowInfo(
                text1: "Station de départ:",
                text2: StationDepart,
              ),
              const SizedBox(
                height: 20,
              ),
              MyRowInfo(
                text1: "Station d'arriver:",
                text2: StationArriver,
              ),
              const SizedBox(
                height: 20,
              ),
              MyRowInfo(
                text1: "Temps de trajets:",
                text2: "${TempsTrajet.toString()} minute",
              ),
              const SizedBox(
                height: 20,
              ),
              if (valable == false || dateDepartDate.isBefore(_maintenant))
                const MyRowInfo(
                  text1: "Validité du ticket:",
                  text2: "Votre ticket n'est plus valable",
                )
              else if (dateDepartDate.isAfter(_maintenant))
                const MyRowInfo(
                  text1: "Validité du ticket:",
                  text2: "Votre ticket n'est pas encore valable",
                )
              else
                const MyRowInfo(
                  text1: "Validité du ticket:",
                  text2: "Votre ticket est encore valable",
                ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    },
  );
}
