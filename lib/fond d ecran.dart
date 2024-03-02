import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class NosFonds extends StatelessWidget {
  List<String> cheminImages = [
    'fonds/1.jpg',
    'fonds/2.jpg',
    'fonds/3.jpg',
    'fonds/4.jpg',
    'fonds/5.jpg',
    'fonds/6.jpg',
    'fonds/7.jpg',
    'fonds/8.jpg',
  ];
  Future<String> _getUrlImage(String chemin) async {
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(chemin);
    return await ref.getDownloadURL();
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
        itemCount: cheminImages.length,
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder<String>(
            future: _getUrlImage(cheminImages[index]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur : ${snapshot.error}');
              } else {
                String urlImage = snapshot.data!;
                return InkWell(
                  onTap: () async {
                    await _showPreviewDialog(context, urlImage);
                  },
                  child: Image.network(
                    urlImage,
                    fit: BoxFit.cover,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  }

  Future<void> _showPreviewDialog(
      BuildContext context, String cheminImage) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF009FE3),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                cheminImage,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _setWallpaper(cheminImage);
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
  Future<void> _setWallpaper(String  cheminImage) async {
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
            cheminImage, location);
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



