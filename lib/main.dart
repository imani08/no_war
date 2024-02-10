import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'avant.dart';
import 'nitif.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialiser le plugin de notifications
  await Noti.initialize(flutterLocalNotificationsPlugin);

  // Afficher la notification au lancement de l'application
  await Noti.showBigTextNotification(
    title: 'NO WAR ALERT',
    body: 'La paix est essentielle car elle favorise la stabilité sociale.',
    fln: flutterLocalNotificationsPlugin,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NO WAR',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      // Naviguer vers la page Avant
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Avant()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/demar.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
