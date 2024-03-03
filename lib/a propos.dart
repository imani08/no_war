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
                '''NO WAR

Notre Engagement:
NO WAR est bien plus qu'une application. C'est un engagement profond en faveur de la paix, de l'éducation et de la sécurité. Créée par l'équipe AmalTech - Imani Kalumuna, Filda Ngoma, Moise Isanganino, et Gehnisi Kitenge - cette application représente notre réponse à l'appel urgent d'un monde sans guerre, où chaque individu a le droit à la sécurité et à l'éducation.

Mission Humanitaire:
Notre mission est claire - fournir une éducation accessible à tous, faciliter l'accès à l'information cruciale pendant les conflits, et inspirer des actions concrètes pour la paix. NO WAR se veut être un catalyseur pour un changement positif, mettant l'accent sur la sensibilisation, l'éducation et le soutien aux victimes de guerre.

Caractéristiques Impactantes:

Roman Interactif:
Explorez l'histoire déchirante des enfants soldats à travers un roman captivant intégré dans l'application. Vivez des récits poignants pour mieux comprendre les réalités difficiles de ceux touchés par la guerre.

Éducation pour Tous:
Accédez à des ressources éducatives gratuites, promouvant l'apprentissage et l'épanouissement, même dans les contextes les plus difficiles.

Sécurité en Priorité:
Introduisant une nouvelle fonctionnalité d'Alerte Sécurité, NO WAR vous permet d'envoyer rapidement des messages et d'initier des appels aux services de sécurité en cas d'urgence.

Carte des Zones Sécurisées:
Localisez les zones sûres dans un rayon de 20 km, offrant un refuge essentiel lors des périodes de conflit.

Fonds d'Écran Sensibles:
Personnalisez votre appareil avec des fonds d'écran captivants, mettant en lumière les conséquences de la guerre et l'importance cruciale de la paix.

Profil Utilisateur:
Connectez-vous ou créez un compte pour accéder à votre profil, où vous pourrez modifier votre photo de profil, votre photo de couverture et envoyer des messages à l'équipe AmalTech pour contribuer à la cause. La page affichera votre adresse e-mail, votre ville et votre pays.

Vue Globale sur la RDC:
Explorez la beauté et la culture de la République Démocratique du Congo à travers une vue d'ensemble, encourageant l'appréciation de la diversité de notre pays.

Dons pour les Réfugiés:
Contribuez à notre cause humanitaire en faisant des dons dédiés au soutien des réfugiés de guerre.

Notifications Régulières:
Restez connecté avec notre cause grâce à des notifications régulières, vous tenant informé des dernières nouvelles et opportunités d'engagement.

Rejoignez la Quête pour un Monde sans Guerre:
NO WAR est plus qu'une application, c'est un appel à l'action. Téléchargez l'application maintenant et faites partie de la communauté engagée pour un monde pacifique. Votre implication peut faire une différence significative. Merci de soutenir notre mission pour un avenir meilleur.
''',
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
