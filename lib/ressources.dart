import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class ressources  extends StatelessWidget {
  @override


  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF009FE3),
          title:

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 300,  // Largeur souhaitée de l'image
                height: 90, // Hauteur souhaitée de l'image
              ),
              SizedBox(width: 8),
            ],
          ),

        ),
        body:
        const WebView(
          initialUrl: 'https://www.investindrc.cd/fr/Ressources-naturelles-et-profil-geographique',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
