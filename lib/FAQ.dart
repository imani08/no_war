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

    1. Qu'est-ce que NO WAR et quelle est sa mission?

    NO WAR est une application développée par l'Innovation Squad, visant à fournir des solutions humanitaires dans le monde. Notre mission est de promouvoir l'éducation, l'information vitale pendant les conflits, et d'inspirer des actions pour la paix.

    2. Comment puis-je télécharger l'application NO WAR?

    Vous pouvez télécharger l'application NO WAR depuis votre magasin d'applications (App Store, Google Play, etc.). Recherchez "NO WAR" et suivez les instructions pour l'installation.

    3. Qui sont les membres de l'Innovation Squad?

    L'Innovation Squad est composée de quatre membres passionnés par la programmation: Imani Kalumuna, Filda Ngoma, Moise Isanganino, et Gehnisi Kitenge.

    4. En quoi consiste le "Roman Interactif" dans l'application?

    Le "Roman Interactif" offre une expérience immersive en explorant l'histoire des enfants soldats. Plongez dans des récits captivants pour mieux comprendre les défis qu'ils rencontrent.

    5. Comment accéder aux ressources éducatives dans l'application?

    Dans la section "Éducation pour Tous", vous pouvez accéder à des ressources éducatives gratuites pour favoriser l'apprentissage et le développement.

    6. Comment fonctionne la nouvelle fonction d'Alerte Sécurité?

    La fonction d'Alerte Sécurité vous permet d'envoyer rapidement des messages aux services de sécurité et d'initier des appels en cas d'urgence. Configurez vos préférences dans les paramètres de l'application.

    7. Comment localiser les zones sécurisées avec la "Carte des Zones Sécurisées"?

    Utilisez la fonction "Carte des Zones Sécurisées" pour localiser des refuges dans un rayon de 20 km pendant les périodes de conflit.

    8. Puis-je contribuer aux dons pour les réfugiés et comment?

    Oui, vous pouvez contribuer aux dons pour les réfugiés en accédant à l'onglet dédié dans l'application et en suivant les instructions pour effectuer un don.

    9. Comment personnaliser mon appareil avec les "Fonds d'Écran Sensibles"?

    Dans la section "Fonds d'Écran Sensibles", choisissez parmi une sélection illustrant les conséquences de la guerre et personnalisez votre appareil.

    10. Quand vais-je recevoir les notifications régulières?

    Vous recevrez des notifications toutes les deux heures, vous tenant informé des actualités, mises à jour de contenu et opportunités d'engagement.

    11. Comment puis-je partager mon expérience avec NO WAR?

    Partagez votre expérience en utilisant le hashtag #NowarApp sur les médias sociaux et encouragez vos amis à télécharger l'application.

    12. NO WAR est-il disponible dans d'autres langues que le français?

    Actuellement, l'application est disponible en français, mais nous envisageons d'ajouter d'autres langues pour atteindre un public plus large à l'avenir.

    N'hésitez pas à nous contacter via l'application pour toute question supplémentaire. Merci de votre soutien et de votre engagement envers un monde sans guerre.





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