import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:permission_handler/permission_handler.dart';



class NosFonds extends StatelessWidget {
  List<String> wallpapers = [
    'assets/fonds d\'ecran/1.jpg',
    'assets/fonds d\'ecran/2.jpg',
    'assets/fonds d\'ecran/3.jpg',
    'assets/fonds d\'ecran/4.jpg',
    'assets/fonds d\'ecran/5.jpg',
    'assets/fonds d\'ecran/6.jpg',
    'assets/fonds d\'ecran/7.jpg',
    'assets/fonds d\'ecran/8.jpg',
    // Ajoutez ici les chemins de vos images de fond d'écran
  ];

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
              width: 200, // Largeur souhaitée de l'image
              height: 90, // Hauteur souhaitée de l'image
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: wallpapers.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () async {
              await _showPreviewDialog(context, wallpapers[index]);
            },
            child: Image.asset(
              wallpapers[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Future<void> _showPreviewDialog(
      BuildContext context, String wallpaperPath) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF009FE3),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                wallpaperPath,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _setWallpaper(wallpaperPath);
                  Navigator.pop(context);
                },
                child: Text('Appliquer'),
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> _setWallpaper(String wallpaperPath) async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // Demander la permission
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      // La permission est accordée, appliquer le fond d'écran
      int location = WallpaperManager.HOME_SCREEN;
      try {
        final result = await WallpaperManager.setWallpaperFromFile(
            wallpaperPath, location);
        if (result == WallpaperManager.HOME_SCREEN) {
          print('Fond d\'écran appliqué avec succès');
        } else {
          print('Erreur lors de l\'application du fond d\'écran');
        }
      } catch (e) {
        print('Erreur lors de la définition du fond d\'écran : $e');
      }
    } else {
      // La permission n'est pas accordée
      print('Permission de stockage refusée');
    }
  }
}

  
