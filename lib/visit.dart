import 'package:flutter/material.dart';
import 'congo.dart';
import 'package:flutter/cupertino.dart';
import 'Ecran acceuil.dart';
import 'parcs.dart';
import 'histoire.dart';
import 'ressources.dart';
import 'villes.dart';
import 'volcans.dart';
import 'religions.dart';
import 'llocales.dart';
import 'alert.dart';

class Visit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> buttonTexts = [
    'Tout sur la RDC',
    'Parcs',
    'Histoire et géographie',
    'Ressources naturelles',
    'Villes',
    'Volcans',
    'Religions',
    'Langues',
  ];

  void onButtonPressed(BuildContext context, int buttonIndex) {
    // Navigation spécifique pour chaque bouton
    switch (buttonIndex) {
      case 0:
      // Navigation pour le bouton 0
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Congo()),
        );
        break;
      case 1:
      // Navigation pour le bouton 1
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Parcs()),
        );
        break;
      case 2:
      // Navigation pour le bouton 1
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => histoire()),
        );
        break;
      case 3:
      // Navigation pour le bouton 1
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ressources()),
        );
        break;
      case 4:
      // Navigation pour le bouton 1
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => villes()),
        );
        break;
      case 5:
      // Navigation pour le bouton 1
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => volcans()),
        );
        break;
      case 6:
      // Navigation pour le bouton 1
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => religions()),
        );
        break;
      case 7:
      // Navigation pour le bouton 1
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => languesloc()),
        );
        break;
      default:
        break;
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009FE3),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 300,
              height: 90,
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              'assets/images/visit.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'VISIT CONGO',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    buttonTexts.length,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Background color of the button
                          onPrimary: Colors.white, // Text color of the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                          ),
                        ),
                        onPressed: () => onButtonPressed(context, index),
                        child: Text(buttonTexts[index]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/images/congo.png'),
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
            label: 'Congo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Alert',
          ),
        ],
        selectedItemColor: Colors.blue,
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => EcranAccueil()),
                  (route) => false,
            );
          }
          if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  Visit()),
                  (route) => false,
            );
          }
          if (index == 2) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  Alert()),
                  (route) => false,
            );
          }

        },
      ),
    );
  }
}