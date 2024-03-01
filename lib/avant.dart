import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart'; // Importer le package Firebase Storage
import 'Ecran acceuil.dart';

class Avant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageCarouselPage(),
    );
  }
}

class ImageCarouselPage extends StatefulWidget {
  @override
  _ImageCarouselPageState createState() => _ImageCarouselPageState();
}

class _ImageCarouselPageState extends State<ImageCarouselPage> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<String> _imagePaths = [];

  // Fonction pour récupérer les chemins des images depuis Firebase Storage
  Future<void> _fetchImagePaths() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    ListResult result = await storage.ref('scroll/').list();

    setState(() {
      _imagePaths = result.items.map((item) => item.fullPath).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchImagePaths(); // Récupérer les chemins des images depuis Firebase Storage
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
      if (_currentPage == _imagePaths.length - 1) {
        // Afficher le bouton "Commencer" lorsque toutes les images sont affichées
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Commencer'),
              content: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EcranAccueil()),
                  );
                },
                child: Text('Commencer'),
              ),
            );
          },
        );
      }
    });
    _showNextImage(); // Appeler la fonction au lancement de la page
  }

  void _showNextImage() {
    Timer(Duration(seconds: 2), () {
      if (_currentPage < _imagePaths.length - 1) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _showNextImage(); // Appeler récursivement pour l'image suivante
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image d'arrière-plan
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Remplacer par le chemin de votre image d'arrière-plan
                fit: BoxFit.cover,
              ),
            ),
          ),
          // GridView avec des images
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: _imagePaths.length,
            itemBuilder: (context, index) {
              return Image.network(
                _imagePaths[index],
                fit: BoxFit.cover,
              );
            },
          ),
          // Indicateurs en bas
          Positioned(
            bottom: 16.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicateurs = [];
    for (int i = 0; i < _imagePaths.length; i++) {
      indicateurs.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i ? Colors.white : Colors.grey,
          ),
        ),
      );
    }
    return indicateurs;
  }
}
