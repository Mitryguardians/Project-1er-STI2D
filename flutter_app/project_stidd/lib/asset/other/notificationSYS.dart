import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Initialiser les paramètres de configuration pour Android
var initializationSettingsAndroid = AndroidInitializationSettings('');

// Initialiser les paramètres de configuration
var initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
);
var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void initializeNotifications() {
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Fonction pour afficher une notification
void showNotification(
  String title,
  String body,
  int channelID, // ID du canal de notification
  String channelName, // Nom du canal de notification
  String channelDesc, // Description du canal de notification
) async {
  // Créer un Android notification channel
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channelID.toString(), // Convertir en chaîne
    channelName,
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher', // Spécifiez l'icône ici
  );

  // Créer un NotificationDetails pour Android
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  // Afficher la notification
  await flutterLocalNotificationsPlugin.show(
    channelID,
    title,
    body,
    platformChannelSpecifics,
  );
}
