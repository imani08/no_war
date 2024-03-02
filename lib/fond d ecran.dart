import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class NosFonds extends StatelessWidget {
  Future<List<String>> _getAllImageUrls() async {
    List<String> imageUrls = [];
    try {
      final firebase_storage.ListResult result =
      await firebase_storage.FirebaseStorage.instance.ref('fonds').listAll();
      result.items.forEach((firebase_storage.Reference ref) async {
        String url = await ref.getDownloadURL();
        imageUrls.add(url);
      });
    } catch (e) {
      print('Erreur lors de la récupération des images : $e');
    }
    return imageUrls;
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
      body: FutureBuilder<List<String>>(
        future: _getAllImageUrls(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erreur : ${snapshot.error}');
          } else {
            List<String> urls = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: urls.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    await _showPreviewDialog(context, urls[index]);
                  },
                  child: Image.network(
                    urls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _showPreviewDialog(BuildContext context, String imageUrl) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF009FE3),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _setWallpaper(imageUrl);
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

  Future<void> _setWallpaper(String imageUrl) async {
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
          imageUrl,
          location,
        );
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
