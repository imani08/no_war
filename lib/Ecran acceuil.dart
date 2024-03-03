import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'alert.dart';
import 'lire.dart';
import 'connexion.dart';
import 'dart:ui';
import 'FAQ.dart';
import 'a propos.dart';
import 'langues.dart';
import 'directives.dart';
import 'education.dart';
import 'news.dart';
import 'zone  verte.dart';
import 'congo.dart';
import 'fond d ecran.dart';
import 'don.dart';
import 'visit.dart';



class EcranAccueil extends StatefulWidget {
  const EcranAccueil({Key? key}) : super(key: key);

  @override
  _EcranAccueilState createState() => _EcranAccueilState();
}

class _EcranAccueilState extends State<EcranAccueil> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double rectangleWidth = 450.0; // Largeur du rectangle
  double rectangleHeight = 140.0; // Hauteur du rectangle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF009FE3),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 90,
            ),
            SizedBox(width: 8),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 30.0),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          )
        ],
      ),

      endDrawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF009FE3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/affiche.png'),
              ),
            ),
            ListTile(
              title: const Text(
                'FAQ',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQ()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'A propos',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => APropos()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'LANGUES',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },

            ),
            ListTile(
              title: const Text(
                'Faire un don',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoneyTransaction()),
                );
              },

            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/arriere.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
        

        Expanded(

        child: Align(
        alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Rectangle arrondi avec image, texte et bouton
                Container(
                  margin: EdgeInsets.only(left:15, right:15),
                  width: rectangleWidth,
                  height: rectangleHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      // Image à droite
                      Expanded(
                        flex: 1,
                        child: Transform.scale(
                          scale: 0.7, // Facteur d'échelle pour réduire la taille (0.5 est un exemple)
                          child: Image.asset(
                            'assets/images/roman.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      // Texte à gauche
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'NO WAR',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors. blue,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            AutoSizeText(
                              
                              '''Lisez l\'histoire d\'un groupe d\'enfants 
capturés par des rebelles luttant
pour leur survie et leur liberté
"La justice façonne la paix : notre engagement."'''
                              
                              ,
                              style: TextStyle(fontSize: 14.0, color: Colors. black,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                // Colonnes pour le bouton à l'intérieur du rectangle
                
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 15.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    "lire 'NO WAR'",
                    style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Transform.translate(
                    offset: Offset(0.0, -25.0), // Déplace de 10.0 pixels vers le haut
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildRectangleWithContent(
                          140.0,
                          120.0,
                          Image.asset(
                            'assets/images/education.png', // Remplace avec le chemin vers ton image pour l'éducation
                            width: 40.0, // Taille souhaitée pour l'image
                            height: 40.0,
                            color: Colors.white, // Optionnel : pour ajuster la couleur si nécessaire
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Education()),
                              );
                            },
                            child: const Text(
                              'EDUCATION',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        _buildRectangleWithContent(
                          140.0,
                          120.0,
                          Image.asset(
                            'assets/images/informations.png', // Remplace avec le chemin vers ton image pour l'éducation
                            width: 40.0, // Taille souhaitée pour l'image
                            height: 40.0,
                            color: Colors.white, // Optionnel : pour ajuster la couleur si nécessaire
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Informations()),
                              );
                            },
                            child: Text(
                              'INFORMATIONS',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Transform.translate(
                    offset: Offset(0.0, -25.0), // Déplace de 10.0 pixels vers le haut
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildRectangleWithContent(
                          140.0,
                          120.0,
                          Image.asset(
                            'assets/images/directives.png', //
                            width: 40.0, // Taille souhaitée pour l'image
                            height: 40.0,
                            color: Colors.white, // Optionnel : pour ajuster la couleur si nécessaire
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Directives()),
                              );
                            },
                            child: const Text(
                              'DIRECTIVES',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'Agency FB',
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        _buildRectangleWithContent(
                          140.0,
                          120.0,
                          Image.asset(
                            'assets/images/zone verte.png', // Remplace avec le chemin vers ton image pour l'éducation
                            width: 40.0, // Taille souhaitée pour l'image
                            height: 40.0,
                            color: Colors.white, // Optionnel : pour ajuster la couleur si nécessaire
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SecureAreasMap()),
                              );
                            },
                            child: const Text(
                              'ZONE VERTE',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers une nouvelle page lorsque le bouton est appuyé
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Image.asset(
          'assets/images/avatar.jpg', // Remplacez par le chemin de votre image locale
          width: 36.0, // Ajustez la largeur selon vos besoins
          height: 36.0, // Ajustez la hauteur selon vos besoins
        ),
        backgroundColor: Colors.lightBlue,
      ),


      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Acceuil',

          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('assets/images/congo.png'), // Remplacez par votre URL
              width: 30, // Largeur souhaitée de l'image
              height: 30, // Hauteur souhaitée de l'image
              fit: BoxFit.contain,
            ),// Ajustement de la taille de l'image)
            label: 'Visit DRC',

          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('assets/images/icone cloche.png'), // Remplacez par votre URL
              width: 30, // Largeur souhaitée de l'image
              height: 30, // Hauteur souhaitée de l'image
              fit: BoxFit.contain,
            ),
            label: 'Alert',
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'fonds d\'écrans',
          ),

        ],
        
        selectedIconTheme: IconThemeData(color: Colors.blue), // Icônes sélectionnées en bleu
        unselectedIconTheme: IconThemeData(color: Colors.blue),
        selectedLabelStyle: TextStyle(color: Colors.blue), // Style du label sélectionné
        unselectedLabelStyle: TextStyle(color: Colors.blue),// Icônes non sélectionnées en blanc
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>EcranAccueil()),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Visit()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Alert()),
            );
          }
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NosFonds()),
            );
          }

          },
      ),
    );
  }

  Widget _buildRectangleWithContent(
      double width, double height, Widget icon, Widget button) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 10.0),
          button,
        ],
      ),
    );
  }
}
