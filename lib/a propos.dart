import 'package:flutter/material.dart';

class APropos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'À propos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('À propos'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '''

 À propos de NO WAR

NO WAR est une application proposant des solutions humanitaires dans le monde conçue par Imani Kalumuna, Filda Ngoma, Moise Isanganino et Gehnisi Kitenge, connus collectivement sous le nom de Innovation Squad. Ce groupe d’étudiants passionnés par la programmation a créé une plateforme qui vise à éduquer, informer et inspirer l’action pour la paix.

NOTRE MISSION

Notre mission est de fournir une éducation accessible à tous et de faciliter l’accès à l’information vitale pendant les conflits ou la guerre. Nous croyons en un monde où chaque enfant peut grandir sans la peur de devenir un enfant soldat et où chaque personne a le droit à la sécurité et à l’éducation.

Caractéristiques de l’Application:

- Roman Interactif : Découvrez l’histoire poignante des enfants soldats à travers un roman captivant intégré dans l’application.

- Éducation pour Tous : Accédez à des ressources éducatives gratuites pour favoriser l’apprentissage et l’épanouissement.

- Directives de Sécurité : Suivez des directives claires pour rester en sécurité pendant les périodes de conflit.

- Carte des Zones Sécurisées : Localisez les zones sécurisées dans un rayon de 20 km, vous permettant de trouver refuge lorsqu’il est le plus nécessaire.

- Fonds d’Écran Sensibles : Personnalisez votre appareil avec des fonds d’écran qui illustrent les ravages de la guerre et l’importance de la paix.

- Vue Globale sur la RDC : Explorez une vue d’ensemble de la République Démocratique du Congo pour promouvoir la beauté et la culture de notre pays.

- Dons pour les Réfugiés : Contribuez à la cause en faisant des dons pour soutenir les réfugiés de guerre à travers un onglet dédié.

- Notifications Régulières : Recevez des notifications toutes les deux heures pour rester informé et engagé.

Rejoignez-nous dans notre quête pour un monde sans guerre.

 Téléchargez NO WAR et faites partie du changement.''',
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
