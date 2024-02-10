import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class villes extends StatelessWidget {
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
          initialUrl: 'https://fr.wikipedia.org/wiki/Liste_des_villes_de_la_r%C3%A9publique_d%C3%A9mocratique_du_Congo',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
