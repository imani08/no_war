import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAQ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('FAQ'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Text('''
    
Foire Aux Questions (FAQ) - NO WAR

Qu'est-ce que NO WAR et quelle est sa mission?

NO WAR est une application développée par AmalTech, visant à fournir des solutions humanitaires dans le monde. Notre mission est de promouvoir l'éducation, l'information vitale pendant les conflits, et d'inspirer des actions pour la paix.

Comment puis-je télécharger l'application NO WAR?

Vous pouvez télécharger l'application NO WAR depuis votre magasin d'applications (App Store, Google Play, etc.). Recherchez "NO WAR" et suivez les instructions pour l'installation.

Qui sont les membres de l'équipe AmalTech?

L'équipe AmalTech est composée de quatre membres passionnés par la programmation: Imani Kalumuna, Filda Ngoma, Moise Isanganino, et Gehnisi Kitenge.

En quoi consiste le "Roman Interactif" dans l'application?

Le "Roman Interactif" offre une expérience immersive en explorant l'histoire des enfants soldats. Plongez dans des récits captivants pour mieux comprendre les défis qu'ils rencontrent.

Comment accéder aux ressources éducatives dans l'application?

Dans la section "Éducation pour Tous", vous pouvez accéder à des ressources éducatives gratuites pour favoriser l'apprentissage et le développement.

Comment fonctionne la nouvelle fonction d'Alerte Sécurité?

La fonction d'Alerte Sécurité vous permet d'envoyer rapidement des messages aux services de sécurité et d'initier des appels en cas d'urgence. Configurez vos préférences dans les paramètres de l'application.

Comment localiser les zones sécurisées avec la "Zones Verte"?

Utilisez la fonction "Zone Verte" pour localiser des refuges dans un rayon de 20 km pendant les périodes de conflit.

Puis-je contribuer aux dons pour les réfugiés et comment?

Oui, vous pouvez contribuer aux dons pour les réfugiés en accédant à l'onglet dédié dans l'application et en suivant les instructions pour effectuer un don.

Comment personnaliser mon appareil avec les "Fonds d'Écran Sensibles"?

Dans la section "Fonds d'Écran Sensibles", choisissez parmi une sélection illustrant les conséquences de la guerre et personnalisez votre appareil.

Comment créer un compte et accéder à mon profil sur NO WAR?

Connectez-vous ou créez un compte pour accéder à votre profil, où vous pourrez modifier votre photo de profil, votre photo de couverture, et envoyer des messages à l'équipe AmalTech pour contribuer à la cause. La page affichera votre adresse e-mail, votre ville, et votre pays.

Comment puis-je partager mon expérience avec NO WAR?

Partagez votre expérience en utilisant le hashtag #NowarApp sur les médias sociaux et encouragez vos amis à télécharger l'application.

NO WAR est-il disponible dans d'autres langues que le français?

Actuellement, l'application est disponible en français, mais nous envisageons d'ajouter d'autres langues pour atteindre un public plus large à l'avenir.

N'oubliez pas de donner à l'application l'accès à la localisation et au stockage dans les paramètres de votre téléphone pour une expérience optimale. N'hésitez pas à nous contacter via l'application pour toute question supplémentaire. Merci de votre soutien et de votre engagement envers un monde sans guerre.

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