import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class discussions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  List<Message> _messages = [];
  User? _user;
  String _userPhotoURL = '';
  String _userCity = '';

  @override
  void initState() {
    super.initState();
    _getUser();
    _subscribeToMessages();
  }
  void _subscribeToMessages() {
    FirebaseFirestore.instance.collection('messages').snapshots().listen((snapshot) {
      _messages.clear(); // Efface les messages existants pour éviter la duplication
      snapshot.docs.forEach((doc) {
        // Analyse les données depuis Firestore et crée des objets Message
        String senderId = doc['senderId'];
        String senderName = doc['senderName'];
        String text = doc['text'];

        Message message = Message(senderId, senderName, text);
        setState(() {
          _messages.add(message);
        });
      });
    });
  }

  void _getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      // Get user data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Get user location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get city from user's location
      String cityName = await _getCityFromLocation(position);

      setState(() {
        _user = user;
        _userPhotoURL = userSnapshot['photoURL'] ?? '';
        _userCity = cityName;
      });
    }
  }

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> _getCityFromLocation(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      return placemarks.first.locality ?? '';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _user != null ? Text(_user!.displayName ?? '') : Text('COMMUNAUTE NO WAR'),
        backgroundColor: Colors.blue,
        leading: _user != null
            ? IconButton(
          icon: CircleAvatar(
            backgroundImage:  AssetImage('assets/images/avatar.jpg'), // Placeholder image
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfilePage(user: _user!)),
            ).then((_) {
              // Refresh the user data after returning from the edit profile page
              _getUser();
            });
          },
        )
            : null,
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              // Handle displaying users in the same city
            },
          ),
        ],
        bottom: _user != null
            ? PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Ville: $_userCity',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        )
            : null,
      ),
    body: Container(
    color: Colors.white, // Définissez la couleur de fond sur le noir
    child: Column(
    children: [
    Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    ));
  }

  Widget _buildMessage(Message message) {
    bool isMyMessage = message.senderId == _user?.uid;
    return Container(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isMyMessage ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: AssetImage('assets/images/avatar.jpg'), // Placeholder image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.senderName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message.text),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Envoyer un message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty && _user != null) {
      Message newMessage = Message(_user!.uid, _user!.displayName ?? '', messageText);
      // Enregistre le message dans Firebase Firestore
      FirebaseFirestore.instance.collection('messages').add({
        'senderId': newMessage.senderId,
        'senderName': newMessage.senderName,
        'text': newMessage.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      setState(() {
        _messages.add(newMessage);
        _messageController.clear();
      });
    }
  }
}

class Message {
  final String senderId;
  final String senderName;
  final String text;

  Message(this.senderId, this.senderName, this.text);
}

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user data and populate the controllers
    // You can use FirebaseAuth or any other method to get user data
    _nameController.text = widget.user.displayName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le profil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _updateUserProfile();
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUserProfile() async {
    try {
      await widget.user.updateDisplayName(_nameController.text);

      // Update user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.uid)
          .update({'displayName': _nameController.text});

      // Refresh the user data in the parent page
      Navigator.pop(context, true); // Pass a result back to trigger refresh
    } catch (e) {
      print('Error updating user profile: $e');
    // Handle the error as needed
  }
}
}
