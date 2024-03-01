import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';



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

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _getLocation();
  }

  Future<void> _getUserInfo() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      setState(() {
        userName = user.displayName ?? "Unknown User";
        userEmail = user.email ?? "Unknown Email";
        profileImageUrl = user.photoURL ?? "";
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
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: profileImageUrl.isNotEmpty
                  ? NetworkImage(profileImageUrl)
                  : null, // Utilisez null si l'URL est vide
              child: profileImageUrl.isEmpty
                  ? Image.asset(
                'aassets/images/avatar.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
                  : null, // Utilisez null si l'URL n'est pas vide
            ),


            SizedBox(height: 16),
            Text('Name: $userName'),
            Text('Email: $userEmail'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _pickImageAndUpload('profile_images/');
              },
              child: Text('Change Profile Picture'),
            ),
            SizedBox(height: 16),
            CircleAvatar(
              radius: 50,
              backgroundImage: coverImageUrl.isNotEmpty
                  ? NetworkImage(coverImageUrl)
                  : null, // Utilisez null si l'URL est vide
              child: coverImageUrl.isEmpty
                  ? Image.asset(
                'assets/images/avatar.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
                  : null, // Utilisez null si l'URL n'est pas vide
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _pickImageAndUpload('cover_images/');
              },
              child: Text('Change Cover Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
