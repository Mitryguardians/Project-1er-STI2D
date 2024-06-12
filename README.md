# Projet de 1er STI2D.


#générer l'app

Si vous générez l'application, vous trouverez l'APK dans ce chemin :

project_stidd\build\app\outputs\flutter-apk

Si le dossier build n'est pas là, c'est normal. Il faut générer l'application pour qu'il apparaisse.

Commandes en question :

flutter build apk --debug
flutter build apk --release

Si cela ne fonctionne pas, utilisez votre téléphone comme émulateur et exécutez "flutter run" tout en sélectionnant votre téléphone.



Attention:
Les fichiers config de google Firebase on été suprimer donc vous devrez configurer un projet google firebase pour pouvoir utiliser le sys de bdd, Normalement vous n'aurez pas besoin de crée les Tables de la BDD, il vont se crée tout seul a l'inscription d'un utilisateur !!
