import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:telephony/telephony.dart'; // Importez le package telephony
import 'package:quick_actions/quick_actions.dart';

class Alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Alerts(),
    );
  }
}

class Alerts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' ALERTEZ LA POLICE,ET ENSEMBLE, CRÉONS UN MONDE PLUS SÛR',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF009FE3),
      ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/alert.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), // Vous pouvez ajuster l'opacité ici
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                Position position = await _getLocation();

                if (_isWithinRadius(position, 20.0)) {
                  _sendSecurityAlert(position);
                  _sendSMS(position);
                  _makePhoneCall();
                  _promptToAddShortcut();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Vous n'êtes pas dans le rayon de sécurité."),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Changez la couleur ici
                minimumSize: Size(150, 60),
              ),
              child: Text('ALERT ICI', style: TextStyle(fontSize: 19.0, color: Colors. white,fontWeight: FontWeight.bold),

              ),
            ),
          ),
        )

    );
  }

  Future<Position> _getLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  bool _isWithinRadius(Position position, double radius) {
    // Implémentez la logique pour vérifier si la position est dans le rayon
    // (par exemple, en utilisant la formule de distance entre deux points)
    // Retournez true si la position est dans le rayon, sinon false.
    return true;
  }

  void _sendSecurityAlert(Position position) {
    Telephony telephony = Telephony.instance; // Utilisez le package telephony
    String message = 'Au secours: je suis à - ${position.latitude}, ${position.longitude}';
    List<String> recipients = ['+243973431495', '+243810480302'];

    for (String recipient in recipients) {
      telephony.sendSmsByDefaultApp(to: recipient, message: message);
    }
  }

  void _sendSMS(Position position) async {
    String message = 'Au secours: je suis à - ${position.latitude}, ${position.longitude}';
    String uri = 'sms:?body=$message';

    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print('Impossible d\'envoyer un SMS.');
    }
  }

  void _makePhoneCall() async {
    List<String> phoneNumber = ['+243973431495', '+243810480302'];

    if (await canLaunch('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      print('Impossible de passer l\'appel.');
    }
  }

  void _promptToAddShortcut() {
    final quickActions = QuickActions();

    quickActions.initialize((type) {
      if (type == 'action_alert') {
        print('Alerte de sécurité lancée ');

      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: 'action_alert',
        localizedTitle: 'Lancer une alerte de sécurité',
        icon: 'Icons.warning', // Assurez-vous d'avoir une ressource d'icône appelée 'alert_icon' dans votre application
      ),
    ]);
  }
}
