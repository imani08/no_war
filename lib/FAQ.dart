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
              child: Text(
                '''FAQ - NO WAR
                
Qu’est-ce que NO WAR ?

NO WAR est une application mobile conçue pour promouvoir la paix et fournir des informations de partout dans le monde via un site web externe et des informations vitales en temps de guerre. Elle offre un roman interactif, des ressources éducatives, des directives de sécurité, et plus encore.

Qui a créé NO WAR ?

NO WAR a été développée par 'Innovation Squad', un groupe d’étudiants passionnés par la programmation, composé de:
Imani Kalumuna,
Filda Ngoma,
Moise Isanganino,
Gehnisi Kitenge.

Comment NO WAR aide-t-elle pendant les conflits ?

L’application fournit des directives à suivre pendant les conflits, une agression ou la guerre, une carte des zones sécurisées dans un rayon de 20 km, et des notifications régulières.

Comment puis-je soutenir les réfugiés de guerre ?

Vous pouvez faire des dons via l’onglet dédié dans l’application pour soutenir les réfugiés de guerre. Votre contribution peut faire une grande différence.

L’application est-elle gratuite ?

Oui, NO WAR est entièrement gratuite et vise à être accessible à tous ceux qui en ont besoin.

Comment puis-je obtenir des fonds d’écran sensibles ?

Les fonds d’écran sont disponibles dans l’application et peuvent être appliqués pour sensibiliser aux effets de la guerre.

NO WAR est-elle disponible dans ma langue ?

NO WAR est actuellement disponible en plusieurs langues. Veuillez vérifier les paramètres de l’application pour voir si votre langue est prise en charge.

Comment puis-je contacter l’équipe de NO WAR ?

Pour toute question ou suggestion, veuillez nous contacter via Facebook sur FOCUS HD.''',
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
      ),
    );
  }
}