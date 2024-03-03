import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fond d ecran.dart';
import 'Ecran acceuil.dart';
import 'visit.dart';
import 'alert.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class discussions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference().child('messages');

  String userName = "";
  String userEmail = "";
  String userCity = "";
  String userCountry = "";
  String profileImageUrl = "";
  String coverImageUrl = "";
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _getUserInfo();
    _getLocation();
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pas de connexion Internet'),
          content: Text('Veuillez vous connecter à Internet pour accéder à cette page.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Vous pouvez ajouter d'autres actions en fonction de vos besoins
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // L'utilisateur n'est pas connecté à Internet
      _showNoInternetDialog();
    }
  }






  Future<void> _getUserInfo() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        userName = user.displayName ?? "Unknown User";
        userEmail = user.email ?? "Unknown Email";
        profileImageUrl = prefs.getString('profileImageUrl') ?? "";
        coverImageUrl = prefs.getString('coverImageUrl') ?? "";
      });
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        userCity = placemarks.first.locality ?? "Unknown City";
        userCountry = placemarks.first.country ?? "Unknown Country";
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _uploadImageToStorage(File image, String storagePath) async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child(storagePath);
      await storageReference.putFile(image);
      String downloadURL = await storageReference.getDownloadURL();

      DatabaseReference imageRef =
      FirebaseDatabase.instance.reference().child('images');
      imageRef
          .child(user.uid)
          .child(storagePath == 'profile_images/'
          ? 'profileImageUrl'
          : 'coverImageUrl')
          .set(downloadURL);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
          storagePath == 'profile_images/' ? 'profileImageUrl' : 'coverImageUrl',
          downloadURL);

      setState(() {
        if (storagePath == 'profile_images/') {
          profileImageUrl = downloadURL;
        } else if (storagePath == 'cover_images/') {
          coverImageUrl = downloadURL;
        }
      });
    }
  }

  Future<void> _pickImageAndUpload(String storagePath) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _uploadImageToStorage(File(image.path), storagePath);
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
              width: 200, // Largeur souhaitée de l'image
              height: 90, // Hauteur souhaitée de l'image
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: coverImageUrl.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(coverImageUrl),
                      fit: BoxFit.cover,
                    )
                        : DecorationImage(
                      image: AssetImage('assets/images/avatar.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white,),
                  onPressed: () {
                    _pickImageAndUpload('cover_images/');
                  },
                ),
              ],
            ),

            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: profileImageUrl.isNotEmpty
                            ? Image.network(
                          profileImageUrl,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          'assets/images/avatar.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.white,),
                      onPressed: () {
                        _pickImageAndUpload('profile_images/');
                      },
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0), // Ajustez cette valeur selon vos besoins
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email: $userEmail',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Ville: $userCity',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Pays: $userCountry',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            Column(
              children: [
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(hintText: 'Faites nous part de vos soucis...'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _messagesRef.push().set({
                      'message': textEditingController.text,
                      'user': userEmail,
                    });
                    textEditingController.clear(); // Effacer le texte après l'envoi
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue), // Couleur de fond du bouton
                  ),
                  child: Text('Envoyer'),
                ),
              ],
            ),

          ],
        ),
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
        selectedIconTheme: IconThemeData(color: Colors.blue),
        unselectedIconTheme: IconThemeData(color: Colors.blue),
        selectedLabelStyle: TextStyle(color: Colors.blue),
        unselectedLabelStyle: TextStyle(color: Colors.blue),
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EcranAccueil()),
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
}
