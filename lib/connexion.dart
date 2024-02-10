import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Ecran acceuil.dart';

class loginpage extends StatefulWidget {
  loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF009FE3),
        title:

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,  // Largeur souhaitée de l'image
              height: 90, // Hauteur souhaitée de l'image
            ),
            SizedBox(width: 8),
          ],

        ),

      ),
      body: Padding(

        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Adresse mail',
                labelStyle: TextStyle(color: Colors.blue),
              ),

            ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'mot de passe avec 8 chiffres ',
                  labelStyle: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        User? user = userCredential.user;
                        print('Signed in: ${user!.uid}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EcranAccueil()));
                      } catch (e) {
                        print('Sign-in error: $e');
                      }
                    },

                    child: const Text('S\'enregistrer', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EcranAccueil())
                      );
                    },
                    child: const Text('Creer un compte', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Couleur de fond du bouton
                    ),

                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '''Enregistrez-vous à la communauté NO WAR,
Pour contribuer a une paix durable dans le monde''',
                style: TextStyle(color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}