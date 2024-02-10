import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoneyTransaction extends StatefulWidget {
  @override
  _MoneyTransactionState createState() => _MoneyTransactionState();
}

class _MoneyTransactionState extends State<MoneyTransaction> {
  String transactionStatus = '';

  Future<void> performTransaction() async {
    // Paramètres de la transaction
    String apiKey = 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkq3XbDI1s8Lu7SpUBP+bqOs/MC6PKWz6n/0UkqTiOZqKqaoZClI3BUDTrSIJsrN1Qx7ivBzsaAYfsB0CygSSWay4iyUcnMVEDrNVOJwtWvHxpyWJC5RfKBrweW9b8klFa/CfKRtkK730apy0Kxjg+7fF0tB4O3Ic9Gxuv4pFkbQIDAQAB';
    String phoneNumber = '+243973431495';
    double amount = 100.0;

    // Construire l'URL de l'API
    String apiUrl = 'https://openapiuat.airtel.africa/auth/oauth2/token';
    String url = '$apiUrl?apiKey=$apiKey&phoneNumber=$phoneNumber&amount=$amount';

    // Effectuer la requête HTTP
    http.Response response = await http.get(Uri.parse(url));

    // Analyser la réponse JSON
    Map<String, dynamic> data = jsonDecode(response.body);

    // Vérifier le statut de la transaction
    if (data['status'] == 'success') {
      setState(() {
        transactionStatus = 'Transaction réussie!';
      });
    } else {
      setState(() {
        transactionStatus = 'Échec de la transaction.';
      });
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
              width: 200,
              height: 90,
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '''Ne soyez pas indiferents face aux 
   victimes des conflits armées.
               
  Faites un don dès maintenant !!!''',
              style: TextStyle(fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: performTransaction,
              child: Image.asset(
                'assets/images/airtel.png',
                width: 50.0,
                height: 50.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(transactionStatus),
          ],
        ),
      ),
    );
  }
}
