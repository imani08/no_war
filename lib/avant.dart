import 'package:flutter/material.dart';
import 'dart:async';
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
  List<String> _imagePaths = [
    'assets/scroll/arial.jpg',
    'assets/scroll/bool.jpg',
    'assets/scroll/call.jpg',
    'assets/scroll/mams.jpg',
    'assets/scroll/sang.jpg',
    'assets/scroll/congo.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
      if (_currentPage == _imagePaths.length - 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EcranAccueil()),
        );
      }
    });
    _showNextImage(); // Appeler la fonction au lancement de la page
  }
  void _showNextImage() {
    //  passer à l'image suivante
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
      body: PageView.builder(
        controller: _pageController,
        itemCount: _imagePaths.length,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                _imagePaths[index],
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Text(
                  '→ →',
                  style: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
